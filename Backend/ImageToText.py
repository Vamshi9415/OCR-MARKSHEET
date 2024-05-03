import pytesseract
import cv2
import ImagePreprocessor
import os

class ImageToText:
    def __init__(self, tesseract_path):
        pytesseract.pytesseract.tesseract_cmd = tesseract_path

    def extract_text(self, image_path, output_file):
        img = cv2.imread(image_path)
        text = pytesseract.image_to_string(img)

        with open(output_file, "w", encoding="utf-8") as file:
            file.write(text)

        print(f"Text extracted from '{image_path}' and saved to '{output_file}'")

if __name__ == "__main__":
    tesseract_path = r"C:\Program Files\Tesseract-OCR\tesseract.exe"
    initial_image_path = "received_image.jpg"
    temp_image_path = "temp_binary_image.jpg"

    preprocessor = ImagePreprocessor.ImagePreprocessor(initial_image_path)
    preprocessor.preprocess_image()

    binary_image = preprocessor.get_binary_image()

    # Save the binary image to a temporary file
    cv2.imwrite(temp_image_path, binary_image)

    output_file = "input.txt"

    ocr = ImageToText(tesseract_path)
    ocr.extract_text("temp_image_path", output_file)

    # Remove the temporary file
    os.remove(temp_image_path)