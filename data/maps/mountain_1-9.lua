return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 21,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 18,
  properties = {
    ["background"] = "cave",
    ["offset"] = 32
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
      width = 21,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 201, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 204, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 201, 203, 202, 203, 202, 203, 202, 203, 202, 203, 204, 268, 268, 268, 268, 268,
        268, 268, 268, 268, 268, 223, 0, 0, 0, 0, 0, 0, 0, 269, 0, 226, 268, 268, 268, 268, 268,
        268, 201, 202, 203, 202, 289, 0, 0, 0, 0, 0, 0, 0, 291, 0, 290, 203, 202, 204, 268, 268,
        268, 223, 0, 0, 288, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 290, 202, 204,
        310, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226,
        0, 287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 270, 0, 0, 226,
        0, 267, 0, 0, 0, 0, 227, 0, 0, 0, 228, 0, 0, 0, 227, 0, 0, 292, 0, 0, 226,
        309, 246, 311, 0, 0, 0, 249, 0, 0, 0, 250, 0, 0, 0, 249, 0, 0, 312, 246, 247, 268,
        268, 268, 223, 0, 0, 0, 249, 0, 0, 0, 249, 0, 0, 0, 249, 0, 0, 226, 268, 268, 268
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
          width = 48,
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
          x = 272,
          y = 208,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 0,
          width = 96,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 0,
          width = 144,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 96,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 144,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 199,
          width = 16,
          height = 41,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 192,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["length"] = 32,
            ["open"] = false
          }
        },
        {
          id = 13,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 199,
          width = 16,
          height = 41,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "chest",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "key",
            ["visible"] = false
          }
        },
        {
          id = 15,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 144,
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
          x = 320,
          y = 160,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 176,
          width = 0,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "mountain_1-8;624;192;"
          }
        }
      }
    }
  }
}
