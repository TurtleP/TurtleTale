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
  nextobjectid = 19,
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
        107, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 110,
        129, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 132,
        129, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 132,
        129, 42, 42, 42, 42, 42, 42, 197, 42, 42, 42, 42, 197, 42, 42, 42, 42, 42, 42, 132,
        129, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 132,
        129, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 132,
        129, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 132,
        129, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 132,
        129, 86, 86, 86, 86, 86, 63, 86, 86, 86, 86, 86, 86, 63, 86, 86, 86, 86, 86, 132,
        129, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 129, 152, 132,
        129, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 129, 152, 132,
        129, 86, 86, 86, 65, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 174, 174, 174, 132,
        129, 42, 42, 42, 87, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 174, 174, 42, 132,
        114, 115, 114, 115, 114, 115, 114, 5, 5, 5, 5, 5, 5, 111, 114, 115, 114, 115, 114, 115,
        136, 137, 136, 137, 136, 137, 136, 0, 0, 0, 0, 0, 0, 111, 136, 137, 136, 137, 136, 137
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 197, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 197, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 143, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 129, 152, 152, 152, 0,
        0, 0, 133, 0, 0, 0, 0, 0, 0, 177, 0, 0, 0, 0, 0, 129, 152, 152, 152, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 178, 0, 0, 0, 0,
        0, 0, 0, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 179, 0
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
          id = 2,
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
            ["link"] = "beach;464;144;"
          }
        },
        {
          id = 3,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 208,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["width"] = 96
          }
        },
        {
          id = 4,
          name = "shopkeeper",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["menu"] = true
          }
        },
        {
          id = 7,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 0,
          width = 288,
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
          x = 0,
          y = 0,
          width = 16,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 304,
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
          y = 208,
          width = 96,
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
          x = 208,
          y = 208,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 176,
          width = 64,
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
          x = 272,
          y = 144,
          width = 32,
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
          x = 112,
          y = 208,
          width = 96,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "barrier",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 160,
          width = 0,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
