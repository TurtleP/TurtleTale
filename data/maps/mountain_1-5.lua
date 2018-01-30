return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 45,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 47,
  properties = {
    ["background"] = "cave",
    ["next"] = "mountain_1-3;0;194;",
    ["prev"] = "mountain_1-7;384;194;",
    ["song"] = "cave"
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
      width = 45,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 201, 289, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 201, 289, 0, 0, 0, 0, 0, 290, 204, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 201, 203, 202, 203, 204, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 201, 202, 289, 0, 0, 0, 0, 0, 0, 0, 290, 203, 204, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 223, 0, 271, 0, 290, 203, 204, 268, 268, 268, 268, 268, 268, 268, 268,
        202, 203, 202, 203, 202, 203, 202, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 290, 203, 204, 268, 268, 268, 268, 268, 268, 201, 202, 289, 0, 293, 0, 0, 0, 290, 203, 204, 268, 201, 202, 203, 202, 203,
        0, 288, 0, 0, 0, 287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 290, 203, 202, 203, 202, 203, 202, 203, 0, 0, 0, 0, 0, 0, 0, 0, 0, 290, 202, 289, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 269, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 291, 0, 0, 0, 0, 0,
        0, 267, 0, 221, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 270, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        246, 247, 246, 247, 246, 311, 0, 0, 0, 0, 312, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 221, 0, 0, 0, 0, 0, 292, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 226, 245, 246, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 312, 246, 247, 246, 247, 246, 247, 246, 247, 247, 0, 0, 0, 0, 0, 0, 0, 0,
        268, 224, 224, 224, 224, 224, 0, 0, 0, 0, 226, 268, 268, 245, 246, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 312, 248, 224, 224, 224, 224, 224, 224, 224, 268, 245, 311, 0, 0, 0, 0, 0, 0, 0,
        268, 224, 224, 224, 224, 224, 0, 0, 0, 0, 226, 268, 268, 268, 268, 245, 246, 311, 0, 0, 0, 228, 0, 0, 0, 0, 224, 224, 224, 224, 224, 224, 224, 224, 224, 268, 268, 245, 311, 0, 0, 0, 0, 0, 0,
        268, 224, 224, 224, 224, 224, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268, 223, 0, 267, 227, 250, 228, 0, 0, 0, 224, 224, 224, 224, 224, 224, 224, 224, 224, 268, 268, 268, 245, 311, 0, 0, 0, 0, 0,
        268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268, 268, 247, 246, 247, 246, 247, 246, 247, 311, 224, 224, 224, 224, 224, 224, 312, 246, 247, 268, 268, 268, 268, 246, 247, 246, 247, 246, 247,
        268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 245, 246, 247, 224, 224, 224, 224, 226, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268
      }
    },
    {
      type = "tilelayer",
      name = "foreground",
      x = 0,
      y = 0,
      width = 45,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        201, 202, 203, 202, 203, 289, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        223, 0, 0, 0, 0, 290, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        223, 0, 196, 187, 196, 0, 0, 0, 0, 312, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        223, 0, 0, 209, 0, 0, 0, 0, 0, 290, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        245, 246, 247, 246, 247, 311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 528,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "coins;10;"
          }
        },
        {
          id = 2,
          name = "crate",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 176,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 192,
          width = 16,
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
          x = 320,
          y = 199,
          width = 16,
          height = 9,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["evil"] = true
          }
        },
        {
          id = 7,
          name = "bat",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 80,
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
          x = 272,
          y = 32,
          width = 224,
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
          x = 304,
          y = 48,
          width = 192,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 64,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 0,
          width = 464,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 32,
          width = 176,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 48,
          width = 144,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 64,
          width = 48,
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
          x = 512,
          y = 208,
          width = 208,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 144,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 592,
          y = 160,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 176,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 624,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 144,
          width = 112,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 224,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 208,
          width = 240,
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
          x = 400,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 160,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "crate",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 128,
          width = 32,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 144,
          width = 32,
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
          x = 224,
          y = 160,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 176,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 192,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 192,
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
          x = 0,
          y = 16,
          width = 176,
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
          x = 0,
          y = 32,
          width = 160,
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
          x = 0,
          y = 48,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 128,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 128,
          width = 80,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 208,
          width = 80,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 144,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 176,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 208,
          width = 16,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "inn_mountain-2;112;192;"
          }
        }
      }
    }
  }
}
