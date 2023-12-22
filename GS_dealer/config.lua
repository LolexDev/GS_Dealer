Config = {}

Config.Locale = 'en' -- Jezik // Language
Config.KoristiNpceve = true -- Da li zelite da kupujete semena i to kod dilera(npc) // Do you want to buy seeds and other stuff at dealer(npc)
Config.KoristiBlipove = true -- Da li zelite da se na mapi pojavi blip dilera ostavite na true,a ako ne onda stavite na false // If u want to have blip on map of dealer don't change it from true but if u don't want to have blip set it to false
-- Config.KoristiUpozorenje = true -- Da li zelite da se izbaci upozorenje pre kupovanje droge // Do you want to alert the player before buying drugs

-- # Webhook Config
Config.LogHeader = "GS DEALER » Logs"
Config.Webhook = "" -- Discord webhook
-------------------------------------------------------

Config.Cene = {
    math.random(50,100),
    math.random(100,130),
    math.random(140,160),
    math.random(160,200),
}

Config.Diler = { -- Dealer
    {
        coords = vector4(-291.1383, 2543.1140, 75.4156, 0.9213),
        model = "a_m_m_og_boss_01",
    }
}

Config.Blipovi = {
    {
        Ime = "Dealer", -- Ime blipa // Name of blip
        Velicina = 1, -- Velicina blipa // Size of blip
        Boja = 6, -- Boja blipa // Color of blip
        Ikonica = 480, -- Blip sprite // Blip sprite
        Kordinate = vector3(-291.1383, 2543.1140, 75.4156), -- Kordinate blipa // Coords of blip
        Pokazuj = 6, -- Display
    }
}

Config.Itemi = { -- Stvari dodaj te jos po volji // Items add if u want more
    'meth',
    'joint',
}

Config.DilerKupuje = { -- Stvari koje diler hoce da kupi // Items that dealer wants to buy
    'meth',
    'joint',
}