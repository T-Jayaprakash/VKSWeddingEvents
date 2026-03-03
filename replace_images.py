import os
import glob
import re

replacements = {
    'images/hero.png': 'images/real/DP3_8901.JPG',
    'images/collection1.png': 'images/real/DP2_7869.JPG',
    'images/collection2.png': 'images/real/DP3_8124.jpeg',
    'images/collection3.png': 'images/real/DP3_8907.JPG',
    'images/collection4.png': 'images/real/DP2_8536.JPG',
    'images/about.png': 'images/real/PRB_6584.JPG',
    'images/gallery1.png': 'images/real/DP2_7869.JPG',
    'images/gallery2.png': 'images/real/DP2_7898.JPG',
    'images/gallery3.png': 'images/real/DP2_8534.JPG',
    'images/gallery4.png': 'images/real/DP2_8536.JPG',
    'images/gallery5.png': 'images/real/DP3_8124.jpeg',
    'images/gallery6.png': 'images/real/DP3_8129.jpeg',
    'images/gallery7.png': 'images/real/DP3_8146.jpeg',
    'images/gallery8.png': 'images/real/DP3_8901.JPG',
    'images/gallery9.png': 'images/real/DP3_8905.JPG',
    'images/gallery10.png': 'images/real/DP3_8907.JPG',
    'images/gallery11.png': 'images/real/DSC07874.JPG',
    'images/gallery12.png': 'images/real/PRB_6519.JPG',
}

html_files = glob.glob('*.html')

for file_path in html_files:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    new_content = content
    for old, new in replacements.items():
        new_content = new_content.replace(old, new)
        
    if new_content != content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {file_path}")
    else:
        print(f"No changes in {file_path}")

print("Done replacing images.")
