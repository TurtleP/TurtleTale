return
{
	{"levelequals", "mountain_1-9"},
	{"savegame"},
	{"freezeplayer"},
	{"walkcharacter", {"player", "rightKey", true}},
	{"sleep", 0.25},
	{"walkcharacter", {"player", "rightKey", false}},
	{"sleep", 0.25},
	{"unfreezeplayer"},
	{"sleep", 0.25},
	{"spawn", {"boss", "batboss", 0, 0}},
	{"playmusic", "tackle"},
	{"enemycount", {"boss", 0}},
	{"dofunction", {"block", 1, "unlock", true}},
	{"dofunction", {"chest", 1, "setVisible", true}}
}