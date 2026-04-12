const fs = require('fs');

const jsonPath = 'D:/Games/Coffeeapp/Img/extended_specialty_coffee_encyclopedia.json';
const data = fs.readFileSync(jsonPath, 'utf8');

// Fix the concatenated JSON blocks
const fixedJson = '[' + data.replace(/\}\s*\{/g, '},{') + ']';
const modules = JSON.parse(fixedJson);

const mapping = {
    'SC-001': 101, // Standards
    'SC-002': 102, // Botany
    'SC-003': 103, // Processing
    'SC-006': 104, // Roasting
    'SC-007': 105, // Sensory & Water
    'SC-008': 106, // Espresso Physics [NEW]
    'SC-009': 107, // Digital & Sustainability [NEW]
};

function formatContent(content, lang) {
    let md = '';
    content.forEach(topic => {
        md += `## ${topic.topic}\n\n`;
        if (topic.definition) md += `**Definition:** ${topic.definition}\n\n`;
        
        if (topic.fundamental_attributes) {
            topic.fundamental_attributes.forEach(attr => {
                md += `### ${attr.attribute}\n${attr.details}\n\n`;
            });
        }
        
        if (topic.organizations) {
            topic.organizations.forEach(org => {
                md += `### ${org.name}\n*${org.role}*\n\n`;
                if (org.standards_set) {
                    org.standards_set.forEach(s => md += `- ${s}\n`);
                    md += '\n';
                }
                if (org.certification_system) {
                    md += `**Certification: ${org.certification_system.program_name}**\n${org.certification_system.description}\n\n`;
                }
            });
        }

        if (topic.altitude_and_stress) {
            md += `### Altitude and Stress\n${topic.altitude_and_stress.description}\n${topic.altitude_and_stress.mechanism}\n**Result:** ${topic.altitude_and_stress.result}\n\n`;
        }
        
        if (topic.soil_chemistry) {
             Object.entries(topic.soil_chemistry).forEach(([key, val]) => {
                md += `**${key.charAt(0).toUpperCase() + key.slice(1)}**: ${val}\n\n`;
             });
        }

        if (topic.foundational_varieties) {
             topic.foundational_varieties.forEach(v => {
                md += `### ${v.name}\n${v.characteristics}\n*Agronomy:* ${v.agronomy}\n*Profile:* ${v.cup_profile}\n\n`;
             });
        }

        if (topic.elite_varieties) {
             topic.elite_varieties.forEach(v => {
                md += `### ${v.name}\n${v.origin ? v.origin + '\n' : ''}${v.cup_profile}\n\n`;
             });
        }

        if (topic.chemistry_of_flavor) {
             topic.chemistry_of_flavor.forEach(c => {
                md += `**${c.compound}**: ${c.flavor_impact}\n\n`;
             });
        }

        if (topic.fermentation_types) {
             topic.fermentation_types.forEach(f => {
                md += `### ${f.type}\n${f.mechanics}\n*Impact:* ${f.flavor_impact}\n\n`;
             });
        }

        if (topic.phases) {
             topic.phases.forEach(p => {
                md += `### ${p.phase}\n${p.description}\n*Chemistry:* ${p.chemical_changes}\n\n`;
             });
        }

        if (topic.water_chemistry_parameters) {
             topic.water_chemistry_parameters.forEach(p => {
                md += `**${p.parameter}**: ${p.effect_on_cup}\n\n`;
             });
        }

        if (topic.physics_parameters) {
             topic.physics_parameters.forEach(p => {
                md += `**${p.parameter}**: ${p.description}\n\n`;
             });
        }

        if (topic.beverage_categories) {
             topic.beverage_categories.forEach(c => {
                md += `### ${c.category}\n`;
                c.drinks.forEach(d => {
                    md += `**${d.name}**: ${d.recipe}\n\n`;
                });
             });
        }
        
        if (topic.digital_innovations) {
             topic.digital_innovations.forEach(i => {
                md += `### ${i.tool}\n${i.impact}\n\n`;
             });
        }

        if (topic.sustainability_pillars) {
             topic.sustainability_pillars.forEach(p => {
                md += `### ${p.pillar}\n${p.description}\n\n`;
             });
        }
    });
    return md;
}

const sql = modules.map(m => {
    const id = mapping[m.module_metadata.module_id];
    if (!id) return '';
    
    const contentUk = formatContent(m.content, 'uk').replace(/'/g, "''");
    const titleUk = m.module_metadata.module_name_uk || m.module_metadata.module_name;
    const titleEn = m.module_metadata.module_name;
    
    // I will simulate the English content by translating headers and using the metadata
    // In a real scenario I'd use a translation API, but here I'll do a basic English mapping for the core titles
    // Since I am an AI, I can actually provide the English version of the text if I "know" it.
    // However, for brevity in the script, I'll generate the UK content and I'll manually provide the EN SQL after.
    
    return `
    -- Article ${id}
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (${id}, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_${id % 100}.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (${id}, 'uk', '${titleUk}', 'Поглиблений модуль знань', '${contentUk}')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    `;
}).join('\n');

fs.writeFileSync('D:/Games/Coffeeapp/scratch/encyclopedia_uk.sql', sql);
console.log('UK SQL generated.');
