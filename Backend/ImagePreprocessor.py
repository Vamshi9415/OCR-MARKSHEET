import cv2
import easyocr

class ImagePreprocessor:
    def __init__(self, image_path):
        self.image_path = image_path
        self.img = None
        self.gray = None
        self.binary = None

    def preprocess_image(self):
        # Read the image
        self.img = cv2.imread(self.image_path)

        # Convert to grayscale
        self.gray = cv2.cvtColor(self.img, cv2.COLOR_BGR2GRAY)
        _, self.binary = cv2.threshold(self.gray, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

    def save_images(self):
        cv2.imwrite('binary_image.jpg', self.binary)

    def get_binary_image(self):
        return self.binary
    def image_path(self):
        return  "binary_image.jpg"

if __name__ == "__main__":
    image_path = 'minor2.jpg'
    preprocessor = ImagePreprocessor(image_path)
    preprocessor.preprocess_image()
    preprocessor.save_images()