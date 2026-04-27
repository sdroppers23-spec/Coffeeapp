import os
import glob
from PIL import Image

def optimize_images():
    base_dir = r"d:\Games\Coffeeapp\assets\images"
    lib_dir = r"d:\Games\Coffeeapp\lib"
    
    keep_as_png = ["Icon3.png", "Logo2.png"]
    
    # Get all png and jpg files
    image_files = glob.glob(os.path.join(base_dir, "**", "*.png"), recursive=True)
    image_files += glob.glob(os.path.join(base_dir, "**", "*.jpg"), recursive=True)
    
    replacements = {}
    
    for file_path in image_files:
        filename = os.path.basename(file_path)
        
        try:
            with Image.open(file_path) as img:
                if filename in keep_as_png:
                    # Just compress PNG
                    img = img.convert("RGBA")
                    # Max size for icon could be 1024x1024 to save space
                    if img.width > 1024 or img.height > 1024:
                        img.thumbnail((1024, 1024), Image.Resampling.LANCZOS)
                    
                    # optimize=True uses more CPU but produces smaller file
                    img.save(file_path, "PNG", optimize=True)
                    print(f"Compressed {filename}")
                else:
                    # Convert to WebP
                    webp_path = os.path.splitext(file_path)[0] + ".webp"
                    # WebP handles transparency automatically
                    img.save(webp_path, "WEBP", quality=85, method=6)
                    
                    # Store mapping for code replacement
                    old_name = filename
                    new_name = os.path.basename(webp_path)
                    replacements[old_name] = new_name
                    
            if filename not in keep_as_png:
                os.remove(file_path)
                print(f"Converted {filename} to {new_name}")
                
        except Exception as e:
            print(f"Error processing {filename}: {e}")

    # Now replace references in dart files
    dart_files = glob.glob(os.path.join(lib_dir, "**", "*.dart"), recursive=True)
    
    for dart_file in dart_files:
        try:
            with open(dart_file, 'r', encoding='utf-8') as f:
                content = f.read()
                
            new_content = content
            for old_name, new_name in replacements.items():
                new_content = new_content.replace(old_name, new_name)
                
            if new_content != content:
                with open(dart_file, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Updated references in {os.path.basename(dart_file)}")
        except Exception as e:
            print(f"Error updating {dart_file}: {e}")

if __name__ == "__main__":
    optimize_images()
