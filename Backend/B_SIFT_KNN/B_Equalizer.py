import numpy as np
import cv2
import os
import sys
import math
import random
import copy
import inspect
from matplotlib import pyplot as plot

def calculate_angle(x1, y1, x2, y2):
    return math.degrees(math.atan2(-(y2-y1),(x2-x1)))

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

