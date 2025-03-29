import numpy as np
import cv2
import os
import sys
import math
import random

import copy
import inspect
from matplotlib import pyplot as plot


def extract_regions(image_path):
    image = read_image(image_path, display=False)

    print("Identifying iris boundaries...")
    inner_circle, outer_circle = locate_iris_boundaries(image, display=False)
    if not inner_circle or not outer_circle:
        print("Error locating iris boundaries!")
        return

    print("Equalizing histogram...")
    region = equalize_iris_region(image, outer_circle, inner_circle, display=False)

    print("Extracting iris region images...")
    regions = segment_regions(region, inner_circle, outer_circle, display=False)

    print("Detecting keypoints...")
    sift_engine = sift = cv2.SIFT_create()
    detect_keypoints(sift_engine, regions, display=False)
    compute_descriptors(sift_engine, regions)  

    return regions

def read_image(image_path, display=False):
    image = cv2.imread(image_path, 0)
    if display:
        cv2.imshow(image_path, image)
        char = cv2.waitKey(0)
        cv2.destroyAllWindows()
    return image

def locate_iris_boundaries(image, display=False):
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
        draw_detected_circles(color_image, inner_circle, outer_circle,
                     range_center, radius_expansion)
        cv2.imshow('iris boundaries', color_image)
        char = cv2.waitKey(0)
        cv2.destroyAllWindows()

    return inner_circle, outer_circle

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


def calculate_average_circle(circles):
    if not circles:
        return
    average_x = int(np.mean([c[0] for c in circles]))
    average_y = int(np.mean([c[1] for c in circles]))
    average_radius = int(np.mean([c[2] for c in circles]))

    return average_x, average_y, average_radius
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
    
def equalize_iris_region(image, outer_circle, inner_circle, display=False):
    def locate_roi():
        mask = image.copy()
        mask[:] = (0)

        cv2.circle(mask, 
                   (outer_circle[0], outer_circle[1]), 
                   outer_circle[2], (255), -1)
        cv2.circle(mask,
                   (inner_circle[0],inner_circle[1]),
                   inner_circle[2],(0), -1)

        region_of_interest = cv2.bitwise_and(image, mask)

        return region_of_interest

    region_of_interest = locate_roi()

    # Mask the top part of the iris
    for column_index in range(region_of_interest.shape[1]):
        for row_index in range(region_of_interest.shape[0]):
            angle = calculate_angle(outer_circle[0], outer_circle[1], 
                            column_index, row_index)
            if angle > 50 and angle < 130:
                region_of_interest[row_index,column_index] = 0

    _, region_of_interest = cv2.threshold(region_of_interest,50,255,cv2.THRESH_TOZERO)

    equalized_region = region_of_interest.copy()
    cv2.equalizeHist(region_of_interest, equalized_region)
    region_of_interest = cv2.addWeighted(region_of_interest, 0.0, equalized_region, 1.0, 0)

    if display:
        cv2.imshow('equalized histogram iris region', region_of_interest)
        char = cv2.waitKey(0)
        cv2.destroyAllWindows()

    return region_of_interest
    
def segment_regions(image, inner_circle, outer_circle, display=False):
    background = image.copy()
    background[:] = 0

    regions = {'entire': {'image': background.copy(),
                          'inner_circle': inner_circle,
                          'outer_circle': outer_circle,
                          'keypoints': None,
                          'image_with_keypoints': background.copy(),
                          'image_with_filtered_keypoints': background.copy(),
                          'descriptors': None
                         }}

    for column_index in range(image.shape[1]):
        for row_index in range(image.shape[0]):
            if not within_circle(inner_circle[0], inner_circle[1], inner_circle[2], column_index, row_index) and \
               within_circle(outer_circle[0], outer_circle[1], outer_circle[2], column_index, row_index):
                regions['entire']['image'][row_index,column_index] = image[row_index,column_index]

    regions['entire']['outer_circle'] = (int(1.25*outer_circle[2]), 
                                         int(1.25*outer_circle[2]),
                                         int(outer_circle[2]))
    translate_x = regions['entire']['outer_circle'][0] - outer_circle[0]
    translate_y = regions['entire']['outer_circle'][1] - outer_circle[1]
    regions['entire']['inner_circle'] = (int(translate_x + inner_circle[0]),
                                         int(translate_y + inner_circle[1]),
                                         int(inner_circle[2]))

    translation_matrix = np.float32([[1,0,translate_x],[0,1,translate_y]])
    regions['entire']['image'] = cv2.warpAffine(
                        regions['entire']['image'], translation_matrix, 
                        (image.shape[1], image.shape[0]))

    regions['entire']['image'] = regions['entire']['image'][0:int(2.5 * outer_circle[2]), 0:int(2.5 * outer_circle[2])]

    if display:
        plot.imshow(regions['entire']['image'], cmap='gray')
        plot.title('Entire'), plot.xticks([]), plot.yticks([])
        plot.show()

    return regions


