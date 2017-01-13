return
{
	{"levelequals", "home"},
	{"freezeplayer"},
	{"sleep", 1},
	{"shake", 8},
	{"dialog", {"phoenix", "KYAAAAAAAAA!"}},
	{"sleep", 1},
	{"spawncharacter", {"phoenix", 400, -49}},
	{"dofunction", {"phoenix", "setstate", "glide"}},
	{"setspeed", {"phoenix", -200, 240}},
	{"shake", 4},
	{"sleep", 2},
	{"dofunction", {"phoenix", "showbook"}},
	{"setposition", {"phoenix", 162, 239}},
	{"setspeed", {"phoenix", -200, -240}},
	{"shake", 4},
	{"dofunction", {"player", "jump"}},
	{"dofunction", {"player", "setscale", -1}},
	{"dialog", {"turtle", "Not my family album! It's the only thing I have left!"}},
	{"unfreezeplayer"}
}