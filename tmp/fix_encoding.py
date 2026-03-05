import os, re

root = r'c:\Users\ajana\.gemini\antigravity\scratch\VKSWeddingEvents'

# Garbled sequences -> correct HTML entities or UTF-8 characters
replacements = [
    # Double-encoded em dash: UTF-8 bytes E2 80 94 misread as latin-1 then stored
    ('â€"', '&#8212;'),
    ('â€™', '&#8217;'),
    ('â€˜', '&#8216;'),
    ('â€œ', '&#8220;'),
    ('â€', '&#8221;'),
    # e with acute (é) stored as garbled
    ('Ã©', '&#233;'),
    ('dÃ©cor', 'd&#233;cor'),
    # Stray non-breaking space artifacts
    ('Â\xa0', ' '),
    ('Â ', ' '),
    ('Â', ''),
]

for fname in os.listdir(root):
    if not fname.endswith('.html'):
        continue
    path = os.path.join(root, fname)
    with open(path, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()
    
    original = content
    for bad, good in replacements:
        content = content.replace(bad, good)
    
    if content != original:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f'Fixed: {fname}')
    else:
        print(f'Clean: {fname}')

print('\nDone.')
