return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 23,
  properties = {
    ["background"] = "cave",
    ["bgcolor"] = "0;0;0",
    ["offset"] = 40,
    ["song"] = "shop"
  },
  tilesets = {
    {
      name = "base",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      image = "../../graphics/game/tiles.png",
      imagewidth = 374,
      imageheight = 255,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
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
      width = 20,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        201, 203, 202, 203, 202, 204, 201, 203, 202, 203, 202, 203, 202, 204, 268, 268, 268, 268, 268, 268,
        223, 0, 269, 0, 0, 226, 223, 0, 0, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268,
        223, 0, 291, 0, 0, 226, 223, 0, 0, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268,
        223, 0, 0, 0, 0, 290, 289, 0, 0, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268,
        223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268,
        223, 0, 0, 0, 0, 0, 0, 267, 0, 246, 247, 246, 247, 248, 268, 268, 268, 268, 268, 268,
        223, 0, 0, 0, 0, 246, 247, 246, 247, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        223, 0, 0, 0, 246, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        223, 0, 0, 246, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 0, 0, 0, 287, 0, 226,
        268, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 143, 0, 226,
        268, 245, 311, 0, 0, 0, 0, 187, 0, 0, 0, 270, 0, 0, 0, 0, 0, 312, 246, 248,
        268, 268, 245, 311, 0, 222, 0, 209, 0, 0, 0, 292, 0, 0, 0, 267, 0, 226, 268, 268,
        268, 268, 268, 245, 246, 246, 247, 246, 247, 246, 246, 247, 246, 247, 246, 246, 247, 248, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268
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
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["freeze"] = true,
            ["scale"] = -1
          }
        },
        {
          id = 3,
          name = "bed",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["scale"] = -1
          }
        },
        {
          id = 4,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 208,
          width = 208,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 176,
          width = 48,
          height = 64,
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
          y = 0,
          width = 80,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 0,
          width = 16,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 304,
          y = 0,
          width = 16,
          height = 176,
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
          y = 0,
          width = 16,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 160,
          width = 16,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 176,
          width = 16,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 192,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 0,
          width = 192,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 32,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 96,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 112,
          width = 64,
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
          x = 48,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 128,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "mountain_1-1;640;160;"
          }
        },
        {
          id = 21,
          name = "userectangle",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["func"] = "data.scripts.heal"
          }
        },
        {
          id = 22,
          name = "barrier",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 144,
          width = 0,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
