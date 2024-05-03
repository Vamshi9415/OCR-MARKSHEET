import os
import cv2
import pytesseract
import ImagePreprocessor
from ImageToText import ImageToText 
import QuestionExtractor
import XMLGenerator
import CSVGenerator
import ExcelGenerator

def main():
    # Image preprocessing
    initial_image_path = "received_image.jpg"
    tesseract_path = r"C:\Program Files\Tesseract-OCR\tesseract.exe"
    temp_image_path = "temp_binary_image.jpg"

    preprocessor = ImagePreprocessor.ImagePreprocessor(initial_image_path)
    preprocessor.preprocess_image()
    binary_image = preprocessor.get_binary_image()
    cv2.imwrite(temp_image_path, binary_image)

    # OCR (Optical Character Recognition)
    output_file = "input.txt"
    ocr = ImageToText(tesseract_path)
    ocr.extract_text(temp_image_path, output_file)

    # Remove the temporary binary image file
    os.remove(temp_image_path)

    # Extract questions, descriptions, marks, CO, and level
    # with open(output_file, "r", encoding="utf-8") as file:
    #     input_text = file.read()
    with open("input.txt", "r") as file:
        Binput_text = file.read()

# Remove newline characters and extra spaces
    Binput_text = Binput_text.replace("\n", " ").replace("  ", "")

# Write modified text back to the output file
    with open("output.txt", "w") as file:
        file.write(Binput_text)
    
    with open("output.txt","r",encoding="utf-8") as file:
        input_text=file.read()

    question_extractor = QuestionExtractor.QuestionExtractor(input_text)
    grouped_matches = question_extractor.extract_questions()
    descriptions = question_extractor.extract_descriptions()
    marks = question_extractor.extract_marks()
    co_numbers = question_extractor.extract_co()
    level_matches = question_extractor.extract_level()

    # Generate XML
    xml_generator = XMLGenerator.XMLGenerator(grouped_matches, descriptions, marks, co_numbers, level_matches)
    xml_output_file = "output1.xml"
    xml_generator.generate_xml(xml_output_file)

    # Generate CSV
    csv_generator = CSVGenerator.CSVGenerator(xml_output_file)
    csv_output_file = "output1.csv"
    csv_generator.generate_csv(csv_output_file)

    # Generate Excel
    excel_generator = ExcelGenerator.ExcelGenerator(csv_output_file)
    excel_output_file = "output3.xlsx"
    excel_generator.generate_excel(excel_output_file)
