return
{
	{"levelequals", "beach"},
	{"freezeplayer"},
	{"sleep", 1},
	{"shake", 8},
	{"dialog", {"phoenix", "KYAAAAAAAAA!"}},
	{"spawncharacter", {"phoenix", -75, 80}},
	{"dofunction", {"phoenix", "setscale", -1}},
	{"dofunction", {"phoenix", "setstate", "glide"}},
	{"setspeed", {"phoenix", 400, 0}},
	{"dialog", {"turtle", "Get back here, you!"}},
	{"sleep", 1},
	{"dialog", {"?", "AAAGH! SOMEONE HELP ME!"}},
	{"unfreezeplayer"}
}