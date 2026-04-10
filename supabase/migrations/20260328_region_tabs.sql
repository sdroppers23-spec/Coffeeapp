-- Migration: 20260328_region_tabs.sql
-- Description: Add support for custom tabs and rich content for coffee regions.

ALTER TABLE flavor_markers 
ADD COLUMN IF NOT EXISTS tabs_json JSONB DEFAULT '[]';

-- Example of tabs structure:
-- [
--   {"id": "history", "title_key": "tab_history", "content_key": "desc_eth_history"},
--   {"id": "soil", "title_key": "tab_soil", "content_key": "desc_eth_soil"},
--   {"id": "processing", "title_key": "tab_processing", "content_key": "desc_eth_processing"}
-- ]

-- Update sample data with empty tabs for now
UPDATE flavor_markers SET tabs_json = '[]' WHERE tabs_json IS NULL;
