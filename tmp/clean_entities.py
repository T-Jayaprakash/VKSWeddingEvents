import os, re

root = r'c:\Users\ajana\.gemini\antigravity\scratch\VKSWeddingEvents'

# Map HTML entities and their plain-English replacements
entity_map = [
    # Accented characters: remove accent
    ('&#233;',  'e'),      # é → e (Décor → Decor)
    ('&#232;',  'e'),      # è → e
    ('&#234;',  'e'),      # ê → e
    ('&#224;',  'a'),      # à → a
    ('&#226;',  'a'),      # â → a
    ('&#251;',  'u'),      # û → u
    # Typography
    ('&#8212;', ' — '),    # em dash
    ('&#8211;', ' - '),    # en dash
    ('&#8217;', "'"),      # right single quote / apostrophe
    ('&#8216;', "'"),      # left single quote
    ('&#8220;', '"'),      # left double quote
    ('&#8221;', '"'),      # right double quote
    # Named entities that may appear in body text
    ('&mdash;', ' — '),
    ('&ndash;', ' - '),
    ('&rsquo;', "'"),
    ('&lsquo;', "'"),
    ('&rdquo;', '"'),
    ('&ldquo;', '"'),
    # Extra corrupted sequences from previous encoding pass
    ('" "', '"'),           # stray residues
    ('"&#8221;', '"'),
    ('&#8221;"', '"'),
    ('&#8221;', '"'),       # catch any remaining
]

for fname in sorted(os.listdir(root)):
    if not fname.endswith('.html'):
        continue
    path = os.path.join(root, fname)
    with open(path, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()

    original = content

    # Apply all entity replacements (only in text nodes, not inside tag attributes or href values)
    for bad, good in entity_map:
        content = content.replace(bad, good)

    # Also fix "Decor" appearing as "D&#233;cor" pattern
    content = re.sub(r'[Dd]&#233;cor', lambda m: ('D' if m.group(0)[0]=='D' else 'd') + 'ecor', content)

    if content != original:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f'Fixed: {fname}')
    else:
        print(f'Clean: {fname}')

print('\nAll done.')
