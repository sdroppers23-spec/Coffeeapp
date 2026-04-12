import os

content = open('articles_temp.sql', 'r', encoding='utf-8').read()
# Split by the INSERT INTO public.specialty_articles line
blocks = content.split('INSERT INTO public.specialty_articles')
header = blocks[0]

# Extract TRUNCATE statements to only run them once
# They are in the header
truncate_header = header

for i in range(1, len(blocks), 3):
    # We want to include the text 'INSERT INTO public.specialty_articles' back
    # but only for the blocks we have.
    # Each block starts with the end of the previous INSERT's values... wait.
    # Split by 'INSERT INTO public.specialty_articles' means we have:
    # blocks[0] = header (TRUNCATE etc)
    # blocks[1] = (id, ...) VALUES (...) ; INSERT INTO public.specialty_article_translations ...
    
    current_blocks = blocks[i:i+3]
    full_sql = ""
    if i == 1:
        full_sql += truncate_header
    else:
        full_sql += "BEGIN;\n"
        
    for b in current_blocks:
        full_sql += "INSERT INTO public.specialty_articles" + b
    
    full_sql += "\nCOMMIT;"
    
    with open(f'articles_chunk_{i}.sql', 'w', encoding='utf-8') as f:
        f.write(full_sql)
