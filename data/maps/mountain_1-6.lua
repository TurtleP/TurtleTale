return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 35,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 34,
  properties = {
    ["background"] = "cave",
    ["next"] = "mountain_1-8;0;80;",
    ["prev"] = "mountain_1-4;544;162;",
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
      width = 35,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 201, 203, 204, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 223, 0, 290, 203, 204, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 201, 202, 203, 202, 203, 202, 289, 0, 0, 0, 290, 203, 202, 203, 202, 203, 204, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 201, 202, 203, 202, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 290, 203, 202, 203, 202, 203,
        268, 268, 268, 268, 268, 268, 268, 201, 202, 289, 0, 0, 271, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 269, 0, 0,
        268, 268, 268, 268, 268, 201, 202, 289, 0, 0, 0, 0, 293, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 270, 0, 291, 0, 0,
        268, 268, 268, 201, 202, 289, 0, 288, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 292, 0, 0, 0, 0,
        202, 203, 202, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 312, 246, 247, 246, 247, 246, 247,
        0, 0, 269, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 329, 312, 248, 268, 268, 268, 268, 268, 268,
        0, 0, 291, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 312, 248, 268, 268, 268, 268, 268, 268, 268,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 267, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 226, 268, 268, 268, 268, 268, 268, 268, 268,
        0, 221, 0, 0, 0, 222, 0, 0, 0, 0, 312, 247, 246, 247, 246, 247, 311, 5, 10, 0, 0, 0, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268, 268, 268,
        247, 246, 247, 246, 247, 311, 0, 0, 0, 312, 248, 268, 268, 268, 268, 268, 223, 11, 0, 0, 0, 0, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 245, 247, 246, 247, 248, 268, 268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226, 268, 268, 268, 268, 268, 268, 268, 268
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
          x = 0,
          y = 208,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 192,
          width = 112,
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
          x = 144,
          y = 208,
          width = 16,
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
          x = 96,
          y = 224,
          width = 48,
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
          x = 416,
          y = 160,
          width = 144,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 128,
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
          x = 432,
          y = 144,
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
          x = 464,
          y = 0,
          width = 96,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 368,
          y = 0,
          width = 96,
          height = 64,
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
          y = 0,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 64,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 0,
          width = 256,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 0,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 64,
          width = 32,
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
          x = 96,
          y = 64,
          width = 32,
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
          x = 128,
          y = 64,
          width = 32,
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
          x = 160,
          y = 64,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 208,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["width"] = 48
          }
        },
        {
          id = 21,
          name = "spider",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "bat",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "bat",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 128,
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
          x = 272,
          y = 192,
          width = 16,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 192,
          width = 3,
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
          x = 285,
          y = 208,
          width = 3,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 368,
          y = 176,
          width = 48,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
