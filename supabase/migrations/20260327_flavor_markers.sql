-- Migration: 20260327_flavor_markers.sql
-- Description: Table for managing 3D globe flavor markers remotely.

CREATE TABLE IF NOT EXISTS flavor_markers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    key TEXT UNIQUE NOT NULL, -- e.g. "EAST_AFRICA_ETH"
    name_key TEXT NOT NULL,   -- localization key
    description_key TEXT,     -- localization key
    latitude DECIMAL NOT NULL,
    longitude DECIMAL NOT NULL,
    flavor_name_keys TEXT[] DEFAULT '{}', -- e.g. ['flavor_floral', 'flavor_fruity']
    marker_color TEXT DEFAULT '#C8A96E',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Index for spatial lookup (if needed later)
CREATE INDEX idx_flavor_markers_coords ON flavor_markers(latitude, longitude);

-- Sample Data (to match current static implementation)
INSERT INTO flavor_markers (key, name_key, description_key, latitude, longitude, flavor_name_keys)
VALUES 
    ('EAST_AFRICA_ETH', 'region_east_africa', 'desc_east_africa', 9.0, 40.0, ARRAY['flavor_floral', 'flavor_fruity']),
    ('SOUTH_AMERICA_COL', 'region_south_america', 'desc_south_america', 4.0, -74.0, ARRAY['flavor_sweet', 'flavor_fruity']),
    ('CENTRAL_AMERICA_GUA', 'region_central_america', 'desc_central_america', 15.0, -90.0, ARRAY['flavor_nutty', 'flavor_fruity'])
ON CONFLICT (key) DO UPDATE 
SET name_key = EXCLUDED.name_key, 
    description_key = EXCLUDED.description_key,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude,
    flavor_name_keys = EXCLUDED.flavor_name_keys;
