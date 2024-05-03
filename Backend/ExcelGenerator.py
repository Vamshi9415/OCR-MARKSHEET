import csv
import openpyxl

class ExcelGenerator:
    def __init__(self, csv_file):
        self.csv_file = csv_file

    def generate_excel(self, output_file):
        with open(self.csv_file, 'r') as csvfile:
            reader = csv.DictReader(csvfile)

            workbook = openpyxl.Workbook()
            worksheet = workbook.active

            headers = reader.fieldnames
            worksheet.append(headers)

            for row in reader:
                worksheet.append([row[header] for header in headers])

        workbook.save(output_file)