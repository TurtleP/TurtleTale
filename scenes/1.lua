return
{	
	{"setmap", "indoors"},
    {"spawncharacter", {"turtle", 32, 64}},
    {"freezeplayer"},
	{"fadein", 0.15},
    {"dofunction", {"player", "use", true}},
    {"sleep", 0.5},
    {"dofunction", {"player", "use", false}},
    {"sleep", 4.5},
    {"shake", 4},
    {"sleep", 2},
    {"dialog", {"turtle", "*yaawn*"}},
    {"sleep", 2},
    {"shake", 6},
    {"sleep", 1},
    {"dialog", {"turtle", "I don't wanna wake up. Just five more minut--"}},
    {"sleep", 0.2},
    {"shake", 8},
    {"sleep", 0.5},
    {"dofunction", {"player", "use", true}},
    {"sleep", 0.1},
    {"dofunction", {"player", "use", false}},
    {"shakeloop"},
    {"dialog", {"turtle", "Ow! What the heck is going on?"}},
    {"unfreezeplayer"}
}