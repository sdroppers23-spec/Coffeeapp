-- Migration for Localized Farmers Table (10 Languages)
CREATE TABLE IF NOT EXISTS public.localized_farmers (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    
    -- Name (10 Languages)
    name_en TEXT,
    name_uk TEXT,
    name_pl TEXT,
    name_de TEXT,
    name_fr TEXT,
    name_es TEXT,
    name_it TEXT,
    name_pt TEXT,
    name_ro TEXT,
    name_tr TEXT,

    -- Region (10 Languages)
    region_en TEXT,
    region_uk TEXT,
    region_pl TEXT,
    region_de TEXT,
    region_fr TEXT,
    region_es TEXT,
    region_it TEXT,
    region_pt TEXT,
    region_ro TEXT,
    region_tr TEXT,

    -- Description (10 Languages)
    description_en TEXT,
    description_uk TEXT,
    description_pl TEXT,
    description_de TEXT,
    description_fr TEXT,
    description_es TEXT,
    description_it TEXT,
    description_pt TEXT,
    description_ro TEXT,
    description_tr TEXT,

    -- Story (10 Languages)
    story_en TEXT,
    story_uk TEXT,
    story_pl TEXT,
    story_de TEXT,
    story_fr TEXT,
    story_es TEXT,
    story_it TEXT,
    story_pt TEXT,
    story_ro TEXT,
    story_tr TEXT,

    image_url TEXT,
    country_emoji TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.localized_farmers ENABLE ROW LEVEL SECURITY;

-- Select policy (Public read)
CREATE POLICY IF NOT EXISTS "Public Read for Localized Farmers" 
ON public.localized_farmers FOR SELECT 
TO anon, authenticated 
USING (true);

-- Insert/Update policy (Authenticated admin only)
CREATE POLICY IF NOT EXISTS "Admin CRUD for Localized Farmers" 
ON public.localized_farmers FOR ALL 
TO authenticated 
USING (true);
