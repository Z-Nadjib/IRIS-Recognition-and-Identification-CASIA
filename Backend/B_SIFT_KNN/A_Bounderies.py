import numpy as np
import cv2
import os
import sys
import math
import random
import copy
import inspect
from matplotlib import pyplot as plot


def identify_optimal_radius(circle_list):
    optimal_circle = None
    minimum_distance = None
    reference_circles = circle_list[:]
    comparison_circles = circle_list[:]
    for current_circle in reference_circles:
        total_distance = 0
        for compared_circle in comparison_circles:
            total_distance += math.fabs(float(current_circle[2]) - float(compared_circle[2]))
        if not minimum_distance or total_distance < minimum_distance:
            minimum_distance = total_distance
            optimal_circle = current_circle
    return optimal_circle[2]


def draw_detected_circles(colored_image, inner_circle, outer_circle,
                 center_range=None, radius_range=None):
    # draw the inner circle
    cv2.circle(colored_image,(inner_circle[0], inner_circle[1]), inner_circle[2],
                     (0,0,255),1)
    # draw the center of the inner circle
    cv2.circle(colored_image,(inner_circle[0],inner_circle[1]),1,(0,0,255),1)
    if center_range:
        # draw outer circle center range limit
        cv2.circle(colored_image,(inner_circle[0], inner_circle[1]), center_range,
                         (0,255,255),1)
    if radius_range:
        # draw outer circle radius range limit
        cv2.circle(colored_image,(inner_circle[0], inner_circle[1]), radius_range,
                         (0,255,255),1)
    # draw the outer circle
    cv2.circle(colored_image, (outer_circle[0], outer_circle[1]), 
               outer_circle[2],(0,255,0),1)
    # draw the center of the outer circle
    cv2.circle(colored_image, (outer_circle[0], outer_circle[1]), 
               1,(0,255,0),1)


def calculate_angle(x1, y1, x2, y2):
    return math.degrees(math.atan2(-(y2-y1),(x2-x1)))

def compute_distance(x1, y1, x2, y2):
    distance = math.sqrt((x2-x1)**2 + (y2-y1)**2)
    return distance

def compute_mean(values):
    total = 0.0
    for value in values:
        total += value
    return total/len(values)

def compute_median(values):
    return np.median(np.array(values))

def compute_standard_deviation(values):
    if not values:
        print('Error: empty list parameter in compute_standard_deviation() !')
        return None, None
    mean_value = compute_mean(values)
    sum_of_squares = 0.0
    for value in values:
        sum_of_squares += (value - mean_value) ** 2
    return mean_value, math.sqrt(sum_of_squares/len(values))

def within_circle(circle_col, circle_row, circle_radius, point_col, point_row):
    return compute_distance(circle_col, circle_row, point_col, point_row) <= circle_radius
    
def refine_circle_selection(circles):
    if not circles:
        print('Error: No circles found in refine_circle_selection() !')
        return []
    center_x_mean, center_x_dev = compute_standard_deviation([int(i[0]) for i in circles])
    center_y_mean, center_y_dev = compute_standard_deviation([int(i[1]) for i in circles])
    refined = []
    positions = []
    unrefined = []
    deviation_multiplier = 1.5 
    for circle in circles[:]:
        if circle[0] < center_x_mean - deviation_multiplier*center_x_dev or \
           circle[0] > center_x_mean + deviation_multiplier*center_x_dev or \
           circle[1] < center_y_mean - deviation_multiplier*center_y_dev or \
           circle[1] > center_y_mean + deviation_multiplier*center_y_dev:
            unrefined.append(circle)
        else:
            positions.append(circle)
    if len([float(c[2]) for c in positions]) < 3:
        refined = positions
    else:
        optimal_radius = identify_optimal_radius(positions)
        mean_radius, radius_deviation = compute_standard_deviation(
                                    [float(c[2]) for c in positions])
        max_radius = optimal_radius + radius_deviation
        min_radius = optimal_radius - radius_deviation
        for circle in positions:
            if circle[2] < min_radius or \
               circle[2] > max_radius:
                unrefined.append(circle)
            else:
                refined.append(circle)

    return refined    

def calculate_average_circle(circles):
    if not circles:
        return
    average_x = int(np.mean([c[0] for c in circles]))
    average_y = int(np.mean([c[1] for c in circles]))
    average_radius = int(np.mean([c[2] for c in circles]))

    return average_x, average_y, average_radius



