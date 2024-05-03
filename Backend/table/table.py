import cv2
import pytesseract
import csv

# Load the image
img = cv2.imread('table.png')

# Preprocess the image
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
blur = cv2.GaussianBlur(gray, (5, 5), 0)
thresh = cv2.adaptiveThreshold(blur, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 30)

cv2.imwrite('thresh.jpg', thresh)

contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

print(contours,hierarchy)

contour_img=cv2.drawContours(img, contours, -1, (0,255,0), 3)
cv2.imshow("contour",contour_img)
cv2.waitKey(0)
cv2.destroyAllWindows()

