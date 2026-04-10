@echo off
set "KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5bG5ucW9qbnl0bmR5Ymh1aWNyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQzNjAwMDMsImV4cCI6MjA4OTkzNjAwM30.DKUoqILh38C4R1XyIbFycU7lMwq61l1PJFdC1_xp5MI"
set "URL=https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/specialty-articles/"

echo Uploading module 1...
curl -v -X POST "%URL%module_1.png" -H "Authorization: Bearer %KEY%" -H "apikey: %KEY%" -H "Content-Type: image/png" --data-binary "@C:\Users\gkill\.gemini\antigravity\brain\e4beb587-f0f2-4026-86d6-17ebbbbfbbf9\encyclopedia_module_1_standards_1775401113100.png"