def detect_outer_circle(image, inner_circle, center_range, radius_range):
    def extract_edges(processed_image, upper_threshold):
        lower_threshold = 0  # Fixed low threshold for Canny
        edges = cv2.Canny(processed_image, lower_threshold, upper_threshold, apertureSize=5)
        kernel = np.ones((3,3),np.uint8)
        edges = cv2.dilate(edges, kernel, iterations=1)
        blur_size = 2 * random.randrange(5,11) + 1
        edges = cv2.GaussianBlur(edges,(blur_size,blur_size),0)
        return edges

    def find_circles(hough_threshold, median_sizes, edge_thresholds):
        detected_circles = []
        for median_size, upper_threshold in [(m, t) for m in median_sizes for t in edge_thresholds]:
            # Apply median blur
            median_blurred = cv2.medianBlur(image, 2 * median_size + 1)

            # Extract edges
            edges = extract_edges(median_blurred, upper_threshold)

            # Detect circles using Hough transform
            circles = cv2.HoughCircles(edges, cv2.HOUGH_GRADIENT, 1, 20,
                                       param1=200, param2=hough_threshold, minRadius=0, maxRadius=0)
            if circles is not None and circles.size > 0:
                # Convert the circle parameters to integers
                circles = np.round(circles[0, :]).astype("int")
                for (col, row, radius) in circles:
                    if within_circle(inner_circle[0], inner_circle[1], center_range, col, row) and radius > radius_range:
                        detected_circles.append((col, row, radius))
        return detected_circles

    circle_param2 = 120  # Starting threshold for HoughCircles
    all_circles = []
    while(circle_param2 > 40 and len(all_circles) < 50):
        circles = find_circles(
                        circle_param2, [8,10,12,14,16,18,20], [430,480,530])
        if circles:
            all_circles += circles
        circle_param2 = circle_param2 -1

    if not all_circles:
        print("Alternative strategy for detecting outer iris circle")
        circle_param2 = 120
        while(circle_param2 > 40 and len(all_circles) < 50):
            circles = find_circles(
                            circle_param2, [3,5,7,21,23,25], [430,480,530])
            if circles:
                all_circles += circles
            circle_param2 = circle_param2 -1

    if not all_circles:
        return

    color_image = cv2.cvtColor(image,cv2.COLOR_GRAY2BGR)
    refined_circles = refine_circle_selection(all_circles)

    return calculate_average_circle(refined_circles)

def detect_inner_circle(image):
    def extract_edges(processed_image):
        edges = cv2.Canny(processed_image, 20, 100)
        kernel = np.ones((3,3), np.uint8)
        edges = cv2.dilate(edges, kernel, iterations=2)
        blur_size = 2 * random.randrange(5, 11) + 1
        edges = cv2.GaussianBlur(edges, (blur_size, blur_size), 0)
        return edges

    circle_param1 = 200  # High threshold for Canny
    circle_param2 = 120  # Accumulator threshold for circle detection
    candidate_circles = []
    while(circle_param2 > 35 and len(candidate_circles) < 100):
        for median_filter_size, threshold in [(m, t) for m in [3, 5, 7] for t in [20, 25, 30, 35, 40, 45, 50, 55, 60]]:
            # Apply median blur
            blurred = cv2.medianBlur(image, 2 * median_filter_size + 1)

            # Apply threshold
            _, binary_image = cv2.threshold(blurred, threshold, 255, cv2.THRESH_BINARY_INV)

            # Fill contours
            contours, _ = cv2.findContours(binary_image.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
            filled_contours = cv2.drawContours(binary_image, contours, -1, (255), -1)

            # Extract edges
            edges = extract_edges(binary_image)

            # Detect circles using Hough transform
            circles = cv2.HoughCircles(edges, cv2.HOUGH_GRADIENT, 1, 1, np.array([]), circle_param1, circle_param2)
            if circles is not None and circles.size > 0:
                # Convert the circle parameters to integers
                circles = np.round(circles[0, :]).astype("int")
                for circle in circles:
                    candidate_circles.append(circle)

        circle_param2 = circle_param2 - 1

    if len(candidate_circles) == 0:
        print("No inner circles detected.")
        return None

    return calculate_average_circle(candidate_circles)


def locate_iris_boundaries(image, display=True):
    inner_circle = detect_inner_circle(image)

    if not inner_circle:
        print('ERROR: Inner circle not found!')
        return None, None

    radius_expansion = int(math.ceil(inner_circle[2]*1.5))
    expansion_factor = 0.25
    range_center = int(math.ceil(inner_circle[2]*expansion_factor)) 
    outer_circle = detect_outer_circle(
                        image, inner_circle, range_center, radius_expansion)

    while(not outer_circle and expansion_factor <= 0.7):
        expansion_factor += 0.05
        print('Searching outer iris circle with expansion factor ' + str(expansion_factor))

        range_center = int(math.ceil(inner_circle[2]*expansion_factor))
        outer_circle = detect_outer_circle(image, inner_circle,
                                        range_center, radius_expansion)
    if not outer_circle:
        print('ERROR: Outer iris circle not found!')
        return None, None
    
    if display:
        color_image = cv2.cvtColor(image,cv2.COLOR_GRAY2BGR)
        draw_detected_circles(color_image, inner_circle, outer_circle)
        cv2.imshow('iris boundaries', color_image)
        char = cv2.waitKey(0)
        cv2.destroyAllWindows()

    return inner_circle, outer_circle
