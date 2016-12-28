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
  nextobjectid = 4,
  properties = {
    ["right"] = "home",
    ["spawn"] = "384;208;"
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
      imageheight = 153,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 198,
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
        0, 0, 0, 0, 0, 104, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 126, 57, 0, 62, 126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 25, 157, 157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 47, 2, 2, 3, 57, 0, 0, 62, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 47, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25, 157, 0, 62, 0, 57, 0, 0,
        0, 0, 0, 0, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 47, 2, 2, 2, 2, 2, 2, 2,
        26, 26, 26, 26, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24
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
          x = 112,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "scroll;punch;"
          }
        },
        {
          id = 2,
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
            ["map"] = "home;16;192;"
          }
        },
        {
          id = 3,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 208,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["width"] = 64
          }
        }
      }
    }
  }
}
