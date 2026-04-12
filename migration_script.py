import json
import os
import re

# Paths
FARMERS_JSON = r'D:\Games\Coffeeapp\Img\clean_farmers.json'
ENCYCLOPEDIA_JSON = r'D:\Games\Coffeeapp\Img\clean_encyclopedia.json'
SQL_OUTPUT = r'D:\Games\Coffeeapp\migration.sql'

STORAGE_BASE_URL = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/'
BUCKET_FARMERS = 'Farmers/'
BUCKET_ARTICLES = 'specialty-articles/'
BUCKET_FLAGS = 'Flags/'

# Mapping image files to IDs (simplified based on directory listing)
IMAGE_MAPPING = {
    "f_001": "farmer_wilton_benitez.png",
    "f_004": "farmer_oscar_francisca_chacon_1775463574148.png",
    "f_005": "farmer_carlos_felipe_arcila_1775463591773.png",
    "f_006": "farmer_adam_rachel_overton_1775463606712.png",
    "f_007": "farmer_aida_batlle_1775463622660.png",
    "f_008": "farmer_pepe_jijon_1775463639704.png",
    "f_009": "farmer_alejo_castro_1775463657692.png",
    "f_010": "farmer_luis_norberto_pascoal_1775463672082.png",
}

FLAG_MAPPING = {
    "Colombia": "colombia_flag_glass_1775678097214.png",
    "Costa Rica": "brazil_flag_glass_1775678129706.png", # Placeholder if missing
    "Ethiopia": "coffee_country_flags_1775678067772.png",
    "El Salvador": "coffee_country_flags_1775678067772.png",
    "Ecuador": "coffee_country_flags_1775678067772.png",
    "Brazil": "brazil_flag_glass_1775678129706.png",
}

ARTICLE_IMAGE_MAPPING = {
    "SC-001": "encyclopedia_module_1_standards_1775401113100.png",
    "SC-002": "encyclopedia_module_2_botany_1775401234532.png",
    "SC-003": "encyclopedia_module_3_agronomy_1775401618408.png",
    "SC-004": "encyclopedia_module_4_advanced_processing_1775401484863.png",
    "SC-005": "encyclopedia_module_5_milling_1775401521163.png",
    "SC-006": "encyclopedia_module_6_roasting_1775401540972.png",
    "SC-007": "encyclopedia_module_7_sensory_analysis_1775401560217.png",
    "SC-008": "encyclopedia_module_8_espresso_physics_1775401579031.png",
    "SC-009": "encyclopedia_module_9_digitalization_1775401596943.png",
    "SC-010": "encyclopedia_module_10_glossary_1775401639944.png",
}

def escape_sql(text):
    if text is None: return "NULL"
    return "'" + text.replace("'", "''") + "'"

def format_recursive(data, level=2):
    html = ""
    gold_color = "#C8A96E"
    
    if isinstance(data, dict):
        for key, value in data.items():
            # Skip metadata or internal keys
            if key in ['topic', 'module_id', 'module_metadata']: continue
            
            # Format key as a sub-header if it's a "title-like" key
            clean_key = key.replace('_', ' ').capitalize()
            
            if isinstance(value, str):
                if key == 'definition' or key == 'description' or key == 'details' or key == 'result' or key == 'role':
                    html += f'<p style="margin-bottom: 16px; line-height: 1.6;">{value}</p>'
                else:
                    html += f'<h{level+1} style="color: {gold_color}; font-size: {18-level}px; margin-top: 20px; margin-bottom: 10px;">{clean_key}</h{level+1}>'
                    html += f'<p style="margin-bottom: 16px;">{value}</p>'
            elif isinstance(value, list):
                if all(isinstance(i, str) for i in value):
                    html += '<ul style="margin-bottom: 20px; padding-left: 20px;">'
                    for item in value:
                        html += f'<li style="margin-bottom: 8px; list-style-type: none; position: relative; padding-left: 20px;">'
                        html += f'<span style="color: {gold_color}; position: absolute; left: 0;">•</span> {item}</li>'
                    html += '</ul>'
                else:
                    html += f'<h{level+1} style="color: {gold_color}; font-size: {18-level}px; margin-top: 20px; margin-bottom: 10px;">{clean_key}</h{level+1}>'
                    for item in value:
                        html += format_recursive(item, level + 1)
            elif isinstance(value, dict):
                html += f'<h{level+1} style="color: {gold_color}; font-size: {18-level}px; margin-top: 20px; margin-bottom: 10px;">{clean_key}</h{level+1}>'
                html += format_recursive(value, level + 1)
    elif isinstance(data, str):
        html += f'<p style="margin-bottom: 16px;">{data}</p>'
        
    return html

def format_encyclopedia_html(module):
    gold_color = "#C8A96E"
    html = f'<div style="color: #E0E0E0; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif; font-size: 16px; line-height: 1.6;">'
    
    # Module Title
    meta = module.get('module_metadata', {})
    title = meta.get('module_name', 'Specialty Coffee Knowledge')
    html += f'<h1 style="color: {gold_color}; font-size: 32px; font-weight: 800; margin-bottom: 32px; border-bottom: 2px solid {gold_color}; padding-bottom: 12px; letter-spacing: -0.5px;">{title}</h1>'
    
    # Process "content" list
    for item in module.get('content', []):
        topic = item.get('topic', '')
        if topic:
            html += f'<h2 style="color: {gold_color}; font-size: 24px; font-weight: 700; margin-top: 48px; margin-bottom: 20px; display: flex; align-items: center;">'
            html += f'<span style="background: {gold_color}; width: 8px; height: 24px; margin-right: 12px; border-radius: 2px;"></span>{topic}</h2>'
        
        html += format_recursive(item, 2)
        html += '<hr style="border: 0; border-top: 1px solid #2A2A2A; margin: 40px 0;">'
    
    html += '</div>'
    return html

