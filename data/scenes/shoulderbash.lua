return
{
	{"sleep", 0.5}, --hermit speaks first
	{"giveability", "punch"},
	{"playsound", "fanfareSound"},
	{"sleep", 1},
	{"dialog", {nil, "Woah! You obtained the Shoulder Bash ability! Press and hold 'Y' to attack your enemies.", true}},
	{"sleep", 0.25},
	
	manual = true
}