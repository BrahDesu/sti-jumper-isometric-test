return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "isometric",
  renderorder = "right-down",
  width = 9,
  height = 9,
  tilewidth = 128,
  tileheight = 64,
  nextlayerid = 2,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tileset",
      firstgid = 1,
      tilewidth = 128,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "tileset.png",
      imagewidth = 1024,
      imageheight = 768,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 64
      },
      properties = {},
      wangsets = {},
      tilecount = 96,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 9,
      height = 9,
      id = 1,
      name = "map",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        5, 2, 5, 21, 3, 4, 2, 1, 8,
        12, 12, 12, 12, 12, 12, 12, 20, 3,
        10, 10, 10, 10, 10, 10, 13, 11, 2,
        6, 3, 2, 1, 8, 7, 9, 11, 5,
        1, 5, 3, 5, 21, 18, 15, 11, 7,
        4, 3, 24, 6, 3, 9, 16, 17, 1,
        1, 7, 1, 4, 22, 9, 11, 8, 5,
        1, 1, 3, 3, 3, 9, 11, 2, 21,
        21, 1, 5, 3, 8, 9, 11, 23, 1
      }
    }
  }
}
