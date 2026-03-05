import os, re

root = r'c:\Users\ajana\.gemini\antigravity\scratch\VKSWeddingEvents'
link_tag = '  <link rel="stylesheet" href="mobile-fix.css" />'

for fname in sorted(os.listdir(root)):
    if not fname.endswith('.html'):
        continue
    path = os.path.join(root, fname)
    with open(path, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()

    # Skip if already linked
    if 'mobile-fix.css' in content:
        print(f'SKIP (already linked): {fname}')
        continue

    # Insert after styles.css link
    new_content = re.sub(
        r'(<link\s[^>]*href=["\']styles\.css["\'][^>]*>)',
        r'\1\n' + link_tag,
        content
    )

    if new_content != content:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f'Linked: {fname}')
    else:
        print(f'SKIP (no styles.css link found): {fname}')

print('\nDone.')
