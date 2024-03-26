from flask import Flask, request
import base64

app = Flask(__name__)

@app.route('/upload-image', methods=['POST'])
def upload_image():
    base64_image = request.form['image']
    image_data = base64.b64decode(base64_image)

    # Save the image data to a file or process it as needed
    with open('received_image.jpg', 'wb') as f:
        f.write(image_data)

    return 'Image received successfully'

if __name__ == '__main__':
    app.run()