return
{
	{"freeze", true},
	{"function", {"player", "moveRight", {false}}},
	{"function", {"player", "moveLeft", {false}}},
	{"function", {"player", "setSpeed", {0, 0}}},
	{"function", {"player", "setState", {"carry"}}},
	{"stopmusic"},
	{"playsound", "fanfareSound"},
	{"dialog", {nil, "You collected a heart container! Your maximum health is increased by one and health fully restored."}},
	{"function", {"player", "addMaxHealth", {}}},
	{"function", {"container", "fix", {}}},
	{"function", {"player", "setState", {"idle"}}},
	{"freeze", false},
	manual = true
}