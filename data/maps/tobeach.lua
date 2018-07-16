return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 61,
  properties = {
    ["next"] = "beach;16;144;",
    ["prev"] = "pathway2;704;96;",
    ["song"] = "beach"
  },
  tilesets = {
    {
      name = "tiles",
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
      width = 50,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 16, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 38, 39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 62, 60, 61, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        24, 24, 24, 47, 2, 3, 0, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 109, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        24, 24, 24, 24, 24, 47, 2, 2, 3, 0, 0, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        24, 24, 24, 24, 24, 24, 24, 24, 25, 62, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 108, 109, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 152, 132, 0, 0, 0, 0, 0, 114, 115, 114, 115,
        24, 24, 24, 24, 24, 24, 24, 24, 47, 2, 45, 47, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 153, 132, 0, 0, 0, 0, 0, 0, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 136, 137, 136, 137,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 47, 3, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 175, 132, 0, 0, 0, 114, 115, 114, 137, 136, 137, 136, 137, 136, 137, 136, 136, 137, 137, 136, 137, 136, 137, 136, 137,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 5, 5, 5, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 115, 114, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 0, 0, 0, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137
      }
    },
    {
      type = "tilelayer",
      name = "foreground",
      x = 0,
      y = 0,
      width = 50,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 66, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 155, 64, 88, 64, 0, 0, 0, 0, 177, 0, 0, 0, 0, 0, 0,
        23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 156, 0, 0, 0, 0, 0, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 179, 0, 0, 0, 0, 0, 0, 0,
        23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 179, 0, 0, 0, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 199, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          id = 27,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 112,
          width = 64,
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
          x = 160,
          y = 160,
          width = 32,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 192,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 176,
          width = 16,
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
          x = 96,
          y = 144,
          width = 48,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 128,
          width = 32,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 208,
          width = 48,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 208,
          width = 208,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["speak"] = "Yo this inn is the best! If you're tired, you might wanna rest. Don't wanna lose your progress right?"
          }
        },
        {
          id = 46,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["speak"] = "Phoenix? Er.. I know nothing of one. Maybe the owner of the Hermit Shack'll know."
          }
        },
        {
          id = 48,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 208,
          width = 48,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["width"] = 48
          }
        },
        {
          id = 50,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 208,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 192,
          width = 256,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 528,
          y = 176,
          width = 208,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 160,
          width = 64,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "sign",
          type = "",
          shape = "rectangle",
          x = 368,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "Sherman's Inn--Shore to please! Fluffy pillows and warm blankets available all day."
          }
        },
        {
          id = 59,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "inn_beach;112;192;"
          }
        },
        {
          id = 60,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 592,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "beach_home-1;64;192"
          }
        }
      }
    }
  }
}
