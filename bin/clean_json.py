import json
import re

def clean_file_robust(input_path, output_path, label):
    print(f"🛠 Robustly cleaning {label}...")
    try:
        with open(input_path, 'r', encoding='utf-8') as f:
            raw = f.read().strip()

        # SUPER ROBUST: Find everything between { and } that looks like an object
        # This regex looks for { followed by "id" or "module_metadata" and finds the matching closing }
        # Actually, for concatenated JSON, we can look for objects starting with {
        pattern = r'\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}'
        blocks = re.findall(pattern, raw, re.DOTALL)
        
        cleaned_data = []
        for i, block in enumerate(blocks):
            try:
                # Cleanup potential garbage at start/end of block
                block = block.strip()
                obj = json.loads(block)
                # Filter useful objects
                if 'id' in obj or 'module_metadata' in obj:
                    cleaned_data.append(obj)
            except:
                pass

        # If findall failed, try a deeper balance approach for the whole file
        if not cleaned_data:
             # Fallback: find all "id" or "module_metadata" markers and extract blocks
             markers = [m.start() for m in re.finditer(r'\{', raw)]
             for start in markers:
                # Try to parse objects of increasing size from each {
                for end in range(start + 50, len(raw)):
                    if raw[end] == '}':
                        try:
                            candidate = raw[start:end+1]
                            obj = json.loads(candidate)
                            if ('id' in obj or 'module_metadata' in obj) and obj not in cleaned_data:
                                cleaned_data.append(obj)
                                break
                        except:
                            continue

        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(cleaned_data, f, ensure_ascii=False, indent=2)
        print(f"✅ CLEANED: {label}. Total items: {len(cleaned_data)}")
        return True
    except Exception as e:
        print(f"🔴 ERROR cleaning {label}: {e}")
        return False

if __name__ == "__main__":
    clean_file_robust('d:/Games/Coffeeapp/Img/extended_specialty_coffee_encyclopedia.json', 
               'd:/Games/Coffeeapp/Img/clean_encyclopedia.json', 'Encyclopedia')
    clean_file_robust('d:/Games/Coffeeapp/Img/Farmers.json', 
               'd:/Games/Coffeeapp/Img/clean_farmers.json', 'Farmers')
