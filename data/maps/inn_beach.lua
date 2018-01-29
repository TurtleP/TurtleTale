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
  nextobjectid = 45,
  properties = {
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
    },
    {
      name = "base",
      firstgid = 331,
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
        437, 438, 439, 438, 439, 438, 439, 438, 439, 438, 439, 438, 439, 438, 439, 438, 439, 438, 439, 440,
        459, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 462,
        459, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 462,
        459, 372, 372, 372, 372, 372, 372, 42, 372, 372, 372, 372, 42, 372, 372, 372, 42, 372, 372, 462,
        459, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 462,
        459, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 462,
        459, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 462,
        459, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 462,
        459, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 416, 462,
        459, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 372, 41, 44, 372, 372, 462,
        459, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 394, 41, 44, 394, 482, 462,
        459, 416, 416, 416, 416, 416, 416, 395, 416, 416, 416, 416, 416, 416, 416, 41, 504, 504, 504, 462,
        459, 372, 372, 372, 372, 372, 372, 417, 372, 372, 372, 372, 372, 372, 372, 41, 504, 504, 482, 462,
        444, 444, 445, 445, 444, 445, 444, 445, 444, 445, 444, 445, 444, 445, 111, 114, 115, 114, 115, 114,
        466, 467, 466, 467, 466, 467, 466, 136, 137, 136, 137, 136, 137, 467, 111, 467, 466, 467, 466, 467
      }
    },
    {
      type = "tilelayer",
      name = "foreground",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 129, 132, 0, 0, 0, 0, 0, 129, 152, 152, 152, 152, 152, 152, 0,
        0, 0, 0, 0, 0, 129, 132, 0, 0, 0, 0, 0, 129, 174, 174, 174, 174, 174, 174, 0,
        0, 0, 0, 0, 0, 129, 132, 0, 0, 196, 0, 0, 129, 130, 130, 130, 130, 130, 130, 0,
        0, 0, 0, 0, 0, 129, 132, 0, 0, 0, 0, 0, 129, 152, 152, 152, 152, 152, 152, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 129, 174, 174, 174, 174, 174, 174, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 114, 115, 130, 130, 130, 130, 130, 130, 0,
        0, 0, 196, 0, 0, 115, 114, 115, 114, 136, 137, 136, 137, 152, 152, 152, 152, 152, 152, 0,
        0, 0, 0, 0, 115, 136, 136, 137, 136, 136, 136, 136, 137, 174, 174, 174, 174, 174, 174, 0,
        0, 0, 0, 115, 136, 158, 158, 158, 158, 158, 158, 158, 158, 0, 0, 0, 0, 0, 0, 0,
        0, 114, 0, 41, 44, 0, 0, 0, 0, 0, 41, 44, 0, 0, 0, 0, 143, 0, 0, 0,
        0, 136, 114, 41, 44, 0, 0, 0, 0, 196, 41, 44, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 158, 136, 114, 44, 0, 0, 0, 0, 0, 41, 44, 0, 0, 0, 0, 0, 0, 0, 0,
        444, 445, 444, 445, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 136, 137, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 272,
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
          id = 4,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 208,
          width = 320,
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
          x = 0,
          y = 16,
          width = 16,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 304,
          y = 16,
          width = 16,
          height = 192,
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
          width = 320,
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
          y = 192,
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
          x = 256,
          y = 176,
          width = 48,
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
          x = 288,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
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
            ["link"] = "tobeach;400;192;"
          }
        },
        {
          id = 31,
          name = "bed",
          type = "",
          shape = "rectangle",
          x = 160,
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
          id = 32,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 16,
          width = 96,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 96,
          width = 48,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 112,
          width = 48,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
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
          id = 36,
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
          id = 37,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 192,
          width = 16,
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
          x = 32,
          y = 176,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 160,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 16,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 16,
          width = 16,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 112,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "userectangle",
          type = "",
          shape = "rectangle",
          x = 224,
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
          id = 44,
          name = "barrier",
          type = "",
          shape = "rectangle",
          x = 256,
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
