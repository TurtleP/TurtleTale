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
  nextobjectid = 6,
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
      properties = {},
      encoding = "lua",
      data = {
        107, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 108, 109, 110,
        41, 64, 146, 147, 148, 149, 150, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 146, 147, 148, 149, 150, 64, 64, 44,
        41, 86, 168, 169, 170, 171, 172, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 168, 169, 170, 171, 172, 86, 86, 44,
        41, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 44,
        41, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 44,
        41, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 44,
        41, 86, 86, 63, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 63, 86, 86, 44,
        41, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 44,
        41, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 44,
        41, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 44,
        41, 86, 86, 86, 86, 86, 86, 86, 63, 86, 86, 86, 86, 86, 86, 86, 63, 85, 86, 86, 86, 86, 86, 86, 44,
        41, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 65, 64, 64, 64, 64, 64, 64, 64, 114, 115, 114, 115, 114,
        41, 85, 85, 85, 85, 85, 86, 86, 86, 86, 86, 86, 87, 85, 86, 86, 86, 86, 86, 114, 137, 137, 137, 137, 136,
        115, 114, 115, 114, 115, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 136, 137, 137, 137, 137, 136,
        137, 137, 136, 137, 137, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 137, 136, 137
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
          x = 208,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "beach2",
            ["x"] = 208,
            ["y"] = 192
          }
        },
        {
          id = 2,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 208,
          width = 304,
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
          x = 320,
          y = 176,
          width = 80,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
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
          id = 5,
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
