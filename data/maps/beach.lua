return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 29,
  properties = {
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
    },
    {
      name = "base",
      firstgid = 331,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 108, 109, 110, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 153, 132, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 175, 132, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 108, 109, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 114, 115, 114, 115, 68, 2, 2,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 153, 132, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 136, 137, 136, 137, 136, 137, 90, 24, 24,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 109, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 130, 175, 132, 0, 0, 0, 0, 0, 0, 114, 115, 136, 137, 136, 137, 136, 137, 136, 137, 90, 24, 24,
        114, 115, 114, 115, 0, 0, 0, 0, 0, 0, 0, 42, 66, 42, 130, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 114, 115, 114, 115, 114, 0, 0, 0, 114, 115, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 90, 24, 24,
        466, 467, 466, 467, 114, 115, 114, 115, 0, 0, 0, 64, 88, 64, 152, 132, 0, 444, 0, 0, 0, 0, 0, 0, 445, 136, 137, 136, 137, 136, 137, 136, 115, 114, 115, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 90, 24, 24,
        466, 467, 466, 467, 466, 467, 466, 137, 114, 115, 115, 114, 114, 115, 114, 115, 114, 466, 0, 0, 0, 0, 0, 0, 467, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 90, 24, 24,
        466, 467, 466, 467, 466, 467, 466, 467, 466, 136, 136, 136, 137, 467, 466, 467, 466, 467, 0, 0, 0, 0, 0, 0, 466, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 90, 24, 24,
        466, 467, 466, 467, 466, 467, 466, 467, 466, 467, 466, 467, 466, 467, 466, 467, 466, 467, 0, 0, 0, 0, 0, 0, 466, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 136, 137, 90, 24, 24
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
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "palm",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 80,
          width = 16,
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
          x = 656,
          y = 112,
          width = 144,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 624,
          y = 128,
          width = 32,
          height = 112,
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
          y = 160,
          width = 64,
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
          x = 64,
          y = 176,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 592,
          y = 144,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 160,
          width = 32,
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
          x = 400,
          y = 160,
          width = 112,
          height = 80,
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
          y = 176,
          width = 48,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 176,
          width = 16,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 192,
          width = 144,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "water",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 192,
          width = 96,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["width"] = 96
          }
        },
        {
          id = 15,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 176,
          width = 16,
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
          x = 288,
          y = 176,
          width = 96,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["speak"] = "Another fine day. Huh? A Phoenix? Never heard of one. What are they?"
          }
        },
        {
          id = 19,
          name = "hermit",
          type = "",
          shape = "rectangle",
          x = 688,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["speak"] = "I have the high ground, boys. Richest crab on the beach!"
          }
        },
        {
          id = 20,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 0,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "tobeach;784;144;"
          }
        },
        {
          id = 23,
          name = "trigger",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 0,
          width = 0,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "mountain;16;112;",
            ["song"] = "beach"
          }
        },
        {
          id = 25,
          name = "sign",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "Hermit Shack--The One-Stop Adventure Store!"
          }
        },
        {
          id = 26,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "shop_beach;64;192;"
          }
        },
        {
          id = 27,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "beach_home-3;288;144;"
          }
        },
        {
          id = 28,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["link"] = "beach_home-2;80;192"
          }
        }
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 133, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 179, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 178, 0, 0, 0, 0,
        0, 0, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 199, 0, 0, 0, 0, 0, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 178, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 199, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 178, 0, 0, 0, 0, 0, 69, 69, 69, 69, 69, 69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 69, 69, 69, 69, 69, 69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
