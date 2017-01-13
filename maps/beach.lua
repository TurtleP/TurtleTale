return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 21,
  properties = {
    ["left"] = "home"
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
      imageheight = 153,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 198,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "topTiles",
      x = 0,
      y = 0,
      width = 50,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 16, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 108, 108, 109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 108, 108, 109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 38, 39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 153, 131, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 153, 131, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        62, 60, 61, 62, 0, 0, 0, 0, 0, 57, 0, 0, 0, 0, 0, 41, 64, 152, 175, 131, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 64, 152, 175, 131, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        2, 2, 2, 2, 4, 5, 5, 5, 5, 6, 67, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 5, 5, 5, 5, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 0, 0, 0, 0, 114, 115, 114, 115,
        24, 24, 24, 24, 25, 0, 0, 0, 0, 23, 89, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 0, 0, 0, 0, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 69, 69, 69, 69, 136, 137, 136, 137
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
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 0,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "home;378;192;"
          }
        },
        {
          id = 5,
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 224,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["width"] = 64
          }
        },
        {
          id = 13,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 624,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 224,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["width"] = 64
          }
        },
        {
          id = 19,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 672,
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
          id = 20,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 0,
          width = 0,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "beach2;16;192;"
          }
        }
      }
    }
  }
}
