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
  nextobjectid = 15,
  properties = {
    ["offset"] = 40
  },
  tilesets = {
    {
      name = "base",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      image = "../../../../Homebrew/3DS/TurtleTale/romfs/graphics/tiles.png",
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
      name = "Tile Layer 1",
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
        107, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 110,
        129, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 132,
        129, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 132,
        129, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 132,
        129, 160, 160, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 132,
        129, 160, 160, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 132,
        129, 114, 115, 114, 115, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 132,
        129, 136, 137, 136, 137, 114, 115, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 132,
        129, 158, 158, 158, 158, 136, 137, 115, 114, 115, 114, 115, 114, 115, 86, 86, 86, 86, 86, 132,
        129, 158, 158, 158, 158, 158, 158, 136, 137, 136, 137, 136, 137, 136, 115, 64, 64, 64, 64, 132,
        129, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 114, 115, 114,
        129, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 114, 115, 137, 137,
        129, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 114, 115, 137, 137, 137,
        114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 137, 137, 137, 137, 137,
        136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 137, 137
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
          x = 256,
          y = 176,
          width = 16,
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
          x = 16,
          y = 96,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
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
          x = 272,
          y = 160,
          width = 48,
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
          x = 240,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 128,
          width = 112,
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
          x = 80,
          y = 112,
          width = 32,
          height = 48,
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
          y = 16,
          width = 16,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
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
          id = 12,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["speak"] = "Hey! Wassup fam? Make yourself at home."
          }
        },
        {
          id = 13,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "tobeach;592;160"
          }
        },
        {
          id = 14,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["breakable"] = true,
            ["id"] = 71
          }
        }
      }
    },
    {
      type = "tilelayer",
      name = "Tile Layer 2",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 93, 0, 0, 199, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 156, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 177, 253, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 178, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