def detect_keypoints(sift_engine, regions, display=False):    
    all_keypoints = sift_engine.detect(regions['entire']['image'], None)
    valid_keypoints = []
    for keypoint in all_keypoints:
        x, y = keypoint.pt
        if within_circle(regions['entire']['outer_circle'][0], regions['entire']['outer_circle'][1], regions['entire']['outer_circle'][2], x, y) and \
           not within_circle(regions['entire']['inner_circle'][0], regions['entire']['inner_circle'][1], regions['entire']['inner_circle'][2], x, y):
            valid_keypoints.append(keypoint)
    regions['entire']['keypoints'] = valid_keypoints

    regions['entire']['image_with_keypoints'] = cv2.drawKeypoints(
                                    regions['entire']['image'], regions['entire']['keypoints'],
                                    color=(0,255,0), flags=0,
                                    outImage=None)
    if display:
        plot.imshow(cv2.cvtColor(regions['entire']['image_with_keypoints'], cv2.COLOR_BGR2RGB))
        plot.title('Entire Region with KeyPoints')
        plot.axis('off')
        plot.show()


def compute_descriptors(sift_engine, regions):
    regions['entire']['keypoints'], regions['entire']['descriptors'] = sift_engine.compute(regions['entire']['image'], regions['entire']['keypoints'])
    if regions['entire']['descriptors'] is not None:
        print(f"Entire Region, Descriptor Dimensions: {regions['entire']['descriptors'].shape}")
    else:
        print("Entire Region, No descriptors found.")



def match_all_regions(regions_one, regions_two, ratio_threshold, angle_standard_deviation, distance_standard_deviation, display=False):
    if display:
        plot.figure(figsize=(10, 5))
        plot.title('Keypoint Matches')

    if not regions_one['entire']['keypoints'] or not regions_two['entire']['keypoints']:
        print("KeyPoints not found in one or both images for entire region!!!")
        return 0

    matches = find_matches(regions_one['entire'], regions_two['entire'], ratio_threshold, angle_standard_deviation, distance_standard_deviation)
    if display:
        if matches:
            matches_to_draw = [[m] for m in matches]
            matched_image = cv2.drawMatchesKnn(
                regions_one['entire']['image'], regions_one['entire']['keypoints'],
                regions_two['entire']['image'], regions_two['entire']['keypoints'],
                matches_to_draw, None, flags=2)
            matched_image_rgb = cv2.cvtColor(matched_image, cv2.COLOR_BGR2RGB)
            plot.imshow(matched_image_rgb)
            plot.title(f'Matches in Entire Region')
            plot.axis('off')
        else:
            print("No matches to draw for entire region")

        plot.show()
    print(f"Total matches found: {len(matches)}") 

    return len(matches)



