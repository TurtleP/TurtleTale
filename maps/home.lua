return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 25,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 8,
  properties = {
    ["background"] = "home_day",
    ["song"] = "cliffs"
  },
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
      tiles = {
        {
          id = 22,
          properties = {
            ["right"] = "home"
          }
        },
        {
          id = 56,
          properties = {
            ["left"] = "cliff",
            ["right"] = "beach"
          }
        }
      }
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 29, 30, 30, 31, 32, 32, 32, 56, 34, 0, 0, 0, 16, 17, 0, 0, 0,
        0, 0, 0, 36, 37, 0, 0, 0, 51, 96, 52, 53, 99, 54, 99, 78, 0, 0, 0, 0, 38, 39, 0, 0, 0,
        0, 57, 0, 58, 59, 62, 0, 0, 73, 118, 74, 75, 121, 76, 121, 78, 0, 0, 57, 0, 60, 61, 0, 62, 0,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24
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
          x = 208,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "indoors",
            ["x"] = 192,
            ["y"] = 208
          }
        },
        {
          id = 5,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 0,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cliff;378;192;"
          }
        },
        {
          id = 6,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 0,
          width = 0,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "pathway;16;192;"
          }
        },
        {
          id = 7,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 208,
          width = 400,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
