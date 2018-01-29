return
{
	{"freeze", true},
	{"dialog", {"hermit", "Here, lay down and rest. You could use it"}},
	{"fadeout", 1},
	{"sleep", 1},
	{"savegame"},
	{"function", {"player", "setPosition", {"bed"}}},
	{"function", {"player", "use", {true}}},
	{"sleep", 1},
	{"fadein", 1},
	{"sleep", 1.5},
	--{"dialog", {nil, ""}},
	{"freeze", false},
	manual = true
}