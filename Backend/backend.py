import main
from flask import Flask, request, send_file
import base64
import os

app = Flask(__name__)

@app.route('/upload-image', methods=['POST'])
def upload_image():
    try:
        base64_image = request.form['image']
        image_data = base64.b64decode(base64_image)

        # Save the image data to a file or process it as needed
        with open('received_image.jpg', 'wb') as f:
            f.write(image_data)
        print('Image received and saved successfully')

        # Call your main function to generate the output.xml file
        main.main()
        print('Main function executed successfully')

        # Read the output.xml file
        with open('output1.xml', 'r') as f:
            xml_data = f.read()

        print(xml_data)
        print('Sending output.xml file...')
        return xml_data, 200

    except Exception as e:
        print('Error:', e)
        return 'Failed to process image', 500
    
if __name__ == '__main__':
 app.run(host='0.0.0.0')