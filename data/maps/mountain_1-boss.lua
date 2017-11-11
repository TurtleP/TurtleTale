return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 41,
  properties = {
    ["background"] = "cave",
    ["bgcolor"] = "55;80;102"
  },
  tilesets = {
    {
      name = "base",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      image = "../../graphics/tiles.png",
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
      width = 32,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 223, 224, 224, 224, 226, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 201, 203, 202, 203, 202, 203, 202, 204, 268, 268, 223, 224, 224, 224, 226, 268, 268, 201, 202, 203, 202, 203, 202, 203, 204,
        268, 268, 268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 269, 0, 0, 226,
        268, 268, 268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 291, 0, 0, 226,
        268, 268, 268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226,
        268, 268, 268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226,
        201, 202, 202, 202, 202, 202, 202, 223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226,
        223, 224, 224, 224, 224, 224, 290, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226,
        223, 224, 224, 224, 224, 224, 224, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226,
        223, 224, 224, 224, 224, 224, 224, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 246, 0, 0, 0, 247, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226,
        245, 246, 246, 246, 246, 246, 246, 311, 0, 0, 0, 0, 0, 312, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 312, 311, 0, 0, 0, 270, 0, 226,
        268, 268, 268, 268, 268, 268, 268, 223, 0, 221, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 292, 0, 226,
        268, 268, 268, 268, 268, 268, 268, 245, 246, 247, 311, 0, 0, 0, 0, 270, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 312, 246, 247, 248,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 292, 0, 0, 0, 0, 0, 0, 0, 0, 267, 0, 0, 0, 226, 268, 268, 223,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 245, 247, 246, 247, 246, 247, 246, 247, 246, 247, 246, 247, 246, 247, 246, 247, 246, 247, 248, 268, 268, 245
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
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 192,
          width = 64,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 192,
          width = 64,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 224,
          width = 272,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 0,
          width = 176,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 32,
          width = 16,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 496,
          y = 32,
          width = 16,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 0,
          width = 176,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "bossdoor",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 160,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["length"] = 32
          }
        },
        {
          id = 26,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 112,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 112,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 112,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 160,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 160,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 208,
            ["invisible"] = true
          }
        },
        {
          id = 39,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 186,
            ["invisible"] = true
          }
        },
        {
          id = 40,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["active"] = false,
            ["link"] = "mountain_1-10;0;128"
          }
        }
      }
    }
  }
}
