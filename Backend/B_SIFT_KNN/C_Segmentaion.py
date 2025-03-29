import numpy as np
import cv2
import os
import sys
import math
import random
import copy
import inspect
from matplotlib import pyplot as plot

def within_circle(circle_col, circle_row, circle_radius, point_col, point_row):
    return compute_distance(circle_col, circle_row, point_col, point_row) <= circle_radius
    
def compute_distance(x1, y1, x2, y2):
    distance = math.sqrt((x2-x1)**2 + (y2-y1)**2)
    return distance

def segment_regions(image, inner_circle, outer_circle, display=True):
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


