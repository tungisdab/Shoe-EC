import os
from PIL import Image

def convert_and_rename_images_to_png():
    # Lấy đường dẫn đến thư mục hiện tại
    folder_path = os.path.dirname(os.path.abspath(__file__))
    
    # Lấy danh sách các tệp trong thư mục
    files = os.listdir(folder_path)
    
    # Lọc các tệp có định dạng hình ảnh
    image_files = [file for file in files if file.lower().endswith(('.jpg', '.jpeg', '.png'))]
    
    # Đổi tên và chuyển đổi các tệp sang PNG
    for index, file in enumerate(image_files):
        old_file_path = os.path.join(folder_path, file)
        new_file_name = f"a{index}.png"
        new_file_path = os.path.join(folder_path, new_file_name)
        
        # Mở và chuyển đổi ảnh sang định dạng PNG
        with Image.open(old_file_path) as img:
            img.convert('RGB').save(new_file_path, "PNG")
        
        # Xóa tệp cũ
        os.remove(old_file_path)
        
        print(f"Converted and renamed '{file}' to '{new_file_name}'")

# Gọi hàm để chuyển đổi và đổi tên tệp
convert_and_rename_images_to_png()
