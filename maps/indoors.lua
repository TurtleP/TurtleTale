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
  nextobjectid = 31,
  properties = {},
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
      tiles = {}
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
      properties = {
        ["height"] = 15,
        ["width"] = 25
      },
      encoding = "lua",
      data = {
        32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 138, 74, 74, 74, 138, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 117, 74, 74, 74, 117, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 117, 74, 74, 74, 117, 74, 74, 74, 74, 74, 74, 74, 140, 142, 74,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 119, 117, 74, 74, 74, 117, 119, 74, 74, 74, 74, 74, 74, 161, 162, 74,
        94, 94, 94, 94, 74, 74, 74, 74, 74, 74, 116, 74, 74, 74, 116, 74, 74, 74, 74, 74, 74, 94, 94, 94, 94,
        95, 95, 95, 95, 94, 74, 74, 74, 94, 94, 94, 94, 94, 94, 94, 94, 94, 74, 74, 74, 94, 95, 95, 95, 95,
        138, 160, 160, 138, 74, 74, 74, 94, 95, 95, 95, 95, 95, 95, 95, 95, 95, 94, 74, 74, 74, 138, 160, 160, 138,
        117, 160, 160, 117, 74, 74, 94, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 94, 74, 74, 117, 160, 160, 117,
        116, 160, 160, 116, 74, 94, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 94, 74, 116, 160, 160, 116,
        94, 94, 94, 94, 74, 74, 74, 74, 74, 138, 74, 74, 74, 74, 74, 138, 74, 74, 74, 74, 74, 94, 94, 94, 94,
        95, 95, 95, 95, 94, 74, 74, 119, 74, 117, 74, 74, 74, 74, 74, 117, 74, 119, 74, 74, 94, 95, 95, 95, 95,
        95, 95, 95, 95, 95, 94, 74, 74, 74, 117, 74, 74, 98, 74, 74, 117, 74, 74, 74, 94, 95, 95, 95, 95, 95,
        95, 95, 95, 95, 95, 95, 94, 74, 74, 116, 74, 74, 120, 74, 74, 116, 74, 74, 94, 95, 95, 95, 95, 95, 95,
        95, 95, 95, 95, 95, 95, 95, 94, 94, 94, 94, 94, 94, 94, 94, 94, 94, 94, 95, 95, 95, 95, 95, 95, 95
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
          name = "door",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "home",
            ["x"] = 208,
            ["y"] = 192
          }
        },
        {
          id = 4,
          name = "bed",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "clock",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 96,
          width = 144,
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
          x = 112,
          y = 112,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 128,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 112,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 128,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 304,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 64,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 160,
          width = 64,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 80,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 176,
          width = 16,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 192,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 208,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 208,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 304,
          y = 192,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 176,
          width = 16,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 224,
          width = 176,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 400,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
