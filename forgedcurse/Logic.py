json_world = {
    "regions": [
        "Menu",
        "main", # Starting area, caverns, mushroom hall
        "dwarven halls",
        "new moon rotunda",
        "eclipse knight sanctuary",
        "grapple closet",
        "waxing moon rotunda",
        "gibbous cleric grave",
        "forge storage",
        "pigcube den",
        "kobold village",
        "temple",
        "fortress grounds",
        "riverbank",
        "river fortress",
        "full moon rotunda",
        "fortress exit",
        "apogee mage grave",
        "secret storage",
        "sealed halls",
        "grappling hook room",
        "mini maze",
        "sealed depths",
        "waning moon rotunda" # victory
        ],
    "region_map": {
        "Menu": {
            "main": None
        },
        "main": {
            "dwarven halls": [
                ["red key"],
                ["crowbar"],
                ["bombs"],
                ["blink rod"],         
            ],
            "waxing moon rotunda": [
                ["crowbar", "orange key"],
                ["crowbar", "blink rod"],
                ["bombs", "orange key"],
                ["bombs", "blink rod"],
            ],
            "pigcube den": [
                ["blue key", "wooden sword", "leather armor"],
                ["blue key", "wooden sword", "iron armor"],
                ["blue key", "wooden sword", "gold armor"],
                ["blue key", "iron sword", "leather armor"],
                ["blue key", "iron sword", "iron armor"],
                ["blue key", "iron sword", "gold armor"],
                ["blue key", "gold sword", "leather armor"],
                ["blue key", "gold sword", "iron armor"],
                ["blue key", "gold sword", "gold armor"],
                ["blink rod"],
            ],
            "kobold village": {
                "default": [
                    ["orange key", "grappling hook", "crowbar"],
                    ["orange key", "grappling hook", "bombs"],
                ],
                "damage boost": [ 
                    ["orange key", "grappling hook", "crowbar"],
                    ["orange key", "grappling hook", "bombs"],
                    # orange key + break boarded passage + any three heart gems
                    ["orange key", "crowbar", "blink heart gem", "riverside heart gem", "pigcube heart gem",],
                    ["orange key", "crowbar", "blink heart gem", "riverside heart gem", "storage heart gem",],
                    ["orange key", "crowbar", "blink heart gem", "riverside heart gem", "fortress closet heart gem",],
                    ["orange key", "crowbar", "blink heart gem", "pigcube heart gem", "storage heart gem",],
                    ["orange key", "crowbar", "blink heart gem", "pigcube heart gem", "fortress closet heart gem",],
                    ["orange key", "crowbar", "blink heart gem", "storage heart gem", "fortress closet heart gem",],
                    ["orange key", "crowbar", "riverside heart gem", "pigcube heart gem", "storage heart gem"],
                    ["orange key", "crowbar", "riverside heart gem", "pigcube heart gem", "fortress closet heart gem",],
                    ["orange key", "crowbar", "riverside heart gem", "storage heart gem", "fortress closet heart gem",],
                    ["orange key", "crowbar", "pigcube heart gem", "storage heart gem", "fortress closet heart gem",],
                    ["orange key", "bombs", "blink heart gem", "riverside heart gem", "pigcube heart gem",],
                    ["orange key", "bombs", "blink heart gem", "riverside heart gem", "storage heart gem",],
                    ["orange key", "bombs", "blink heart gem", "riverside heart gem", "fortress closet heart gem",],
                    ["orange key", "bombs", "blink heart gem", "pigcube heart gem", "storage heart gem",],
                    ["orange key", "bombs", "blink heart gem", "pigcube heart gem", "fortress closet heart gem",],
                    ["orange key", "bombs", "blink heart gem", "storage heart gem", "fortress closet heart gem"],
                    ["orange key", "bombs", "riverside heart gem", "pigcube heart gem", "storage heart gem"],
                    ["orange key", "bombs", "riverside heart gem", "pigcube heart gem", "fortress closet heart gem",],
                    ["orange key", "bombs", "riverside heart gem", "storage heart gem", "fortress closet heart gem"],
                    ["orange key", "bombs", "pigcube heart gem", "storage heart gem", "fortress closet heart gem",],
                    ["blink rod"],
                ]
            },
            "forge storage": [["blink rod"]],
            "sealed halls": {
                "default": [
                    ["crossbow", "arrows", "cricket", "white key", "iron sword", "iron armor"],
                    ["crossbow", "arrows", "cricket", "white key", "iron sword", "gold armor"],
                    ["crossbow", "arrows", "cricket", "white key", "gold sword", "iron armor"],
                    ["crossbow", "arrows", "cricket", "white key", "gold sword", "gold armor"],
                ],
                "barrier skip": [
                    ["blink rod", "white key", "iron sword", "iron armor"],
                    ["blink rod", "white key", "iron sword", "gold armor"],
                    ["blink rod", "white key", "gold sword", "iron armor"],
                    ["blink rod", "white key", "gold sword", "gold armor"],
                    ["grappling hook", "white key", "iron sword", "iron armor"],
                    ["grappling hook", "white key", "iron sword", "gold armor"],
                    ["grappling hook", "white key", "gold sword", "iron armor"],
                    ["grappling hook", "white key", "gold sword", "gold armor"],
                    ["crossbow", "arrows", "cricket", "white key", "iron sword", "iron armor"],
                    ["crossbow", "arrows", "cricket", "white key", "iron sword", "gold armor"],
                    ["crossbow", "arrows", "cricket", "white key", "gold sword", "iron armor"],
                    ["crossbow", "arrows", "cricket", "white key", "gold sword", "gold armor"],                   
                ],
            },
        },
        "dwarven halls": {
            "new moon rotunda entrance": {
                "default": [
                    ["crowbar"],
                    ["bombs"],
                ],
                "damage boost": None
            },
            "kobold village": [
                ["green key", "crowbar"],
                ["blink rod", "crowbar"],
                ["green key", "bombs"],
                ["blink rod", "bombs"]
            ],
        },
        "new moon rotunda entrance": {
            "new moon rotunda": [
                ["red key","wooden sword"],
                ["red key","iron sword"],
                ["red key","gold sword"],
                ["blink rod","wooden sword"],
                ["blink rod","iron sword"],
                ["blink rod","gold sword"],
            ],
        },
        "new moon rotunda": {
            "grapple closet": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
        },
        "grapple closet": {
            "eclipse knight sanctuary": [
                ["push rod", "boat"],
                ["blink rod", "boat"],
            ],
            "new moon rotunda": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
            "dwarven halls": [["blink rod", "boat"]]
        },
         "eclipse knight sanctuary": {
            "grapple closet":[
                ["boat"],
            ]
         },
        "waxing moon rotunda": {
            "gibbous cleric grave": [
                ["green key"],
                ["blink rod"],
            ]
        },
        "pigcube den": {
            "forge storage": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
        },
        "kobold village": {
            "temple": [
                ["push rod", "wooden sword", "leather armor"],
                ["push rod", "wooden sword", "iron armor"],
                ["push rod", "wooden sword", "gold armor"],
                ["push rod", "iron sword", "leather armor"],
                ["push rod", "iron sword", "iron armor"],
                ["push rod", "iron sword", "gold armor"],
                ["push rod", "gold sword", "leather armor"],
                ["push rod", "gold sword", "iron armor"],
                ["push rod", "gold sword", "gold armor"],
                ["grappling hook", "wooden sword", "leather armor"],
                ["grappling hook", "wooden sword", "iron armor"],
                ["grappling hook", "wooden sword", "gold armor"],
                ["grappling hook", "iron sword", "leather armor"],
                ["grappling hook", "iron sword", "iron armor"],
                ["grappling hook", "iron sword", "gold armor"],
                ["grappling hook", "gold sword", "leather armor"],
                ["grappling hook", "gold sword", "iron armor"],
                ["grappling hook", "gold sword", "gold armor"],
                ["boat"],
            ],
            "fortress grounds": [
                ["boat"]
            ],
            "dwarven halls": [
                ["green key", "crowbar"],
                ["green key","bombs"],
                ["green key", "blink rod"],
            ],
            "eclipse knight sanctuary": [
                ["bombs", "blink rod"],
            ]
        },
        "temple": {
            "fortress grounds": [
                ["boat", "wooden sword", "leather armor"],
                ["boat", "wooden sword", "iron armor"],
                ["boat", "wooden sword", "gold armor"],
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
                ["grappling hook", "wooden sword", "leather armor"],
                ["grappling hook", "wooden sword", "iron armor"],
                ["grappling hook", "wooden sword", "gold armor"],
                ["grappling hook", "iron sword", "leather armor"],
                ["grappling hook", "iron sword", "iron armor"],
                ["grappling hook", "iron sword", "gold armor"],
                ["grappling hook", "gold sword", "leather armor"],
                ["grappling hook", "gold sword", "iron armor"],
                ["grappling hook", "gold sword", "gold armor"],
                ["blink rod", "wooden sword", "leather armor"],
                ["blink rod", "wooden sword", "iron armor"],
                ["blink rod", "wooden sword", "gold armor"],
                ["blink rod", "iron sword", "leather armor"],
                ["blink rod", "iron sword", "iron armor"],
                ["blink rod", "iron sword", "gold armor"],
                ["blink rod", "gold sword", "leather armor"],
                ["blink rod", "gold sword", "iron armor"],
                ["blink rod", "gold sword", "gold armor"],
            ],
            "kobold village": [
                #["push rod"],
                ["boat"],
                #["blink rod"],
            ] # imagine if this happened...
        },
        "fortress grounds": {
            "river fortress": {
                "default": [
                    ["crowbar", "grappling hook", "wooden sword", "leather armor"],
                    ["crowbar", "grappling hook", "wooden sword", "iron armor"],
                    ["crowbar", "grappling hook", "wooden sword", "gold armor"],
                    ["crowbar", "grappling hook", "iron sword", "leather armor"],
                    ["crowbar", "grappling hook", "iron sword", "iron armor"],
                    ["crowbar", "grappling hook", "iron sword", "gold armor"],
                    ["crowbar", "grappling hook", "gold sword", "leather armor"],
                    ["crowbar", "grappling hook", "gold sword", "iron armor"],
                    ["crowbar", "grappling hook", "gold sword", "gold armor"],
                    ["bombs", "grappling hook", "wooden sword", "leather armor"],
                    ["bombs", "grappling hook", "wooden sword", "iron armor"],
                    ["bombs", "grappling hook", "wooden sword", "gold armor"],
                    ["bombs", "grappling hook", "iron sword", "leather armor"],
                    ["bombs", "grappling hook", "iron sword", "iron armor"],
                    ["bombs", "grappling hook", "iron sword", "gold armor"],
                    ["bombs", "grappling hook", "gold sword", "leather armor"],
                    ["bombs", "grappling hook", "gold sword", "iron armor"],
                    ["bombs", "grappling hook", "gold sword", "gold armor"],
                ],
                "damage boost": [ #if crowbar or bombs, one heart gem required to tank spikes
                    ["crowbar", "wooden sword", "leather armor", "blink heart gem",],
                    ["crowbar", "wooden sword", "leather armor", "riverside heart gem",],
                    ["crowbar", "wooden sword", "leather armor", "pigcube heart gem",],
                    ["crowbar", "wooden sword", "leather armor", "storage heart gem",],
                    ["crowbar", "wooden sword", "leather armor", "fortress closet heart gem",],

                    ["crowbar", "wooden sword", "iron armor", "blink heart gem",],
                    ["crowbar", "wooden sword", "iron armor", "riverside heart gem",],
                    ["crowbar", "wooden sword", "iron armor", "pigcube heart gem",],
                    ["crowbar", "wooden sword", "iron armor", "storage heart gem",],
                    ["crowbar", "wooden sword", "iron armor", "fortress closet heart gem",],

                    ["crowbar", "wooden sword", "gold armor", "blink heart gem",],
                    ["crowbar", "wooden sword", "gold armor", "riverside heart gem",],
                    ["crowbar", "wooden sword", "gold armor", "pigcube heart gem",],
                    ["crowbar", "wooden sword", "gold armor", "storage heart gem",],
                    ["crowbar", "wooden sword", "gold armor", "fortress closet heart gem",],

                    ["crowbar", "iron sword", "leather armor", "blink heart gem",],
                    ["crowbar", "iron sword", "leather armor", "riverside heart gem",],
                    ["crowbar", "iron sword", "leather armor", "pigcube heart gem",],
                    ["crowbar", "iron sword", "leather armor", "storage heart gem",],
                    ["crowbar", "iron sword", "leather armor", "fortress closet heart gem",],

                    ["crowbar", "iron sword", "iron armor", "blink heart gem",],
                    ["crowbar", "iron sword", "iron armor", "riverside heart gem",],
                    ["crowbar", "iron sword", "iron armor", "pigcube heart gem",],
                    ["crowbar", "iron sword", "iron armor", "storage heart gem",],
                    ["crowbar", "iron sword", "iron armor", "fortress closet heart gem",],

                    ["crowbar", "iron sword", "gold armor", "blink heart gem",],
                    ["crowbar", "iron sword", "gold armor", "riverside heart gem",],
                    ["crowbar", "iron sword", "gold armor""pigcube heart gem",],
                    ["crowbar", "iron sword", "gold armor", "storage heart gem",],
                    ["crowbar", "iron sword", "gold armor", "fortress closet heart gem",],

                    ["crowbar", "gold sword", "leather armor", "blink heart gem",],
                    ["crowbar", "gold sword", "leather armor", "riverside heart gem",],
                    ["crowbar", "gold sword", "leather armor", "pigcube heart gem",],
                    ["crowbar", "gold sword", "leather armor", "storage heart gem",],
                    ["crowbar", "gold sword", "leather armor", "fortress closet heart gem",],

                    ["crowbar", "gold sword", "iron armor", "blink heart gem",],
                    ["crowbar", "gold sword", "iron armor", "riverside heart gem",],
                    ["crowbar", "gold sword", "iron armor", "pigcube heart gem",],
                    ["crowbar", "gold sword", "iron armor", "storage heart gem",],
                    ["crowbar", "gold sword", "iron armor", "fortress closet heart gem",],

                    ["crowbar", "gold sword", "gold armor", "blink heart gem",],
                    ["crowbar", "gold sword", "gold armor", "riverside heart gem",],
                    ["crowbar", "gold sword", "gold armor", "pigcube heart gem",],
                    ["crowbar", "gold sword", "gold armor", "storage heart gem",],
                    ["crowbar", "gold sword", "gold armor", "fortress closet heart gem",],

                    ["bombs", "wooden sword", "leather armor", "blink heart gem",],
                    ["bombs", "wooden sword", "leather armor", "riverside heart gem",],
                    ["bombs", "wooden sword", "leather armor", "pigcube heart gem",],
                    ["bombs", "wooden sword", "leather armor", "storage heart gem",],
                    ["bombs", "wooden sword", "leather armor", "fortress closet heart gem",],

                    ["bombs", "wooden sword", "iron armor", "blink heart gem",],
                    ["bombs", "wooden sword", "iron armor", "riverside heart gem",],
                    ["bombs", "wooden sword", "iron armor", "pigcube heart gem",],
                    ["bombs", "wooden sword", "iron armor", "storage heart gem",],
                    ["bombs", "wooden sword", "iron armor", "fortress closet heart gem",],

                    ["bombs", "wooden sword", "gold armor", "blink heart gem",],
                    ["bombs", "wooden sword", "gold armor", "riverside heart gem",],
                    ["bombs", "wooden sword", "gold armor", "pigcube heart gem",],
                    ["bombs", "wooden sword", "gold armor", "storage heart gem",],
                    ["bombs", "wooden sword", "gold armor", "fortress closet heart gem",],

                    ["bombs", "iron sword", "leather armor", "blink heart gem",],
                    ["bombs", "iron sword", "leather armor", "riverside heart gem",],
                    ["bombs", "iron sword", "leather armor", "pigcube heart gem",],
                    ["bombs", "iron sword", "leather armor", "storage heart gem",],
                    ["bombs", "iron sword", "leather armor", "fortress closet heart gem",],

                    ["bombs", "iron sword", "iron armor", "blink heart gem",],
                    ["bombs", "iron sword", "iron armor", "riverside heart gem",],
                    ["bombs", "iron sword", "iron armor", "pigcube heart gem",],
                    ["bombs", "iron sword", "iron armor", "storage heart gem",],
                    ["bombs", "iron sword", "iron armor", "fortress closet heart gem",],

                    ["bombs", "iron sword", "gold armor", "blink heart gem",],
                    ["bombs", "iron sword", "gold armor", "riverside heart gem",],
                    ["bombs", "iron sword", "gold armor", "pigcube heart gem",],
                    ["bombs", "iron sword", "gold armor", "storage heart gem",],
                    ["bombs", "iron sword", "gold armor", "fortress closet heart gem",],

                    ["bombs", "gold sword", "leather armor", "blink heart gem",],
                    ["bombs", "gold sword", "leather armor", "riverside heart gem",],
                    ["bombs", "gold sword", "leather armor", "pigcube heart gem",],
                    ["bombs", "gold sword", "leather armor", "storage heart gem",],
                    ["bombs", "gold sword", "leather armor", "fortress closet heart gem",],

                    ["bombs", "gold sword", "iron armor", "blink heart gem",],
                    ["bombs", "gold sword", "iron armor", "riverside heart gem",],
                    ["bombs", "gold sword", "iron armor", "pigcube heart gem",],
                    ["bombs", "gold sword", "iron armor", "storage heart gem",],
                    ["bombs", "gold sword", "iron armor", "fortress closet heart gem",],

                    ["bombs", "gold sword", "gold armor", "blink heart gem",],
                    ["bombs", "gold sword", "gold armor", "riverside heart gem",],
                    ["bombs", "gold sword", "gold armor", "pigcube heart gem",],
                    ["bombs", "gold sword", "gold armor", "storage heart gem",],
                    ["bombs", "gold sword", "gold armor", "fortress closet heart gem",],

                    ["blink rod", "wooden sword", "leather armor"],
                    ["blink rod", "wooden sword", "iron armor"],
                    ["blink rod", "wooden sword", "gold armor"],
                    ["blink rod", "iron sword", "leather armor"],
                    ["blink rod", "iron sword", "iron armor"],
                    ["blink rod", "iron sword", "gold armor"],
                    ["blink rod", "gold sword", "leather armor"],
                    ["blink rod", "gold sword", "iron armor"],
                    ["blink rod", "gold sword", "gold armor"],
                ]
            },
            "riverbank": [
                ["grappling hook"],
                ["boat"]
            ],
            "temple": [
                ["grappling hook"],
                ["boat"],
                ["blink rod"],
            ]
        },
        "riverbank": {
            "secret storage": [["bombs"]],
            "fortress exit": [
                ["boat"],
                ["blink rod"],
            ]
        },
        "river fortress": {
            "river fortress exit": [
                ["push rod", "grappling hook"],
                ["push rod", "boat"]
            ]
        },
        "full moon rotunda": {
            "apogee mage grave": [
                ["grappling hook"],
                ["boat"]
            ],
            "riverbank": [
                ["boat", "blink rod"]
            ]
        },
        "fortress exit": {
            "river fortress": [
                ["boat", "wooden sword", "leather armor"],
                ["boat", "wooden sword", "iron armor"],
                ["boat", "wooden sword", "gold armor"],
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
            ],
            "full moon rotunda": [
                ["blue key", "boat", "iron sword", "iron armor"],
                ["blue key", "boat", "iron sword", "gold armor"],
                ["blue key", "boat", "gold sword", "iron armor"],
                ["blue key", "boat", "gold sword", "gold armor"],
                ["blue key", "grappling hook", "iron sword", "iron armor"],
                ["blue key", "grappling hook", "iron sword", "gold armor"],
                ["blue key", "grappling hook", "gold sword", "iron armor"],
                ["blue key", "grappling hook", "gold sword", "gold armor"],
                ["blue key", "blink rod", "iron sword", "iron armor"],
                ["blue key", "blink rod", "iron sword", "gold armor"],
                ["blue key", "blink rod", "gold sword", "iron armor"],
                ["blue key", "blink rod", "gold sword", "gold armor"],
            ],
            "riverbank": [
                ["boat"],
                ["blink rod"]
            ],
        },
        "secret storage": {
            "sealed depths": [
                ["white key", "boat", "iron sword", "iron armor"],
                ["white key", "boat", "iron sword", "gold armor"],
                ["white key", "boat", "gold sword", "iron armor"],
                ["white key", "boat", "gold sword", "gold armor"],
            ],
            "riverbank": [
                ["bombs"],
                ["boat", "blink rod"]
            ],
        },
        "sealed halls": {
            "grappling hook room": [["grappling hook"]],
            "mini maze": [
                ["blink rod"]
            ]
        },
        "grappling hook room": {
            "mini maze": [
                ["red key", "orange key", "green key", "blue key", "crowbar"],
                ["red key", "orange key", "green key", "blue key", "bombs"],
                ["blink rod"]
            ],
        },
        "mini maze": {
            "grappling hook room":[
                ["red key", "orange key", "green key", "blue key", "crowbar"],
                ["red key", "orange key", "green key", "blue key", "bombs"],
                ["blink rod"]
            ],
            "sealed depths": [
                ["white key"],
                ["blink rod"]
            ],
            "sealed halls": [
                ["blink rod"]
            ]
        },
        "sealed depths": {
            "mini maze": [
                ["white key"],
                ["blink rod"]
            ],
            "waning moon rotunda": [
                ["green key", "white key", "gold sword"],
                ["green key", "blink rod", "gold sword"],
                ["blue key", "blink rod", "gold sword"],
                ["red key", "blink rod", "gold sword"]
            ],
            "secret storage": [
                ["boat","white key"],
                ["boat","blink rod"]
            ],
        },
        #"waning moon rotunda": {},
    },
    "location_map": {
        "main": {
            #"riverside chest": [
            #    ["wooden sword"],
            #    ["iron sword"],
            #    ["gold sword"],
            #],
            "riverside chest": {
                "default": [
                    ["wooden sword"],
                    ["iron sword"],
                    ["gold sword"],
                ],
                "damage boost": None,
            },
            "kikku chest": None,
            "wooden sword chest": None,
            "leather armor chest": None,
            "red key chest": None,
            "anvil chest": None,
            "forge check": [
                ["crowbar", "anvil", "hammer", "bellows"],
                ["blink rod", "anvil", "hammer", "bellows"],
                ["bombs", "anvil", "hammer", "bellows"],
            ],
            "spider storage chest": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
            "slime island chest": [
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
            ],
            "secret ingredient mimic": [
                ["boat", "wooden sword"],
                ["boat", "iron sword"],
                ["boat", "gold sword"],
                ["bombs", "blink rod", "wooden sword"],
                ["bombs", "blink rod", "iron sword"],
                ["bombs", "blink rod", "gold sword"],
            ],
            "gold armor chest": [
                ["bombs"],
            ],
            "mushroom cave": [
                ["bombs"],
                ["blink rod"],
            ],
        },
        "dwarven halls": {
            "orange key chest": [["crowbar"], ["bombs"]],
        },
        "new moon rotunda entrance": {
            "nmr left chest": [
                ["grappling hook"],
                ["boat"],
            ],
            "nmr right chest": [
                ["grappling hook"],
                ["boat"],
            ],
            "pigcube hideaway chest": [
                ["push rod"],
                ["blink rod"]
            ],
        },
        "new moon rotunda": {
            "blink chest": [["bombs", "blink rod"]],
            "nmr left chest": {
                "default": [ # this isn't the ideal way of handling this             
                    ["boat", "red key"], 
                ],
                "blink rod logic": [["blink rod"]]
            },
            "nmr right chest": {
                "default": [ # this isn't the ideal way of handling this                
                    ["boat", "red key"],
                ],
                "blink rod logic": [["blink rod"]]
            },
        },
        "grapple closet": {
            "grappling hook chest": None,
        },
        "eclipse knight sanctuary": {
            "eclipse knight sanctuary chest": None,
        },
        "waxing moon rotunda": {
            "waxing moon mimic": [
                ["wooden sword"],
                ["iron sword"],
                ["gold sword"],
            ],
            "waxing moon chest": None,
        },
        "gibbous cleric grave": {
            "gibbous cleric grave chest": None,
        },
        "forge storage": {
            "iron armor chest": None,
            "iron sword chest": None,
        },
        "pigcube den": {
            "pigcube hall chest": None,
            "pigcube closet chest": [
                ["bombs"],
                ["blink rod"],
            ]
        },
        "kobold village": {
            "map": None,
            "kobold cave north chest": None,
            "kobold cave south chest": None,
            "shed chest": [
                ["crowbar"],
                ["bombs"]
            ],
            "kobold home chest": [
                ["bombs"],
                ["skeleton key"],
                ["blink rod"]
            ],
            "pig pen chest": [
                ["blue key"],
                ["blink rod"]
            ],
        },
        "temple": {
            "temple north chest": None,
            "temple south chest": None,
            "unknown priest grave chest": [["bombs", "push rod", "blink rod"]],
        },
        "riverbank": {
            "lower riverbank chest": None,
        },
        "river fortress": {
            "fortress lionsmane chest": None,
            "fortress gnoglic chest": None,
            "fortress amanita chest": None,
            "fortress browncap chest": None,
            "fortress blocked chest": [
                ["push rod"],
                ["blink rod"]
            ],
            "fortress closet chest": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"]
            ],
        },
        "fortress exit": {
            "fortress exit chest": None,
        },
        "apogee mage grave": {
            "apogee mage grave chest": None,
        },
        "secret storage": {
            "secret storage left chest": None,
            "secret storage center chest": None,
            "secret storage right chest": None,
        },
        "sealed halls": {
            "pot maze left chest": None,
            "pot maze right chest": None,
        },
        "grappling hook room": {
            "default": {
                "ghr center chest": None,
            },
            "damage boost": { # -160HP total, -100HP longest stretch
                "ghr center chest": [
                    ["blink rod"],
                    ["blink heart gem"], 
                    ["riverside heart gem"], 
                    ["pigcube heart gem"], 
                    ["storage heart gem"], 
                    ["fortress closet heart gem"]
                ]
            },
            "ghr north chest": None, # damage boost: -80HP, easy to tank
        },
        "sealed depths": {
            "mini maze center": None,
            "mini maze right": None,
            "monty hall door chest": [
                ["white key"],
                #["blink rod"],
            ],
        },
        "waning moon rotunda": {
            "victory": [ # crescent artificer grave chest
                ["grappling hook"],
                ["boat"],
                ["blink rod"],
            ],
        },
    },
    "items": {
        "prog_items": [
            "anvil",
            "bellows",
            "hammer",
            "crowbar",
            "grappling hook",
            "boat",
            "push rod",
            "blink rod",
            "bombs",
            "crossbow",
            "arrows",
            "red key",
            "blue key",
            "green key",
            "orange key",
            "white key",
            "skeleton key",
            "cricket",
            "wooden sword",
            "iron sword",
            "gold sword",
            "leather armor",
            "iron armor",
            "gold armor",
            "blink heart gem",
            "riverside heart gem",
            "pigcube heart gem",
            "storage heart gem",
            "fortress closet heart gem",
        ],
        "useful_items": [
            "map",
        ],
        "filler_items": [
            "kobold's loot",
            "nmr left loot",
            "nmr right loot",
            "kobold cave loot",
            "pig pen loot",
            "hideaway loot",
            "lionsmane loot",
            "gnoglic loot",
            "amanita loot",
            "browncap loot",
            "spider's loot",
            "snake's loot",
            "mimic's loot",
            "fort exit loot",
            "hallway loot",
            "ghr top loot",
            "pot maze loot",
            "winner's loot",
            "ghr left loot",
            "riverside loot",
            "minimaze top loot",
            "minimaze right loot",
            "storage left loot",
            "storage right loot",
            # filler loot
            # "loot",
        ],
    },
    "base_id": 99117114115101, # "curse" in decimal (99 117 114 115 101)
    "game_name": "Forged Curse",
    "filler_name": "loot",
}

