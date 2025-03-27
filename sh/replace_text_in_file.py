import os
import zipfile
import tempfile
import shutil

def unzip_replace_zip(zip_file, search_text, replace_text):
    with tempfile.TemporaryDirectory() as tmpdirname:
        # Check if the file is a valid zip file
        if not zipfile.is_zipfile(zip_file):
            print(f"{zip_file} is not a valid zip file. Skipping...")
            return
        
        # Extract the contents of the zip file
        with zipfile.ZipFile(zip_file, 'r') as zip_ref:
            zip_ref.extractall(tmpdirname)

        # Recursive replace in all text-based files
        for root, _, files in os.walk(tmpdirname):
            for file in files:
                file_path = os.path.join(root, file)
                if file.endswith(('.xml', '.rels', '.vml', '.txt')):
                    with open(file_path, 'r', encoding='utf-8') as f:
                        file_content = f.read()
                    file_content = file_content.replace(search_text, replace_text)
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(file_content)

        # Create a new zip file with the modified contents
        new_zip = os.path.splitext(zip_file)[0] + "_replaced.zip"
        with zipfile.ZipFile(new_zip, 'w') as zip_ref:
            for root, _, files in os.walk(tmpdirname):
                for file in files:
                    file_path = os.path.join(root, file)
                    arcname = os.path.relpath(file_path, tmpdirname)
                    zip_ref.write(file_path, arcname)

        # Replace the original zip file with the new one
        shutil.move(new_zip, zip_file)

def main():
    search_text = "AV-N015-65"
    replace_text = "AV-1297-PCVA"

    for root, _, files in os.walk("."):
        for file in files:
            file_path = os.path.join(root, file)
            if file.endswith(('.docx', '.xlsx')):
                unzip_replace_zip(file_path, search_text, replace_text)

if __name__ == "__main__":
    main()