def find_matches(region_one, region_two, ratio_threshold, angle_deviation_threshold, distance_deviation_threshold):    
    if not region_one['keypoints'] or not region_two['keypoints']:
        print("KeyPoints not found in one of region_x['keypoints'] !!!")
        return []

    matcher = cv2.BFMatcher()
    raw_matches = matcher.knnMatch(region_one['descriptors'], region_two['descriptors'], k=2)
    print(f"Raw matches found: {len(raw_matches)}")
    kp1 = region_one['keypoints']
    kp2 = region_two['keypoints']

    distance_diff_one = region_one['outer_circle'][2] - region_one['inner_circle'][2]
    distance_diff_two = region_two['outer_circle'][2] - region_two['inner_circle'][2]

    angle_differences = []
    distance_differences = []
    filtered_matches = []
    for m,n in raw_matches:
        if (m.distance/n.distance) > ratio_threshold:
            continue
        
        x1,y1 = kp1[m.queryIdx].pt
        x2,y2 = kp2[m.trainIdx].pt

        angle_one = calculate_angle(
                x1,y1,
                region_one['inner_circle'][0],
                region_one['inner_circle'][1])
        angle_two = calculate_angle(
                x2,y2,
                region_two['inner_circle'][0],
                region_two['inner_circle'][1])
        angle_difference = angle_one - angle_two
        angle_differences.append(angle_difference)

        distance_one = compute_distance(x1,y1,
                          region_one['inner_circle'][0],
                          region_one['inner_circle'][1])
        distance_one = distance_one - region_one['inner_circle'][2]
        distance_one = distance_one / distance_diff_one
        
        distance_two = compute_distance(x2,y2,
                          region_two['inner_circle'][0],
                          region_two['inner_circle'][1])
        distance_two = distance_two - region_two['inner_circle'][2]
        distance_two = distance_two / distance_diff_two

        distance_difference = distance_one - distance_two
        distance_differences.append(distance_difference)
        
        filtered_matches.append(m)

    if filtered_matches:
        median_angle_difference = compute_median(angle_differences)
        median_distance_difference = compute_median(distance_differences)
        for match in filtered_matches[:]:
            x1,y1 = kp1[match.queryIdx].pt
            x2,y2 = kp2[match.trainIdx].pt

            angle_one = calculate_angle(
                x1,y1,
                region_one['inner_circle'][0],
                region_one['inner_circle'][1])
            angle_two = calculate_angle(
                x2,y2,
                region_two['inner_circle'][0],
                region_two['inner_circle'][1])
            angle_difference = angle_one - angle_two

            within_angle_limits = \
                (angle_difference > median_angle_difference - angle_deviation_threshold and \
                 angle_difference < median_angle_difference + angle_deviation_threshold)

            distance_one = compute_distance(x1,y1,
                              region_one['inner_circle'][0],
                              region_one['inner_circle'][1])
            distance_one = distance_one - region_one['inner_circle'][2]
            distance_one = distance_one / distance_diff_one
        
            distance_two = compute_distance(x2,y2,
                              region_two['inner_circle'][0],
                              region_two['inner_circle'][1])
            distance_two = distance_two - region_two['inner_circle'][2]
            distance_two = distance_two / distance_diff_two

            distance_difference = distance_one - distance_two
            within_distance_limits = (distance_difference > median_distance_difference - distance_deviation_threshold and \
                         distance_difference < median_distance_difference + distance_deviation_threshold)
                
            if within_angle_limits and within_distance_limits:
                continue

            filtered_matches.remove(match)

    return filtered_matches

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


def inspect_region_information(regions):
    data = regions['entire']
    print("Region: Entire")
    print(f"Image dimensions: {data['image'].shape}")
    print(f"Number of keypoints: {len(data['keypoints'])}")


def serialize_keypoints(keypoints):
    return [{'pt': keypoint.pt, 'size': keypoint.size, 'angle': keypoint.angle,
             'response': keypoint.response, 'octave': keypoint.octave, 'class_id': keypoint.class_id}
            for keypoint in keypoints]
def deserialize_keypoints(serialized_keypoints):
    return [cv2.KeyPoint(x=kp['pt'][0], y=kp['pt'][1], size=kp['size'], angle=kp['angle'],
                         response=kp['response'], octave=kp['octave'], class_id=kp['class_id'])
            for kp in serialized_keypoints]

import os
import cv2
import pickle

def preprocess_and_serialize(dataset_path, output_path):
    for person_id in sorted(os.listdir(dataset_path)):
        person_path = os.path.join(dataset_path, person_id)
        if os.path.isdir(person_path):
            images = sorted(os.listdir(person_path))
            if images:  # Check if there are any images in the directory
                image_name = images[0]  # Only take the first image
                image_path = os.path.join(person_path, image_name)
                region_data = extract_regions(image_path)
                if region_data:
                    region_data['entire']['keypoints'] = serialize_keypoints(region_data['entire']['keypoints'])
                    serialized_file_path = os.path.join(output_path, f"{person_id}_{image_name}.pkl")
                    with open(serialized_file_path, 'wb') as f:
                        pickle.dump(region_data, f)
                        print(f"Serialized data for {person_id} saved to {serialized_file_path}")



# Example usage
dataset_path = 'Backend\A_Data\Raw_Data'
output_path = 'Backend\B_SIFT_knn_bfm/3_DATA_modele_data_base'
preprocess_and_serialize(dataset_path, output_path)
