from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
import base64
import binascii
from dotenv import load_dotenv, find_dotenv
import os
load_dotenv(find_dotenv())
def decrypt_aes_file(file_path, key_base64: str, iv_base64: str, output_html: str = "output.html"):
    # Giải mã base64 cho key và iv
    try:
        key = base64.b64decode(key_base64)
        iv = bytes.fromhex(iv_base64)
    except binascii.Error as e:
        print("❌ Key hoặc IV không phải là base64 hợp lệ:", e)
        return

    # Kiểm tra độ dài key và iv
    if len(key) not in [16, 24, 32]:
        print(f"❌ Độ dài key không hợp lệ: {len(key)} bytes. Cần 16, 24 hoặc 32.")
        return
    if len(iv) != 16:
        print(f"❌ Độ dài IV không hợp lệ: {len(iv)} bytes. Cần đúng 16.")
        return

    # Đọc và kiểm tra nội dung mã hóa trong file
    with open(file_path, "r", encoding="utf-8") as file:
        encrypted_base64 = file.read().strip()

    try:
        encrypted_bytes = base64.b64decode(encrypted_base64, validate=True)
        print("✅ Nội dung trong file là chuỗi Base64 hợp lệ.")
    except binascii.Error as e:
        print("❌ Nội dung trong file không phải là Base64 hợp lệ:", e)
        return

    try:
        # Tạo AES cipher
        cipher = AES.new(key, AES.MODE_CBC, iv)

        # Giải mã và loại bỏ padding
        decrypted_bytes = unpad(cipher.decrypt(encrypted_bytes), AES.block_size)
        html_content = decrypted_bytes.decode("utf-8")

        # Ghi ra file HTML
        with open(output_html, "w", encoding="utf-8") as f:
            f.write(html_content)

        print(f"✅ HTML đã được giải mã và lưu vào: {output_html}")
    except Exception as e:
        print("❌ Lỗi khi giải mã AES:", e)


# Ví dụ sử dụng (bạn thay thế chuỗi bên dưới bằng giá trị thực tế từ server/.env)
key_base64 = os.getenv("AES_KEY")  # nếu key là chuỗi base64 thì cần decode
iv_base64 = os.getenv("AES_IV")  # nếu iv là chuỗi hex thì cần decode
decrypt_aes_file("a.txt", key_base64, iv_base64)
