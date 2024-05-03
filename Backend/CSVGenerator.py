import csv
import xml.etree.ElementTree as ET

class CSVGenerator:
    def __init__(self, xml_file):
        self.tree = ET.parse(xml_file)
        self.root = self.tree.getroot()

    def generate_csv(self, output_file):
        with open(output_file, 'w', newline='') as csvfile:
            fieldnames = ['question_number', 'sub_question', 'description', 'level', 'Co', "Marks"]
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

            writer.writeheader()

            for question in self.root.findall('question'):
                question_number = question.get('number')
                sub_question = question.find('sub_question').text
                description = question.find('description').text
                level = question.find('level').text
                Co = question.find('Co').text
                Marks = question.find('Marks').text

                writer.writerow({
                    'question_number': question_number,
                    'sub_question': sub_question,
                    'description': description,
                    'level': level,
                    'Co': Co,
                    'Marks': int(Marks)
                })