-- Migration: 20260331_localization_and_admin.sql
-- Description: Rebuilding tables to fully support EN/UK localization natively.

-- 1. Brands (Roasters)
CREATE TABLE IF NOT EXISTS localized_brands (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    short_desc_en TEXT,
    short_desc_uk TEXT,
    full_desc_en TEXT,
    full_desc_uk TEXT,
    logo_url TEXT,
    site_url TEXT,
    location_en TEXT,
    location_uk TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Coffee Beans (Formerly EncyclopediaEntries)
CREATE TABLE IF NOT EXISTS localized_beans (
    id SERIAL PRIMARY KEY,
    brand_id INTEGER REFERENCES localized_brands(id) ON DELETE CASCADE,
    country_emoji TEXT,
    country_en TEXT,
    country_uk TEXT,
    region_en TEXT,
    region_uk TEXT,
    altitude_min INTEGER,
    altitude_max INTEGER,
    varieties_en TEXT,
    varieties_uk TEXT,
    flavor_notes_en JSONB DEFAULT '[]',
    flavor_notes_uk JSONB DEFAULT '[]',
    process_method_en TEXT,
    process_method_uk TEXT,
    description_en TEXT,
    description_uk TEXT,
    cups_score DECIMAL,
    roast_level_en TEXT,
    roast_level_uk TEXT,
    price TEXT,
    weight TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Sphere Regions (Formerly flavor_markers)
CREATE TABLE IF NOT EXISTS sphere_regions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    key TEXT UNIQUE NOT NULL,
    name_en TEXT NOT NULL,
    name_uk TEXT NOT NULL,
    description_en TEXT,
    description_uk TEXT,
    latitude DECIMAL NOT NULL,
    longitude DECIMAL NOT NULL,
    flavor_profile_en JSONB DEFAULT '[]',
    flavor_profile_uk JSONB DEFAULT '[]',
    marker_color TEXT DEFAULT '#C8A96E',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Add updated_at triggers if needed
