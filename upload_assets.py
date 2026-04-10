import os
import requests

url_base = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/specialty-articles/'
key = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5bG5ucW9qbnl0bmR5Ymh1aWNyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQzNjAwMDMsImV4cCI6MjA4OTkzNjAwM30.DKUoqILh38C4R1XyIbFycU7lMwq61l1PJFdC1_xp5MI'
dir_path = r'C:\Users\gkill\.gemini\antigravity\brain\e4beb587-f0f2-4026-86d6-17ebbbbfbbf9'

headers = {
    'Authorization': f'Bearer {key}',
    'apikey': key
}

files = [f for f in os.listdir(dir_path) if f.startswith('encyclopedia_module_') and f.endswith('.png')]

print(f"Found {len(files)} files to upload.")

for f in files:
    file_path = os.path.join(dir_path, f)
    with open(file_path, 'rb') as fd:
        r = requests.post(url_base + f, headers=headers, data=fd)
        print(f"{f}: {r.status_code}")
        if r.status_code != 200:
            print(f"Error: {r.text}")
