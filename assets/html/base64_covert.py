import base64

def convert_html_to_base64(file_path):
    try:
        with open(file_path, 'rb') as file:  
            html_content = file.read()

        base64_encoded = base64.b64encode(html_content).decode('utf-8')

        return base64_encoded
    except FileNotFoundError:
        print(f"Error: File not found at path: {file_path}")
    except Exception as e:
        print(f"Error converting HTML to Base64: {e}")

html_file_path = 'assets/html/exam_img_binary.html'

if __name__ == "__main__":
    try:
        base64_string = convert_html_to_base64(html_file_path)
        if base64_string:
            print("Base64 representation of the HTML file:")
            print(base64_string)
    except Exception as e:
        print(f"Failed to process the file: {e}")