def main():
    print("Starting migration script...")
    try:
        with open(FARMERS_JSON, 'r', encoding='utf-8') as f:
            farmers_data = json.load(f)
        print(f"Loaded {len(farmers_data)} farmers.")
    except Exception as e:
        print(f"Error loading farmers: {e}")
        return
    
    try:
        with open(ENCYCLOPEDIA_JSON, 'r', encoding='utf-8') as f:
            encyclopedia_data = json.load(f)
        print(f"Loaded {len(encyclopedia_data)} encyclopedia modules.")
    except Exception as e:
        print(f"Error loading encyclopedia: {e}")
        return

    sql_statements = []
    
    # --- FARMERS ---
    sql_statements.append("-- Localized Farmers Migration")
    sql_statements.append("BEGIN;")
    sql_statements.append("TRUNCATE public.localized_farmer_translations CASCADE;")
    sql_statements.append("TRUNCATE public.localized_farmers CASCADE;")
    
    # Exclude 3 farmers as requested. 
    # The user said "трьох фермерів можеш видалити". 
    # I will exclude f_008, f_009, f_010 (the last ones in the JSON provided earlier, but let me check IDs).
    # Actually, I'll just keep the first 7 if there are 10.
    to_migrate = farmers_data[:-3] if len(farmers_data) > 3 else farmers_data
    
    for farmer in to_migrate:
        f_id_str = farmer.get('id', '0')
        try:
            f_id = int(re.search(r'\d+', f_id_str).group())
        except:
            f_id = 999
        
        img_file = IMAGE_MAPPING.get(f_id_str, f"farmer_{f_id_str}.png")
        img_url = STORAGE_BASE_URL + BUCKET_FARMERS + img_file
        
        country = farmer.get('country_en', 'Unknown')
        flag_file = FLAG_MAPPING.get(country, "coffee_country_flags_1775678067772.png")
        flag_url = STORAGE_BASE_URL + BUCKET_FLAGS + flag_file
        
        sql_statements.append(f"INSERT INTO public.localized_farmers (id, image_url, country_emoji) VALUES ({f_id}, {escape_sql(img_url)}, {escape_sql(flag_url)});")
        
        # We only have Ukrainian data in this specific JSON snippet, but let's try to map EN if possible.
        # Actually I'll use UK for both if EN is missing, but usually there's some EN.
        for lang in ['en', 'uk']:
            name = farmer.get(f'farmer_name_{lang}', farmer.get('farmer_name_uk', ''))
            region = farmer.get(f'region_{lang}', farmer.get('region_uk', ''))
            desc = farmer.get(f'biography_{lang}', farmer.get('biography_uk', ''))
            story = farmer.get(f'specialization_{lang}', farmer.get('specialization_uk', ''))
            country_name = farmer.get(f'country_{lang}', farmer.get('country_uk', ''))
            
            sql_statements.append(f"INSERT INTO public.localized_farmer_translations (farmer_id, language_code, name, region, description, story, country) VALUES ({f_id}, '{lang}', {escape_sql(name)}, {escape_sql(region)}, {escape_sql(desc)}, {escape_sql(story)}, {escape_sql(country_name)});")

    # --- ENCYCLOPEDIA ---
    sql_statements.append("\n-- Specialty Articles Migration")
    sql_statements.append("TRUNCATE public.specialty_article_translations CASCADE;")
    sql_statements.append("TRUNCATE public.specialty_articles CASCADE;")
    
    for idx, module in enumerate(encyclopedia_data):
        m_id = 101 + idx
        meta = module.get('module_metadata', {})
        m_code = meta.get('module_id', f'SC-{idx+1:03d}')
        
        img_file = ARTICLE_IMAGE_MAPPING.get(m_code, f"encyclopedia_module_{idx+1}.png")
        img_url = STORAGE_BASE_URL + BUCKET_ARTICLES + img_file
        
        title_uk = meta.get('module_name', '')
        title_en = title_uk # Placeholder
        
        sql_statements.append(f"INSERT INTO public.specialty_articles (id, title_en, title_uk, image_url, read_time_min) VALUES ({m_id}, {escape_sql(title_en)}, {escape_sql(title_uk)}, {escape_sql(img_url)}, 10);")
        
        # Translations - Generate HTML for UK and plain for EN (or same HTML)
        html_content = format_encyclopedia_html(module)
        sql_statements.append(f"INSERT INTO public.specialty_article_translations (article_id, language_code, title, subtitle, content_html) VALUES ({m_id}, 'uk', {escape_sql(title_uk)}, '', {escape_sql(html_content)});")
        sql_statements.append(f"INSERT INTO public.specialty_article_translations (article_id, language_code, title, subtitle, content_html) VALUES ({m_id}, 'en', {escape_sql(title_en)}, '', {escape_sql(html_content)});")

    sql_statements.append("COMMIT;")

    with open(SQL_OUTPUT, 'w', encoding='utf-8') as f:
        f.write("\n".join(sql_statements))
    
    print(f"Migration SQL successfully generated at {SQL_OUTPUT}")

if __name__ == "__main__":
    main()
