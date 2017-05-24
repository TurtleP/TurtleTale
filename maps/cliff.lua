return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 25,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 11,
  properties = {
	["right"] = "home",
	["spawn"] = "384;208;"
  },
  tilesets = {
	{
	  name = "tiles",
	  firstgid = 1,
	  tilewidth = 16,
	  tileheight = 16,
	  spacing = 1,
	  margin = 0,
	  image = "../graphics/tiles.png",
	  imagewidth = 374,
	  imageheight = 255,
	  tileoffset = {
		x = 0,
		y = 0
	  },
	  properties = {},
	  terrains = {},
	  tilecount = 330,
	  tiles = {
		{
		  id = 22,
		  properties = {
			["right"] = "home"
		  }
		},
		{
		  id = 56,
		  properties = {
			["left"] = "cliff",
			["right"] = "beach"
		  }
		}
	  }
	}
  },
  layers = {
	{
	  type = "tilelayer",
	  name = "topTiles",
	  x = 0,
	  y = 0,
	  width = 25,
	  height = 15,
	  visible = true,
	  opacity = 1,
	  offsetx = 0,
	  offsety = 0,
	  properties = {},
	  encoding = "lua",
	  data = {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 104, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 126, 57, 0, 62, 126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 157, 157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 47, 2, 2, 3, 57, 0, 0, 62, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 47, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25, 157, 0, 62, 0, 57, 0, 0,
		0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 47, 2, 2, 2, 2, 2, 2, 2,
		69, 69, 69, 69, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24
	  }
	},
	{
	  type = "objectgroup",
	  name = "topObjects",
	  visible = true,
	  opacity = 1,
	  offsetx = 0,
	  offsety = 0,
	  draworder = "topdown",
	  properties = {},
	  objects = {
		{
		  id = 1,
		  name = "chest",
		  type = "",
		  shape = "rectangle",
		  x = 112,
		  y = 96,
		  width = 16,
		  height = 16,
		  rotation = 0,
		  visible = true,
		  properties = {
			["item"] = "scroll;punch;"
		  }
		},
		{
		  id = 2,
		  name = "trigger",
		  type = "",
		  shape = "rectangle",
		  x = 400,
		  y = 0,
		  width = 0,
		  height = 208,
		  rotation = 0,
		  visible = true,
		  properties = {
			["map"] = "home;16;192;"
		  }
		},
		{
		  id = 3,
		  name = "water",
		  type = "",
		  shape = "rectangle",
		  x = 0,
		  y = 208,
		  width = 64,
		  height = 16,
		  rotation = 0,
		  visible = true,
		  properties = {
			["width"] = 64
		  }
		},
		{
		  id = 4,
		  name = "tile",
		  type = "",
		  shape = "rectangle",
		  x = 64,
		  y = 112,
		  width = 112,
		  height = 128,
		  rotation = 0,
		  visible = true,
		  properties = {}
		},
		{
		  id = 5,
		  name = "tile",
		  type = "",
		  shape = "rectangle",
		  x = 176,
		  y = 160,
		  width = 48,
		  height = 80,
		  rotation = 0,
		  visible = true,
		  properties = {}
		},
		{
		  id = 6,
		  name = "tile",
		  type = "",
		  shape = "rectangle",
		  x = 224,
		  y = 176,
		  width = 64,
		  height = 64,
		  rotation = 0,
		  visible = true,
		  properties = {}
		},
		{
		  id = 7,
		  name = "tile",
		  type = "",
		  shape = "rectangle",
		  x = 288,
		  y = 208,
		  width = 112,
		  height = 32,
		  rotation = 0,
		  visible = true,
		  properties = {}
		},
		{
		  id = 8,
		  name = "tile",
		  type = "",
		  shape = "rectangle",
		  x = 176,
		  y = 128,
		  width = 16,
		  height = 32,
		  rotation = 0,
		  visible = true,
		  properties = {}
		},
		{
		  id = 9,
		  name = "tile",
		  type = "",
		  shape = "rectangle",
		  x = 192,
		  y = 144,
		  width = 16,
		  height = 16,
		  rotation = 0,
		  visible = true,
		  properties = {}
		},
		{
		  id = 10,
		  name = "tile",
		  type = "",
		  shape = "rectangle",
		  x = 288,
		  y = 192,
		  width = 16,
		  height = 16,
		  rotation = 0,
		  visible = true,
		  properties = {}
		}
	  }
	}
  }
}
