
INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('chemex', 'en', 'Chemex', 'Icon design. Thick filters trap oils for maximum transparency.', '<h1>{gold}Chemex: The elegance of glass and the standard of purity of taste{/gold}</h1>

> Chemex is a unique case where a coffee device is not only a brewing tool, but also a recognized work of art, which is included in the permanent exhibition of New York''s Museum of Modern Art (MoMA).

<p>The main feature of Chemex is the unprecedented purity and lightness of the drink. Thanks to patented, extremely dense paper filters (they are 20-30% thicker than standard V60 filters), this method traps absolutely all coffee oils, microparticles and bitter substances. The result is a crystal clear, almost teacup with maximum bright acidity that is perfect for revealing the delicate floral and berry lots of the light roast.</p><hr/><h2>{gold}1. History: The invention of an eccentric chemist{/gold}</h2>
<p>Chemex was created in 1941 by Peter Schlumbohm, an American chemist of German origin. Schlumbom was an eccentric inventor whotented more than 300 different household devices, but it was this glass coffee maker that brought him world fame.</p>
<p>As a chemist, Peter had an excellent understanding of extraction processes and appreciated the properties of laboratory glassware. He was inspired by an Erlenmeyer flask and a glass funnel, combining them into a single unit made of heat-resistant borosilicate glass. To make it convenient to hold the hot flask, he added a wooden "collar" tied with a leather cord with a wooden ball. This minimalist Bauhaus design has remained unchanged for over 80 years.</p>

<h3>{gold}Anatomy and physics of the process{/gold}</h3>
<p>Chemex works on the principle of gravity percolation. Because the filter is very dense and fits tightly against the smooth glass walls (unlike the embossed walls of the V60), the flow of water through the coffee is much slower. A special deep groove (spout) on the neck of the flask performs two critical functions: it serves to accurately pour the coffee and acts as a gas outlet, allowingair to escape freely from the bottom of the flask during filtration. Without this groove, the extraction process would stop instantly due to the vacuum.</p><hr/><h2>{gold}2. Basic stages of brewing{/gold}</h2>
<p>For preparation, you will need: Chemex itself, a branded dense filter (Chemex Bonded Filter), coffee (grind coarser than for purover, resembles large sea salt or coarse sand), hot water (90-94°C), a kettle with a thin nose (gooseneck) and accurate scales.</p>

<h3>{gold}The classic brewing method{/gold}</h3>
<ul>
    <li>{gold}Step 1: Prepare the filter.{/gold} Unfold a square or round filter so that there is one layer of paper on one side and three layers on the other. Insert the filter into the Chemex so that the triple layer of paper lies flat on the grooved spout. This is extremely important, because a thin single layer can bend into the spout under the weight of the water and block the air outlet, which will "suffocate" the extraction.</li>
    <li>{gold}Step 2: Rinsing.{/gold} Rinse the filter thoroughly with hot water (about 100-150ml). Thick paper has a strong cellulose taste, so it must be washed thoroughly while heating the glass flask. Be sure to drain this water through the spout without removing the filter (just hold it with your hand).</li>
    <li>{gold}Step 3: Pouring in the coffee.{/gold} Pour in the ground coffee (standard proportion: 30 grams of coffee per 500 ml of water, as Chemex is usually brewed in several batches). Shake the flask slightly to level the coffee bed. Zero the scales.</li>
    <li>{gold}Step 4: Blooming (Blooming).{/gold} Pour water (about 60-90 ml) to evenly wet all the coffee. Through a thick filter, water flows more slowly, so the flowering stage is often extended here to 45-60 seconds, allowing carbon dioxide to escape as much as possible.</li>
    <li>{gold}Step 5: Main Infusion.{/gold} Begin pouring water slowly and evenly in a circular motion from the center to the edges, avoiding getting water on the exposed areas of the paper walls above the level of the coffee. Water can be poured either in one slow stream or in a streambeating for several pulses (infusions), maintaining a stable level of liquid in the funnel.</li>
    <li>{gold}Step 6: Drawdown (Draining).{/gold} Wait for the water to pass completely. Due to the dense filter and coarser grind, the total extraction time is usually longer than the V60, ranging from 3.5 to 5 minutes depending on the portion.</li>
    <li>{gold}Step 7: Feed.{/gold} Grasp the filter by the thick edges, gently lift and discard it with the slurry. Gently shake the coffee in the Chemex to aerate and pour into cups. Enjoy impeccably clean taste!</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;


INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('v60', 'en', 'V60 (Hario)', 'The most popular purover in the world. Provides clean taste and bright acidity.', '<h1>{gold}Hario V60: The perfect geometry of pure taste{/gold}</h1>

> V60 is not just a pourover, it is a true icon of the third coffee wave. Its elegant conical shape allows you to reveal the subtlest endogenous descriptors of coffee, turning brewing into a meditative process.

<p>The main feature of V60 is its ability to create an incredibly "clean", light and clear cup with pronounced acidity. Thanks to a fine paper filter and gravity extraction (percolation), it traps almost all coffee oils and fine particles. Unlike immersion methods (such as Aeropress or French press), the water here is constantly updated, washing out the most delicate floral and fruity notes from the coffee.</p><hr/><h2>{gold}1. History of origin: From laboratory glass to world recognition{/gold}</h2>
<p>The creator of the V60 is the Japanese company Hario, which was founded in 1921 in Tokyo. At first, Hario (which translated from Japanese means "King of Glass") specialized exclusively in the production of high-quality terdurable laboratory utensils: beakers, flasks and chemical tubes.</p>
<p>Only in the second half of the 20th century, the company began to apply its experience in creating coffee equipment. The real breakthrough came in 2004, when Hario engineers decided to improve traditional pourovers, which at that time had a flat bottom or a trapezoidal shape.</p>

<h3>{gold}What is the secret of geometry?{/gold}</h3>
<p>The name V60 is deciphered very simply: it is a cone (the shape of the letter "V") with an angle of exactly 60 degrees. This mathematically calibrated shape forces the water to flow towards the center, increasing the time it is in contact with the ground coffee. In addition, there are special spiral ribs on the inner walls of the funnel. They create an air gap between the paper filter and the wall, allowing air to escape freely. This ensures a smooth and uniform extraction. Today, the V60 is made of ceramics, glass, plastic and metal, and the device itself is a mandatory attribute at the World Brewers Cup.</p><hr/><h2>{gold}2. Basic stages of brewing{/gold}</h2>
<p>To prepare the V60, you will need: the funnel itself, a paper filter, coffee (a medium grind that resembles sea salt), hot water (about 90-95°C), a server (carafe) or sturdy cup, a kettle with a thin spout (gooseneck), and accurate scales.</p>

<h3>{gold}Classic method (Pour-Over){/gold}</h3>
<p>This method requires some practice, as you control the speed of the water flow yourself, but the result is worth it.</p>
<ul>
    <li>{gold}Step 1: Preparation.{/gold} Fold the paper filter along the side seam and insert it into the funnel. Rinse the filter thoroughly with hot water. This will wash away the taste of the pulp and heat up the funnel itself and the server below it. Be sure to drain this water before brewing.</li>
    <li>{gold}Step 2: Pouring coffee.{/gold} Pour ground coffee (standard proportion: 15 grams of coffee per 250 ml of water) into the center of the filter. Shake the funnel slightly so that the coffee bed becomes perfectly even. Zero the scales.</li>
    <li>{gold}Step 3: Bloomsng (Bloom).{/gold} Slowly pour in a small amount of water (about 30-45 ml) to evenly wet all the coffee. Wait 30-45 seconds. You will see how the coffee begins to bubble and rise - this is carbon dioxide, which prevents the water from dissolving the flavors.</li>
    <li>{gold}Step 4: Basic Infusion.{/gold} Begin slowly pouring in water in a thin stream, moving in a spiral from the center to the edges and back. Try not to pour water on the paper walls of the filter itself. You can pour all the water at once or divide the pouring into several stages (pulses), each time waiting for the water level to drop a little.</li>
    <li>{gold}Step 5: Drawdown {/gold} After you have poured in all the water, wait until it has completely passed through the coffee grounds. The coffee bed at the bottom of the filter must remain level and flat. The total brewing time is usually from 2.5 to 3.5 minutes.</li>
    <li>{gold}Step 6: Tasting.{/gold} Remove the funnel with the filter, slightly shake the finished drink in theaerator and pour into a cup. Delicious!</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;


INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('siphon', 'en', 'Siphon', '', '<h1>{gold}Siphon (Vacuum Coffee Maker): Theatrical physics of brewing{/gold}</h1>

> The siphon is perhaps the most effective method of preparing coffee, which turns the bar counter into a real alchemical laboratory. It works at the intersection of the laws of thermodynamics, vapor pressure, and vacuum extraction.

<p>The main feature of the siphon is its spectacular appearance and perfect temperature stability. Thanks to the combination of full immersion (infusion) and a stable heat source from below, coffee is brewed at a perfectly even temperature. This results in an extremely clean, "tea" cup with bright, juicy acidity and a very delicate body, fully revealing the subtlest floral and fruity descriptors.</p><hr/><h2>{gold}1. History of origin: Alchemy of the 19th century{/gold}</h2>
<p>Today, the siphon is often associated with Japanese or Taiwanese coffee culture, but it was actually invented in Europe. In the 1830s, the first prototypes appeared in Berlin, but the commercially successful patent was obtained by the Frenchwoman MadameVassieux (Madame Vassieux) from Lyon in 1840. Her device had two glass hemispheres fixed on a metal frame, and even then it looked almost the same as modern models.</p>
<p>In Europe, siphons gradually fell out of fashion due to the fragility of glass and the advent of faster espresso machines. However, in the mid-20th century, the technology made its way to Japan, where companies (such as Hario and Yama) perfected heat-resistant borosilicate glass. The Japanese turned brewing in a siphon into a real meditative ceremony, from where this method triumphantly returned to the world''s third-wave coffee shops.</p>

<h3>{gold}Anatomy and physics of the process{/gold}</h3>
<p>The device consists of a lower flask (where water is poured), an upper flask with a tube (where coffee is poured), a filter (usually fabric, less often paper or metal) and a heat source (gas, halogen or alcohol burner). Physics is based on the expansion and contraction of gases. When the water in the lower flask is heated, the water vapor creates pressure that pushes the liquid down the holeinto the upper flask. When the heat source is removed, the steam in the lower flask cools, creating a vacuum that forcefully sucks the brewed coffee back through the filter.</p>
<hr/><h2>{gold}2. Basic stages of brewing{/gold}</h2>
<p>To prepare, you will need: a siphon, a burner (halogen or butane), a fabric filter, coffee (grinds are a little finer than for a purover, but coarser than an espresso), hot water (to speed up the process) and a wooden stirring paddle (bamboo stick).</p>

<h3>{gold}The classic brewing method{/gold}</h3>
<ul>
    <li>{gold}Step 1: Preparing the filter.{/gold} The fabric filter is fixed on a spring in the upper flask. It should be clean and moist (a dry cloth will give the coffee an unpleasant smell).</li>
    <li>{gold}Step 2: Heating the water.{/gold} Pour hot water (about 300 ml) into the lower flask. Turn on the burner and place it exactly under the center of the bulb.</li>
    <li>{gold}Step 3: Installing the upper bulb.{/gold} Insert the upper bulb into the lower bulb under theat a large angle (without sealing hermetically). When the water in the lower flask begins to actively boil, align the upper flask and press it tightly, creating a hermetic connection (seal).</li>
    <li>{gold}Step 4: Rise of the water.{/gold} The steam pressure will cause the water to rise rapidly into the upper flask. Only a little water will remain in the lower flask, which will continue to boil, maintaining the pressure. The water temperature in the upper flask stabilizes at an ideal 91-93°C. Reduce the power of the burner.</li>
    <li>{gold}Step 5: Adding coffee.{/gold} Pour ground coffee (about 20 grams) into the top flask directly into the water. Immediately take the spatula and carefully drown all the coffee so that there are no dry lumps. Turn on the timer for 45-60 seconds.</li>
    <li>{gold}Step 6: Infusion and mixing.{/gold} During infusion (immersion), the coffee gives its flavor. At the 30th second, you can do another light mixing in a circle.</li>
    <li>{gold}Step 7: Vacuum Filtration (Drowdown).{/gold} After a minute, turn off and remove thealnik from under the lower bulb. The air in it will begin to cool, forming a vacuum. You will see the coffee begin to rapidly suck back into the lower flask through the fabric filter. This process takes about 30-45 seconds.</li>
    <li>{gold}Step 8: Forming the dome.{/gold} When all the coffee is at the bottom, the coffee grounds in the top flask should have the perfect shape of a neat dome—an indicator that the extraction was even.</li>
    <li>{gold}Step 9: Feed.{/gold} Carefully remove the top bulb. The lower flask now serves as a server - pour coffee and enjoy!</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;


INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('french_press', 'en', 'French Press', '', '<h1>{gold}French Press: Full Immersion and Tight Body Classics{/gold}</h1>

> The French press is one of the oldest and most understood brewing methods, proving that you don''t have to use complicated electronics or paper filters to get an outstanding cup of coffee.

<p>The main feature of the French press is the maximum density of the body of the drink and the preservation of all coffee oils. Since a metal mesh is used here instead of a paper filter, lipids and small insoluble particles (fines) enter the cup without hindrance. This creates a rich, thick texture that is ideal for low acidity coffees with chocolate, nutty or caramel descriptors.</p><hr/><h2>{gold}1. History: French idea, Italian design{/gold}</h2>
<p>Despite its name, the history of the French press is the result of the cooperation of two nations. The legend tells of a French peasant in the 1850s who forgot to add coffee to the water before it boiled. When he threw the ground coffee into the boiling water, she lefton the surface. To save the drink, he bought a metal net from a passing Italian merchant and pushed the thicket to the bottom with a stick.</p>
<p>The first official patent for a device similar to the modern French press was registered by Frenchmen Mayet and Delforge in 1852. However, the design we are familiar with - a glass flask with a metal piston and spring - was patented by the Italian designer Attilio Calimani in 1929. Subsequently, the Swiss company Bodum popularized this device all over the world, making it an integral part of home kitchens.</p>

<h3>{gold}Anatomy and physics of the process{/gold}</h3>
<p>The design consists of a cylindrical flask (most often made of heat-resistant borosilicate glass), a lid and a piston (plunger). At the end of the piston, a metal mesh is fixed, clamped between two perforated plates, and a spring along the contour, which ensures a tight fit to the walls. The physics of the process is pure immersion: the coffee is completely submerged in water throughout the brewing time, which guaranteesuniform, albeit slow, extraction.</p>
<hr/><h2>{gold}2. Basic stages of brewing{/gold}</h2>
<p>To prepare, you will need: French press, coffee (coarsely ground, similar to cane sugar or sea salt, so that the particles do not pass through the mesh), hot water (92-96°C), scales and a spoon for mixing.</p>

<h3>{gold}Modern Method (Clean Cup Technique){/gold}</h3>
<p>The traditional approach required active pressing of the pulp immediately after a few minutes of infusion. However, the modern coffee community has switched to a more delicate method that minimizes sediment ("muddy cup" defect) and makes the taste much cleaner and more balanced.</p>
<ul>
    <li>{gold}Step 1: Proportion and pouring.{/gold} Pour ground coffee into the flask (recommended ratio is about 60 grams of coffee per 1 liter of water, or 15 grams per 250 ml). Pour the entire portion of hot water at once, making sure that all the coffee is soaked.</li>
    <li>{gold}Step 2: First Immersion.{/gold} Do not touch the drink. Leave it to infuse for exactly 4minutes A dense "crust" of coffee grounds will form on the surface.</li>
    <li>{gold}Step 3: Crack the crust.{/gold} Take a spoon and gently stir the surface layer. The pick will break and most of the coffee particles will settle to the bottom. Light foam and some small particles will remain on the surface.</li>
    <li>{gold}Step 4: Cleaning.{/gold} Using two spoons, carefully collect the foam and floating particles from the surface and discard them. It is this foam that often contains the most bitter compounds and creates an unpleasant texture in the cup.</li>
    <li>{gold}Step 5: Second Immersion (Waiting).{/gold} Do not insert the plunger! Leave the coffee alone for another 5-8 minutes. The extraction process will almost stop, as the water will partially cool, and most importantly, the microscopic particles of coffee dust will settle to the bottom under the influence of gravity, making the drink clearer.</li>
    <li>{gold}Step 6: Gentle filtration.{/gold} Insert the metal mesh plunger into the flask, but do not push it all the way to the bottom. Lower it just a few Santasmeters so that it is slightly below the liquid level. It will serve only as a barrier during pouring, and not as a press for squeezing out the pulp.</li>
    <li>{gold}Step 7: Serving.{/gold} Pour the coffee smoothly and slowly into the cup, trying not to disturb the sediment at the bottom. Enjoy incredibly sweet, thick and clean coffee!</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;


INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('cold_brew', 'en', 'Cold Brew', '', '<h1>{gold}Cold Brew and Cold Drip: Cold extraction and time instead of temperature{/gold}</h1>

> Cold brew is not just chilled coffee. This is a radically different chemical process, where the lack of high water temperature is compensated by an extremely long extraction time, creating a drink with minimal acidity and liquor density.

<p>The main feature of cold brewing is the avoidance of thermal shock. Hot water instantly washes away organic acids and volatile aromatic compounds from coffee. Instead, cold water works as a very delicate solvent: it extracts almost no tannins and bitterness, leaving the cup with natural sweetness, chocolate notes and a dense, almost syrupy body. There are two fundamentally different approaches to cold brewing: classic immersion (regular Cold Brew) and slow percolation (Cold Drip / Kyoto Tower).</p><hr/><h2>{gold}1. Classic Cold Brew (Immersion){/gold}</h2>
<p>This is the simplest, most common and most "lazy" method that requires a minimum of equipmentI. Coffee is simply steeped in water for 12 to 24 hours. The result is a very dense concentrate with a low level of acidity and a pronounced profile of dark chocolate, nuts and caramel.</p>

<h3>{gold}Basic stages of brewing{/gold}</h3>
<p>To prepare, you will need: a large container (a glass jar, a French press, or a special Toddy pitcher), coffee (a very coarse grind, like ground pepper or sea salt), cold filtered water, and a filter (paper or cloth).</p>
<ul>
    <li>{gold}Step 1: Proportion.{/gold} Cold brew is usually prepared as a concentrate, which is then diluted. The basic ratio is 1:8 or 1:10 (for example, 100 grams of coffee per 1 liter of water).</li>
    <li>{gold}Step 2: Mixing.{/gold} Pour the coffee into a container and cover with cold water. Gently but thoroughly mix with a spoon so that all the particles are moistened and no dry lumps remain.</li>
    <li>{gold}Step 3: Infusion (Immersion).{/gold} Cover the container with a lid. Leave the coffee to infuse at kiroom temperature for 12-16 hours (or in the refrigerator for 18-24 hours). The lower the temperature, the longer the extraction time should be.</li>
    <li>{gold}Step 4: Filtration.{/gold} After the infusion time is over, strain the drink. It is best to use a paper purover (such as V60 or Chemex) or a reusable cloth filter. It is important to filter out all the fine sediment, otherwise the coffee will continue to brew and become bitter.</li>
    <li>{gold}Step 5: Serving and Storage.{/gold} The finished concentrate can be stored in the refrigerator for up to two weeks. Serve it diluted with water, ice, milk or tonic to taste (usually in a 1:1 ratio).</li>
</ul><hr/><h2>{gold}2. Cold Drip / Kyoto Tower {/gold}</h2>
<p>This method looks like Victorian chemical equipment from the steampunk era. In contrast to immersion, slow percolation is used here: ice water drips through the coffee tablet one drop at a time every few seconds. The method was invented by the Dutch Seaswimmers (which is why it is sometimes called Dutch Coffee), but it was brought to absolute aesthetic perfection in Japan (Kyoto).</p>

<h3>{gold}Anatomy and physics of the process{/gold}</h3>
<p>The tower (from manufacturers Hario, Yama or Oji) has three tiers: the upper flask (for water with ice and a regulating tap), the middle flask-cylinder (for ground coffee) and the lower tank (where the finished drink flows). Because fresh water constantly washes the coffee instead of stagnating in it, Cold Drip gives a much brighter, clearer and more complex taste. The drink often takes on incredible alcohol, wine, cognac or fruit descriptors that cannot be achieved in a conventional immersion cold brew.</p>

<h3>{gold}Basic stages of brewing{/gold}</h3>
<p>You will need: Cold Drip tower, coffee (medium or slightly finer grind as for V60), ice and cold water mixture, round paper microfilters.</p>
<ul>
    <li>{gold}Step 1: Preparation of the medium flask.{/gold} At the bottom of the medium glass cylinder, place a ceramic orpaper filter.</li>
    <li>{gold}Step 2: Pouring coffee.{/gold} Pour ground coffee (standard ratio: 1:10 or 1:12, for example 50 grams per 500 ml of water). Lightly tap the sides of the flask so that the coffee bed becomes perfectly even. It is not necessary to press the coffee hard (temper), otherwise the water will not be able to pass through it.</li>
    <li>{gold}Step 3: Wetting.{/gold} Lightly wet the coffee bed with a little cold water to start the extraction process and avoid dry pockets.</li>
    <li>{gold}Step 4: Spreader Filter.{/gold} Place another round paper filter on top of the soaked coffee. This is a critically important step! The filter ensures that the drops from the upper flask will be evenly distributed over the entire area of the coffee bed, and not "dig" one deep hole in the center.</li>
    <li>{gold}Step 5: Setting up the drops.{/gold} Fill the top flask with a mixture of cold water and ice. Open the faucet and adjust the drop rate. The gold standard is 1 drop per 1-1.5 seconds.</li>
    <li>{gold}Step 6: Extraction.{/gold} Leave the tower running. The process usually takes 4 to 8 hours, depending on the volume of water. Periodically check the rate of drops, because as the water level in the upper flask decreases, the pressure drops and the tap needs to be opened slightly.</li>
    <li>{gold}Step 7: Feed.{/gold} After the process is complete, gently shake the bottom tank. The finished drink can be drunk immediately with ice, but experts recommend pouring it into an airtight bottle and leaving it in the refrigerator for a few days to "acquire" - the taste will become even more complex and liqueur-like.</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;


INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('espresso', 'en', 'Espresso', '', '<h1>{gold}Espresso: The History of Speed and the Physics of Pressure (15 to 9 bar){/gold}</h1>

> Espresso is the basis of the modern coffee world. It is not a type of grain or degree of roasting, but a unique method of preparation, where hot water under high hydrodynamic pressure passes through a pressed coffee tablet. 

<p>Today, the espresso industry is clearly divided into two parallel worlds: mass-market home coffee machines (where manufacturers flaunt figures of 15-19 bar) and professional commercial machines (where the benchmark remains a strict 9 bar). To understand this paradox, you need to look into the physics of the process and the history of its occurrence.</p><hr/><h2>{gold}1. History: From steam boilers to "cream"{/gold}</h2>
<p>The word "espresso" comes from the Italian "esprimere" (to squeeze) and "espresso" (fast, especially for you). At the end of the 19th century, coffee in Europe was brewed for a long time, which created queues in coffee shops. Engineers began to look for a way to speed up the process.</p>
<p>In 1884, Angelo Moriondo received a patentinvented the first steam coffee machine, but it prepared coffee in large volumes. The real revolution took place in 1901, when Luigi Bezzera created a machine with a holder (portafilter) for individually preparing one cup in seconds. However, these first machines used steam pressure (only 1.5-2 bars), so the coffee was liquid, extremely hot and often burnt.</p>

<h3>{gold}Birth of the Modern Formula (1947){/gold}</h3>
<p>Modern espresso was born thanks to Achille Gaggia. He abandoned steam and invented a lever (lever) system with a spring piston. This mechanism made it possible to isolate the heating of water from creating pressure. The force of the compressed spring pushed the water through the coffee with unprecedented pressure - about 8-10 bar. It was this high pressure that washed the essential oils out of the coffee, creating a thick golden foam on the surface of the drink, which Gadgia ingeniously called {gold}Caffè Crema{/gold}.</p><hr/><h2>{gold}2. Home coffee machines (De''Longhi and marketing 15-19 bar){/gold}</h2>
<p>When you buy a domestic carafe coffee maker (such as the basic De''Longhi, Krups or Saeco models), the box almost always says "Pressure 15 bar" or "19 bar" in big letters. It would seem that more means better. But in fact, this is a marketing trick due to the cheapness of internal components.</p>

<h3>{gold}Anatomy of domestic espresso{/gold}</h3>
<ul>
    <li>{gold}Vibrating pump:{/gold} Vibration pumps are installed in inexpensive machines. They are cheap, compact, but they pump up the pressure very sharply (reaching peaks of 15+ bar) and are not able to maintain it stably. Such machines often lack an overpressure relief valve (OPV).</li>
    <li>{gold}Pressurized Basket:{/gold} Since the average person at home buys coffee from the supermarket (which is often old or has the wrong grind), it is physically impossible to make a true espresso - the water will just flow through the grounds without resistance. That''s why manufacturers do a trick: they put a basket with a double bottom in the portafilter, where there is only one microscopic hole at the exit.</li>
    <li>{gold}Artificial foam:{/gold} This small hole artificially creates a huge resistance. A pressure of 15 bar is needed precisely to push water through this micro-hole. At the exit, the liquid mixes with air (aerates), creating a thick but artificial foam with large bubbles. It is an imitation of espresso, which forgives any grinding and aging of the grain, but does not reveal the true terroir of the coffee.</li>
</ul><hr/><h2>{gold}3. Professional machines: Reference 9 bar and perfect extraction{/gold}</h2>
<p>In commercial coffee machines (La Marzocco, Victoria Arduino, Slayer), the approach to the physics of the process is radically different. They do not create pressure for the sake of pressure. Their goal is a perfectly stable flow.</p>

<h3>{gold}The Anatomy of a Professional Espresso{/gold}</h3>
<ul>
    <li>{gold}Rotary pump:{/gold} Professional machines use massive rotary pumps that work silently and are able to deliver perfectly even pressure without any jumps or pulsations.</li><li>{gold}Unpressurized Baskets:{/gold} Commercial baskets (such as VST or IMS) have hundreds of perfectly even micro-holes all over the bottom. They do not create artificial resistance. The only thing that resists water is the coffee tablet itself.</li>
    <li>{gold}The Magic of 9 Bars:{/gold} Studies have shown that 9 bars is the ideal physical balance (Sweet Spot). Why not 15? Because at a pressure of more than 9-10 bar, the water compresses the coffee tablet so much that it turns into an impenetrable brick. Instead of evenly washing the coffee particles, water under an extreme pressure of 15 bar simply breaks holes in the weakest places of the tablet (tunneling/channeling). Extraction becomes terribly uneven: the drink turns out to be bitter and watery at the same time.</li>
    <li>{gold}Barista skill:{/gold} In order for the water to pass through the coffee in the standard 25-30 seconds at a pressure of 9 bar without an artificial basket, the barista must choose the perfect, microscopically precise grind on a professional coffee grinder. Real {gold}krémá{/gold} is formed here not by beating coffee against plastic, but by dissolving carbon dioxide and emulsifying coffee oils under ideal pressure.</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;


INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('aeropress', 'en', 'Aeropress', 'Versatile and durable. Allows you to experiment with pressure and time.', '<h1>{gold}Aeropress: The coffee revolution in the form of a large syringe{/gold}</h1>
> Aeropress (AeroPress) is one of the youngest, but at the same time, the most popular alternative methods of brewing coffee in the world. From the outside, this device looks like a large medical syringe made of medical grade plastic, but what it does with coffee beans borders on magic.
<p>The main feature of the aeropress is its incredible versatility and unpretentiousness. Thanks to the combination of immersion (infusing coffee in water) and pressure (pressing through a filter), it allows you to get a very clean, dense and rich cup of coffee, devoid of excessive bitterness. In addition, it is light, does not fray and is easy to clean, which has made it an absolute favorite among travelers, tourists and baristas.</p>
<hr/>
<h2>{gold}1. History: From flying rings to the perfect cup{/gold}</h2>
<p>The most interesting thing about the aeropress is its inventor. The device was not created by a coffee snob or hereditary barista, but by an American engineer and professor at Stanford University, Alan Adler.</p>
<p>Before coffee, Alan was known as the founder of the sports toy company Aerobie. His most famous invention at that time was the Aerobie Pro flying ring, which broke the Guinness world record for the distance of the throw.</p>
<h3>{gold}How did the engineer get to coffee?{/gold}</h3>
<p>In the early 2000s, in Los Altos (California, USA), Alan Adler was talking to a colleague''s wife who complained that she couldn''t find a way to make just one cup of delicious coffee without using a bulky drip coffee maker. Alan himself was annoyed by the bitterness and long brewing time of traditional methods.</p>
<p>He started experimenting in his garage. Adler realized that to reduce the bitterness (which is caused by over-extraction) you need to reduce the contact time of the coffee with the water and make the water temperature slightly lower than boiling. He used air pressure to get the water through the coffee quickly. After dozens of prototypes, in 2005 the world saw the first AeroPress. The coffee community beganKu was skeptical about the plastic tube, but after tasting the result, she quickly recognized the genius of the invention. Today, there are even World Aeropress Championships (World AeroPress Championship), where participants compete in the creativity of recipes.</p>
<hr/>
<h2>{gold}2. Basic stages of brewing{/gold}</h2>
<p>For both methods, you will need: the aeropress itself, a paper filter, coffee (a medium-fine grind like a purover or slightly finer), hot water (around 85-90°C) and a strong cup.</p>
<h3>{gold}Direct method (Classic){/gold}</h3>
<p>This is an original method invented by Alan Adler himself. It is the fastest and easiest.</p>
<ul>
    <li>{gold}Step 1: Preparation.{/gold} Insert the paper filter into the plastic mesh cover and rinse it with hot water (this will remove the taste of the paper and warm the system). Screw the lid on the flask.</li>
    <li>{gold}Step 2: Installation.{/gold} Place the capped flask on top of your cup.</li>
    <li>{gold}Step 3: Pour the coffee.{/gold} Pour the ground coffeeinto the flask (usually about 15-18 grams).</li>
    <li>{gold}Step 4: Pouring water.{/gold} Pour hot water (about 200-250 ml) so that it completely covers the coffee.</li>
    <li>{gold}Step 5: Stir.{/gold} Vigorously stir the coffee with the spatula (supplied) for 10 seconds.</li>
    <li>{gold}Step 6: Press down.{/gold} Insert the rubber plunger into the flask and begin to gently but firmly press down. The pressing process should take about 20-30 seconds. When you hear a hissing sound (air coming out through the coffee grounds), stop. The coffee is ready!</li>
</ul>
<h3>{gold}Inverted method (Inverted){/gold}</h3>
<p>This method was invented by enthusiasts. It allows the coffee to steep longer in the water because it does not seep through the filter at the beginning of the process. The body of the drink is denser.</p>
<ul>
    <li>{gold}Step 1: Assembly.{/gold} Insert the rubber plunger into the flask about 1-2 centimeters. Turn the structure over and place it on the table so that the porshwas from below, and the open hole of the flask was from above.</li>
    <li>{gold}Step 2: Pour the coffee.{/gold} Pour the ground coffee into the inverted flask.</li>
    <li>{gold}Step 3: Pouring water.{/gold} Carefully pour hot water.</li>
    <li>{gold}Step 4: Mixing and infusing.{/gold} Stir the liquid with a spatula so that no dry lumps remain. Leave to infuse (usually 1 to 2 minutes, depending on the recipe).</li>
    <li>{gold}Step 5: Preparing the filter.{/gold} While the coffee is brewing, insert the filter into the lid and rinse it with water. Carefully screw the cap onto the flask.</li>
    <li>{gold}Step 6: Flip.{/gold} Cover the aeropress with a cup (upside down). Holding the flask and cup firmly together, turn the structure 180 degrees with a quick and confident movement.</li>
    <li>{gold}Step 7: Pushing in.{/gold} Gently press the plunger until you hear a characteristic hissing sound. Delicious!</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;


INSERT INTO alternative_brewing_translations (recipe_key, language_code, name, description, content_html)
VALUES ('clever_dripper', 'en', 'Clever Dripper', '111222', '<h1>{gold}Clever Dripper: The perfect hybrid of immersion and percolation{/gold}</h1>

> Clever Dripper is a device ingenious in its simplicity, which combined the best features of two completely different worlds of brewing: the density and saturation of a French press with the incredible purity of a pourover.

<p>Clever''s main feature is its patented bottom shut-off valve. Unlike the classic V60, where water constantly flows through the coffee, the Clover holds the liquid inside the funnel for as long as you need it. This is a method of complete immersion (insistence). But as soon as you place the funnel on the cup, the valve automatically opens and the coffee is filtered through the paper by gravity (percolation). This device forgives almost all mistakes: you don''t need a special kettle with a thin spout, and you can not worry about the perfect technique of pouring water.</p><hr/><h2>{gold}1. History of origin: Taiwanese engineering thought{/gold}</h2>
<p>The inventor of the Clever Dripper is the Taiwanese company E.K. International Co., Ltd. (often known under the Abid brand), specializing in the production of polycarbonate and Tritan tableware. The device appeared on the market in the early 2000s.</p>
<p>The creators of Clever noticed a problem: coffee lovers loved the rich flavor of immersion methods (like the French press), but hated the coffee grounds ("muddy cup" defect) and oiliness that remained in the cup. Pourovers, on the other hand, produced a very clean cup, but required professional skill for an even extraction. Abid decided to combine the shape of the classic trapezoidal funnel under Melitta filters and the water retention mechanism.</p>

<h3>{gold}Anatomy of the "Smart Funnel"{/gold}</h3>
<p>The design consists of a body (most often made of health-safe Eastman Tritan plastic that does not contain BPA), a silicone stop valve (stopper valve) and a special stand-normalizer at the bottom. When the funnel is on the table, the valve is securely closed. When you place it on the cup, the edges of the cup press against the stand, raising the clawMr. and opening the way for liquid. This elegant mechanical solution has made Klever one of the most stable and predictable devices in third-wave coffee shops.</p><hr/><h2>{gold}2. Basic stages of brewing{/gold}</h2>
<p>To prepare, you will need: the Clever Dripper itself, a paper filter (trapezoid, usually size #4 or 1x4), coffee (grinds slightly coarser than medium, like a French press), hot water (about 92-96°C), a scale, and a sturdy cup.</p>

<h3>{gold}The modern method "Water First" {/gold}</h3>
<p>Traditionally, coffee was first poured, and then water was poured. But the world coffee community (in particular, expert James Hoffman) has proven that pouring water before coffee prevents clogging of the pores of the paper filter with small particles (fines). This guarantees a quick and smooth flow of coffee at the end.</p>
<ul>
    <li>{gold}Step 1: Preparing the filter.{/gold} Fold the paper filter along the two bottom and side seams. Insert it into Clover. With the valve closed, place the Clover on the cupin order to pour hot water over the filter (this will eliminate the taste of the paper and warm up the device). Drain this water from the cup.</li>
    <li>{gold}Step 2: Pouring water.{/gold} Place the Clover on the scale (not on the cup, just on the table). Pour in all the required amount of hot water (eg 250 ml).</li>
    <li>{gold}Step 3: Adding coffee.{/gold} Carefully pour ground coffee (15-18 grams) directly onto the surface of the hot water. Reset the timer.</li>
    <li>{gold}Step 4: Stirring.{/gold} Take a spoon and gently but thoroughly stir the coffee so that all the particles are submerged in the water and no dry lumps remain. Cover the Clover with the lid (it comes in the kit) to maintain the temperature.</li>
    <li>{gold}Step 5: Infusion (Immersion).{/gold} Leave the coffee to infuse for 2-3 minutes. Unlike pourover, here time works for you: immersion extracts the flavor very gently, so the risk of getting bitterness is minimal.</li>
    <li>{gold}Step 6: Break the "crusts".{/gold} After the infusion time is over, open the lid and paz lightly stir the surface of the coffee with a spoon. This will help the particles to settle to the bottom so that they do not interfere during draining.</li>
    <li>{gold}Step 7: Filtration (Drowdown).{/gold} Place the Clover on your cup. The valve will automatically open and the coffee will begin to filter through the paper and the coffee grounds layer. This process should take from 45 seconds to 1.5 minutes. When the liquid stops flowing, the coffee is ready!</li>
</ul>')
ON CONFLICT (recipe_key, language_code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    content_html = EXCLUDED.content_html;
