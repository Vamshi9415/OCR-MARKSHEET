import xml.etree.ElementTree as ET

class XMLGenerator:
    def __init__(self, grouped_matches, descriptions, marks, co_numbers, level_matches):
        self.grouped_matches = grouped_matches
        self.descriptions = descriptions
        self.marks = marks
        self.co_numbers = co_numbers
        self.level_matches = level_matches

    def generate_xml(self, output_file):
        root = ET.Element("questions")

        question_numbers = []
        sub_questions = []
        for question, sub_questions_list in self.grouped_matches.items():
            for sub_question in sub_questions_list:
                question_numbers.append(question)
                sub_questions.append(sub_question)

        for question_number, description, sub_question, level_match, co_match, marks_match in zip(
            question_numbers, self.descriptions, sub_questions, self.level_matches, self.co_numbers, self.marks
        ):
            question_element = ET.SubElement(root, "question")
            question_element.set("number", question_number)

            sub_question_element = ET.SubElement(question_element, "sub_question")
            sub_question_element.text = sub_question

            description_element = ET.SubElement(question_element, "description")
            description_element.text = description

            level_element = ET.SubElement(question_element, "level")
            level_element.text = level_match

            co_element = ET.SubElement(question_element, "Co")
            co_element.text = str(co_match)

            marks_element = ET.SubElement(question_element, "Marks")
            marks_element.text = str(marks_match)

        tree = ET.ElementTree(root)
        tree.write(output_file, encoding="utf-8", xml_declaration=True)