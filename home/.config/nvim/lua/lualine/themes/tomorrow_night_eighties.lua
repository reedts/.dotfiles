local colors = require('lualine.themes.colors').colors
return {
  inactive = {
    a = { fg = colors.color0, bg = colors.color1, gui = 'bold' },
    b = { fg = colors.color2, bg = colors.color3 },
    c = { fg = colors.color0, bg = colors.line },
  },
  normal = {
    a = { fg = colors.green,  bg = colors.gray, gui = 'bold' },
    b = { fg = colors.white,  bg = colors.midgray},
    c = { fg = colors.white,  bg = colors.line},
    x = { fg = colors.white,  bg = colors.line},
    y = { fg = colors.white,  bg = colors.line},
    z = { fg = colors.green,  bg = colors.gray, gui = 'bold' },
  },
  visual = {
    a = { fg = colors.blue,   bg = colors.gray, gui = 'bold' },
    c = { fg = colors.white,  bg = colors.line},
    x = { fg = colors.white,  bg = colors.line},
    y = { fg = colors.white,  bg = colors.line},
  },
  replace = {
    a = { fg = colors.orange, bg = colors.gray, gui = 'bold' },
    c = { fg = colors.white,  bg = colors.line},
    x = { fg = colors.white,  bg = colors.line},
    y = { fg = colors.white,  bg = colors.line},
  },
  insert = {
    a = { fg = colors.cyan,   bg = colors.gray, gui = 'bold' },
    c = { fg = colors.white,  bg = colors.line},
    x = { fg = colors.white,  bg = colors.line},
    y = { fg = colors.white,  bg = colors.line},
  },
}

