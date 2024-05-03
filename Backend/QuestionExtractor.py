import re

class QuestionExtractor:
    def __init__(self, input_text):
        self.input_text = input_text

    def extract_questions(self):
        regex_questions = r"(?:(\d+)\.\s*)?\((a|b)\)"
        question_matches = re.findall(regex_questions, self.input_text)

        grouped_matches = {}
        for question, sub_question in question_matches:
            if question:
                if question not in grouped_matches:
                    grouped_matches[question] = []
                grouped_matches[question].append(sub_question)
            else:
                if grouped_matches:
                    previous_question = list(grouped_matches.keys())[-1]
                    grouped_matches[previous_question].append(sub_question)
                else:
                    grouped_matches["1"] = [sub_question]

        return grouped_matches

    def extract_descriptions(self):
        regex_descriptions = r"\((?:a|b)\)\s*(.+?)\s*\(\d+M\)"
        matches = re.findall(regex_descriptions, self.input_text)
        return [match.strip() for match in matches]

    def extract_marks(self):
        regex_marks = r"\((\d+)M\)"
        marks_matches = re.findall(regex_marks, self.input_text)
        return [int(mark) for mark in marks_matches]

    def extract_co(self):
        regex_co = r"CO-(\d+)"
        co_matches = re.findall(regex_co, self.input_text)
        return [int(match) for match in co_matches]

    def extract_level(self):
        regex_level = r"Level-\d+"
        level_matches = re.findall(regex_level, self.input_text)
        return level_matches