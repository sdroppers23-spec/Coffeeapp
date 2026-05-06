# -*- coding: utf-8 -*-
import re

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

def audit_details():
    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Simple regex to extract blocks
    blocks = re.findall(rf"'([^']+)':\s*\{{(.*?)\}}", content, re.DOTALL)
    
    gaps = []
    for key, body in blocks:
        entries = re.findall(r"'([a-z]{2})':\s*'(.*?)',", body)
        data = {lang: text for lang, text in entries}
        
        if 'en' not in data or 'uk' not in data:
            continue
            
        en_len = len(data['en'])
        uk_len = len(data['uk'])
        avg_ref = (en_len + uk_len) / 2
        
        for lang, text in data.items():
            if lang in ['en', 'uk']: continue
            if len(text) < avg_ref * 0.6: # If less than 60% of reference length
                gaps.append((key, lang, len(text), int(avg_ref)))
                
    # Sort by key to see which ones are most problematic
    gaps.sort()
    for key, lang, curr, ref in gaps[:50]:
        print(f"Key: {key} | Lang: {lang} | Length: {curr} (Ref: {ref})")

if __name__ == '__main__':
    audit_details()
