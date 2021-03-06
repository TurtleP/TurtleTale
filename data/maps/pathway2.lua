return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 45,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 38,
  properties = {
    ["song"] = "cliffs"
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
      width = 45,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        23, 24, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        23, 24, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23,
        23, 24, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23,
        23, 24, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 0, 0, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23,
        23, 24, 24, 24, 24, 24, 50, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 47, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26,
        26, 27, 27, 27, 27, 27, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 50, 27, 27, 27, 27, 27, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 27, 27, 27, 27, 27, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 3,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 17, 0, 0, 0, 0, 0, 1, 45, 24, 24, 24, 24, 24, 24, 25,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 39, 0, 62, 1, 2, 2, 45, 24, 24, 24, 24, 24, 24, 24, 25,
        0, 0, 0, 0, 36, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 60, 61, 0, 1, 45, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25,
        0, 0, 0, 0, 58, 59, 62, 0, 0, 0, 0, 57, 0, 0, 0, 0, 0, 0, 0, 0, 62, 0, 0, 0, 0, 0, 5, 6, 2, 2, 2, 2, 2, 2, 45, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25,
        0, 0, 57, 1, 2, 2, 3, 0, 0, 0, 1, 2, 2, 4, 5, 0, 0, 5, 6, 2, 2, 4, 5, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25,
        1, 2, 2, 45, 24, 24, 25, 0, 0, 0, 23, 24, 24, 25, 0, 0, 0, 0, 23, 24, 24, 25, 0, 0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25,
        23, 24, 24, 24, 24, 24, 25, 69, 69, 69, 23, 24, 24, 25, 69, 69, 69, 69, 23, 24, 24, 25, 69, 69, 69, 69, 69, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25
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
          id = 3,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 128,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["song"] = "cliffs"
          }
        },
        {
          id = 4,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 112,
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
          x = 48,
          y = 192,
          width = 64,
          height = 48,
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
          y = 208,
          width = 48,
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
          x = 160,
          y = 192,
          width = 64,
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
          x = 288,
          y = 192,
          width = 64,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 0,
          width = 112,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 176,
          width = 160,
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
          x = 512,
          y = 160,
          width = 64,
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
          x = 528,
          y = 144,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 192,
          width = 16,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
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
          id = 15,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 192,
          width = 16,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 176,
          width = 16,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 128,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 64,
          width = 96,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 592,
          y = 112,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 0,
          width = 16,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 208,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["fish"] = false,
            ["width"] = 48
          }
        },
        {
          id = 32,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 208,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["fish"] = false,
            ["width"] = 64
          }
        },
        {
          id = 33,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 208,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["fish"] = false,
            ["width"] = 80
          }
        },
        {
          id = 36,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 0,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "pathway;778;192;"
          }
        },
        {
          id = 37,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 80,
          width = 0,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "tobeach;16;96;"
          }
        }
      }
    }
  }
}