og_json_world = {
    "regions": [
        "Menu",
        "main", # Starting area, caverns, mushroom hall
        "dwarven halls",
        "new moon rotunda",
        "eclipse knight sanctuary",
        "grapple closet",
        "waxing moon rotunda",
        "gibbous cleric grave",
        "forge storage",
        "pigcube den",
        "kobold village",
        "temple",
        "fortress grounds",
        "riverbank",
        "river fortress",
        "full moon rotunda",
        "fortress exit",
        "apogee mage grave",
        "secret storage",
        "sealed halls",
        "grappling hook room",
        "mini maze",
        "sealed depths",
        "waning moon rotunda" # victory
        ],
    "region_map": {
        "Menu": {
            "main": None
        },
        "main": {
            "dwarven halls": [
                ["red key"],
                ["crowbar"],
                ["bombs"],
                ["blink rod"],         
            ],
            "waxing moon rotunda": [
                ["crowbar", "orange key"],
                ["crowbar", "blink rod"],
                ["bombs", "orange key"],
                ["bombs", "blink rod"],
            ],
            "pigcube den": [
                ["blue key", "wooden sword", "leather armor"],
                ["blue key", "wooden sword", "iron armor"],
                ["blue key", "wooden sword", "gold armor"],
                ["blue key", "iron sword", "leather armor"],
                ["blue key", "iron sword", "iron armor"],
                ["blue key", "iron sword", "gold armor"],
                ["blue key", "gold sword", "leather armor"],
                ["blue key", "gold sword", "iron armor"],
                ["blue key", "gold sword", "gold armor"],
                ["blink rod"],
            ],
            "kobold village": [
                ["orange key", "grappling hook", "crowbar"],
                ["orange key", "grappling hook", "bombs"],
                #["blink rod"],
            ],
            "forge storage": [["blink rod"]],
            "sealed halls": [
                ["crossbow", "arrows", "cricket", "white key", "iron sword", "iron armor"],
                ["crossbow", "arrows", "cricket", "white key", "iron sword", "gold armor"],
                ["crossbow", "arrows", "cricket", "white key", "gold sword", "iron armor"],
                ["crossbow", "arrows", "cricket", "white key", "gold sword", "gold armor"],
            ],
        },
        "dwarven halls": {
            "new moon rotunda entrance": [
                ["crowbar"],
                ["bombs"],
            ],
            #"grapple closet": [["boat", "blink rod"],],
            #"pigcube den": [
            #    ["blue key", "crowbar", "wooden sword", "leather armor"],
            #    ["blink rod", "crowbar", "wooden sword", "leather armor"]
            #],
            "kobold village": [
                ["green key", "crowbar"],
                ["blink rod", "crowbar"],
                ["green key", "bombs"],
                ["blink rod", "bombs"]
            ],
            #"waxing moon rotunda": [["blink rod"],],
            #"gibbous cleric grave": [["blink rod"],],
        },
        "new moon rotunda entrance": {
            "new moon rotunda": [
                ["red key","wooden sword"],
                ["red key","iron sword"],
                ["red key","gold sword"],
                ["blink rod","wooden sword"],
                ["blink rod","iron sword"],
                ["blink rod","gold sword"],
            ],
        },
        "new moon rotunda": {
            "grapple closet": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
            #"eclipse knight sanctuary": [["blink rod", "boat"],]
        },
        "grapple closet": {
            "eclipse knight sanctuary": [
                ["push rod", "boat"],
                ["blink rod", "boat"],
            ],
            "new moon rotunda": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
            "dwarven halls": [["blink rod", "boat"]]
        },
         "eclipse knight sanctuary": {
            "grapple closet":[
                ["boat"],
            ]
         },
        "waxing moon rotunda": {
            "gibbous cleric grave": [
                ["green key"],
                ["blink rod"],
            ]
        },
        #"gibbous cleric grave": {
            #"dwarven halls": [["blink rod"]],
            #"waxing moon rotunda": [
            #    ["green key"],
            #    ["blink rod"],
            #]
        #},
        #"forge storage": {},
        "pigcube den": {
            "forge storage": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
        },
        "kobold village": {
            "temple": [
                ["push rod", "wooden sword", "leather armor"],
                ["push rod", "wooden sword", "iron armor"],
                ["push rod", "wooden sword", "gold armor"],
                ["push rod", "iron sword", "leather armor"],
                ["push rod", "iron sword", "iron armor"],
                ["push rod", "iron sword", "gold armor"],
                ["push rod", "gold sword", "leather armor"],
                ["push rod", "gold sword", "iron armor"],
                ["push rod", "gold sword", "gold armor"],
                ["grappling hook", "wooden sword", "leather armor"],
                ["grappling hook", "wooden sword", "iron armor"],
                ["grappling hook", "wooden sword", "gold armor"],
                ["grappling hook", "iron sword", "leather armor"],
                ["grappling hook", "iron sword", "iron armor"],
                ["grappling hook", "iron sword", "gold armor"],
                ["grappling hook", "gold sword", "leather armor"],
                ["grappling hook", "gold sword", "iron armor"],
                ["grappling hook", "gold sword", "gold armor"],
                ["boat"],
                #["blink rod"],
            ],
            "fortress grounds": [
                #["grappling hook"],
                ["boat"]
            ],
            "dwarven halls": [
                ["green key", "crowbar"],
                ["green key","bombs"],
                ["green key", "blink rod"],
            ],
            "eclipse knight sanctuary": [
                ["bombs", "blink rod"],
            ]
        },
        "temple": {
            "fortress grounds": [
                ["boat", "wooden sword", "leather armor"],
                ["boat", "wooden sword", "iron armor"],
                ["boat", "wooden sword", "gold armor"],
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
                ["grappling hook", "wooden sword", "leather armor"],
                ["grappling hook", "wooden sword", "iron armor"],
                ["grappling hook", "wooden sword", "gold armor"],
                ["grappling hook", "iron sword", "leather armor"],
                ["grappling hook", "iron sword", "iron armor"],
                ["grappling hook", "iron sword", "gold armor"],
                ["grappling hook", "gold sword", "leather armor"],
                ["grappling hook", "gold sword", "iron armor"],
                ["grappling hook", "gold sword", "gold armor"],
                ["blink rod", "wooden sword", "leather armor"],
                ["blink rod", "wooden sword", "iron armor"],
                ["blink rod", "wooden sword", "gold armor"],
                ["blink rod", "iron sword", "leather armor"],
                ["blink rod", "iron sword", "iron armor"],
                ["blink rod", "iron sword", "gold armor"],
                ["blink rod", "gold sword", "leather armor"],
                ["blink rod", "gold sword", "iron armor"],
                ["blink rod", "gold sword", "gold armor"],
            ],
            "kobold village": [
                #["push rod"],
                ["boat"],
                #["blink rod"],
            ] # imagine if this happened...
        },
        "fortress grounds": {
            "river fortress": [
                ["crowbar", "grappling hook", "wooden sword", "leather armor"],
                ["crowbar", "grappling hook", "wooden sword", "iron armor"],
                ["crowbar", "grappling hook", "wooden sword", "gold armor"],
                ["crowbar", "grappling hook", "iron sword", "leather armor"],
                ["crowbar", "grappling hook", "iron sword", "iron armor"],
                ["crowbar", "grappling hook", "iron sword", "gold armor"],
                ["crowbar", "grappling hook", "gold sword", "leather armor"],
                ["crowbar", "grappling hook", "gold sword", "iron armor"],
                ["crowbar", "grappling hook", "gold sword", "gold armor"],
                ["bombs", "grappling hook", "wooden sword", "leather armor"],
                ["bombs", "grappling hook", "wooden sword", "iron armor"],
                ["bombs", "grappling hook", "wooden sword", "gold armor"],
                ["bombs", "grappling hook", "iron sword", "leather armor"],
                ["bombs", "grappling hook", "iron sword", "iron armor"],
                ["bombs", "grappling hook", "iron sword", "gold armor"],
                ["bombs", "grappling hook", "gold sword", "leather armor"],
                ["bombs", "grappling hook", "gold sword", "iron armor"],
                ["bombs", "grappling hook", "gold sword", "gold armor"],
                #["blink rod"],
            ],
            "riverbank": [
                ["grappling hook"],
                ["boat"]
            ],
            "temple": [
                ["grappling hook"],
                ["boat"],
                ["blink rod"],
            ]
        },
        "riverbank": {
            "secret storage": [["bombs"]],
            #"river fortress": [["boat"]],#, "grappling hook"]],
            "fortress exit": [
                ["boat"],
                ["blink rod"],
            ]
        },
        "river fortress": {
            #"apogee mage grave": [["boat", "blink rod"]],
            "river fortress exit": [
                ["push rod", "grappling hook"],
                ["push rod", "boat"]
            ]
        },
        "full moon rotunda": {
            "apogee mage grave": [
                ["grappling hook"],
                ["boat"]
            ],
            "riverbank": [
                ["boat", "blink rod"]
            ]
        },
        "fortress exit": {
            "river fortress": [
                ["boat", "wooden sword", "leather armor"],
                ["boat", "wooden sword", "iron armor"],
                ["boat", "wooden sword", "gold armor"],
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
            ],
            "full moon rotunda": [
                ["blue key", "boat", "iron sword", "iron armor"],
                ["blue key", "boat", "iron sword", "gold armor"],
                ["blue key", "boat", "gold sword", "iron armor"],
                ["blue key", "boat", "gold sword", "gold armor"],
                ["blue key", "grappling hook", "iron sword", "iron armor"],
                ["blue key", "grappling hook", "iron sword", "gold armor"],
                ["blue key", "grappling hook", "gold sword", "iron armor"],
                ["blue key", "grappling hook", "gold sword", "gold armor"],
                ["blue key", "blink rod", "iron sword", "iron armor"],
                ["blue key", "blink rod", "iron sword", "gold armor"],
                ["blue key", "blink rod", "gold sword", "iron armor"],
                ["blue key", "blink rod", "gold sword", "gold armor"],
                #["boat", "blink rod"]
            ],
            "riverbank": [
                ["boat"],
                ["blink rod"]
            ],
        },
        "secret storage": {
            "sealed depths": [
                ["white key", "boat", "iron sword", "iron armor"],
                ["white key", "boat", "iron sword", "gold armor"],
                ["white key", "boat", "gold sword", "iron armor"],
                ["white key", "boat", "gold sword", "gold armor"],
                #["blink rod"]
            ],
            "riverbank": [
                ["bombs"],
                ["boat", "blink rod"]
            ],
        },
        "sealed halls": {
            "grappling hook room": [["grappling hook"]],
            "mini maze": [
                ["blink rod"]
            ]
        },
        "grappling hook room": {
            "mini maze": [
                ["red key", "orange key", "green key", "blue key", "crowbar"],
                ["red key", "orange key", "green key", "blue key", "bombs"],
                ["blink rod"]
            ],
        },
        "mini maze": {
            "grappling hook room":[
                ["red key", "orange key", "green key", "blue key", "crowbar"],
                ["red key", "orange key", "green key", "blue key", "bombs"],
                ["blink rod"]
            ],
            "sealed depths": [
                ["white key"],
                ["blink rod"]
            ],
            "sealed halls": [
                ["blink rod"]
            ]
        },
        "sealed depths": {
            "mini maze": [
                ["white key"],
                ["blink rod"]
            ],
            "waning moon rotunda": [
                ["green key", "white key", "gold sword"],
                ["green key", "blink rod", "gold sword"],
                ["blue key", "blink rod", "gold sword"],
                ["red key", "blink rod", "gold sword"]
            ],
            "secret storage": [
                ["boat","white key"],
                ["boat","blink rod"]
            ],
        },
        #"waning moon rotunda": {},
    },
    "location_map": {
        "main": {
            "riverside chest": [
                ["wooden sword"],
                ["iron sword"],
                ["gold sword"],
            ],
            "kikku chest": None,
            "wooden sword chest": None,
            "leather armor chest": None,
            "red key chest": None,
            "anvil chest": None,
            "forge check": [
                ["crowbar", "anvil", "hammer", "bellows"],
                ["blink rod", "anvil", "hammer", "bellows"],
                ["bombs", "anvil", "hammer", "bellows"],
            ],
            "spider storage chest": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
            "slime island chest": [
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
            ],
            "secret ingredient mimic": [
                ["boat", "wooden sword"],
                ["boat", "iron sword"],
                ["boat", "gold sword"],
                ["bombs", "blink rod", "wooden sword"],
                ["bombs", "blink rod", "iron sword"],
                ["bombs", "blink rod", "gold sword"],
            ],
            "gold armor chest": [
                ["bombs"],
                #["blink rod"],
            ],
            "mushroom cave": [
                ["bombs"],
                ["blink rod"],
            ],
        },
        "dwarven halls": {
            "orange key chest": [["crowbar"], ["bombs"]],
        },
        "new moon rotunda entrance": {
            "nmr left chest": [
                ["grappling hook"],
                ["boat"],
                #["blink rod"]
            ],
            "nmr right chest": [
                ["grappling hook"],
                ["boat"],
                #["blink rod"]
            ],
            "pigcube hideaway chest": [
                ["push rod"],
                ["blink rod"]
            ],
        },
        "new moon rotunda": {
            "blink chest": [["bombs", "blink rod"]],
        },
        "grapple closet": {
            "grappling hook chest": None,
        },
        "eclipse knight sanctuary": {
            "eclipse knight sanctuary chest": None,
        },
        "waxing moon rotunda": {
            "waxing moon mimic": [
                ["wooden sword"],
                ["iron sword"],
                ["gold sword"],
            ],
            "waxing moon chest": None,
        },
        "gibbous cleric grave": {
            "gibbous cleric grave chest": None,
        },
        "forge storage": {
            "iron armor chest": None,
            "iron sword chest": None,
        },
        "pigcube den": {
            "pigcube hall chest": None,
            "pigcube closet chest": [
                ["bombs"],
                ["blink rod"],
            ]
        },
        "kobold village": {
            "map": None,
            "kobold cave north chest": None,
            "kobold cave south chest": None,
            "shed chest": [
                ["crowbar"],
                ["bombs"]
            ],
            "kobold home chest": [
                ["bombs"],
                ["skeleton key"],
                ["blink rod"]
            ],
            "pig pen chest": [
                ["blue key"],
                ["blink rod"]
            ],
        },
        "temple": {
            "temple north chest": None,
            "temple south chest": None,
            "unknown priest grave chest": [["bombs", "push rod", "blink rod"]],
        },
        #"fortress grounds": {
            # already listed under main
            #"slime island chest": [["boat"]],
        #},
        "riverbank": {
            "lower riverbank chest": None,
        },
        "river fortress": {
            "fortress lionsmane chest": None,
            "fortress gnoglic chest": None,
            "fortress amanita chest": None,
            "fortress browncap chest": None,
            "fortress blocked chest": [
                ["push rod"],
                ["blink rod"]
            ],
            "fortress closet chest": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"]
            ],
        },
        "fortress exit": {
            "fortress exit chest": None,
        },
        #"full moon rotunda": {},
        "apogee mage grave": {
            "apogee mage grave chest": None,
        },
        "secret storage": {
            "secret storage left chest": None,
            "secret storage center chest": None,
            "secret storage right chest": None,
        },
        "sealed halls": {
            "pot maze left chest": None,
            "pot maze right chest": None,
        },
        "grappling hook room": {
            "ghr center chest": None,
            "ghr north chest": None,
        },
        "sealed depths": {
            "mini maze center": None,
            "mini maze right": None,
            "monty hall door chest": [
                ["white key"],
                #["blink rod"],
            ],
        },
        "waning moon rotunda": {
            "victory": [ # crescent artificer grave chest
                ["grappling hook"],
                ["boat"],
                ["blink rod"],
            ],
        },
    },
    "items": {
        "prog_items": [
            "anvil",
            "bellows",
            "hammer",
            "crowbar",
            "grappling hook",
            "boat",
            "push rod",
            "blink rod",
            "bombs",
            "crossbow",
            "arrows",
            "red key",
            "blue key",
            "green key",
            "orange key",
            "white key",
            "skeleton key",
            "cricket",
            "wooden sword",
            "iron sword",
            "gold sword",
            "leather armor",
            "iron armor",
            "gold armor",
        ],
        "useful_items": [
            "blink heart gem",
            "riverside heart gem",
            "pigcube heart gem",
            "storage heart gem",
            "fortress closet heart gem",
            "map",
        ],
        "filler_items": [
            "kobold's loot",
            "nmr left loot",
            "nmr right loot",
            "kobold cave loot",
            "pig pen loot",
            "hideaway loot",
            "lionsmane loot",
            "gnoglic loot",
            "amanita loot",
            "browncap loot",
            "spider's loot",
            "snake's loot",
            "mimic's loot",
            "fort exit loot",
            "hallway loot",
            "ghr top loot",
            "pot maze loot",
            "winner's loot",
            "ghr left loot",
            "riverside loot",
            "minimaze top loot",
            "minimaze right loot",
            "storage left loot",
            "storage right loot",
            # filler loot
            # "loot",
        ],
    },
    "base_id": 99117114115101, # "curse" in decimal (99 117 114 115 101)
    "game_name": "Forged Curse",
    "filler_name": "loot",
}