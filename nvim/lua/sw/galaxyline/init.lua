local gl = require('galaxyline')
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default

local vimcolors = vim.g.colors.gui;

local colors = {
  bg = vimcolors.gray4,
  lg = vimcolors.gray3,
  yellow = vimcolors.yellow,
  dark_yellow = vimcolors.yellow,
  cyan = vimcolors.cyan,
  green = vimcolors.green,
  light_green = vimcolors.green,
  orange = vimcolors.orange,
  string_orange = vimcolors.orange,
  purple = vimcolors.purple,
  magenta = vimcolors.purple,
  light_blue = vimcolors.blue,
  blue = vimcolors.blue,
  vivid_blue = vimcolors.blue,
  red = vimcolors.red,
  error_red = vimcolors.red,
  info_yellow = vimcolors.yellow,
}

local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

local cache = {}
local function project()
  local curtime = os.time()
  if cache.mtime and curtime - cache.mtime < 10 then return cache end

  cache.date = os.date('%m/%d')
  cache.time = os.date('%I/%M')

  local handle = io.popen("php ~/.config/fish/functions/parse_watson_status.php")
  local result = handle:read("*a")
  handle:close()

  if string.find(result,"No project") then
    cache.project = "N/A"
  else
    cache.project = result
  end
  cache.mtime = os.time()
  return cache
end

local function get_file_info()
  return vim.fn.expand('%:t'), vim.fn.expand('%:e')
end

condition.has_icon = function()
  local ok,devicons = pcall(require,'nvim-web-devicons')
  if not ok then print('No icon plugin found. Please install \'kyazdani42/nvim-web-devicons\'') return '' end
  local f_name,f_extension = get_file_info()
  icon = devicons.get_icon(f_name,f_extension)
  return icon ~= nil
end

table.insert(gls.left, {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.purple,
                [''] = colors.purple,
                V = colors.purple,
                c = colors.magenta,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.blue,
                t = colors.blue
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
            return '▊ '
        end,
        highlight = {colors.red, colors.bg}
    }
})

table.insert(gls.left, {
    FrontSpace = {
        provider = function()
            return ' '
        end,
        separator_highlight = {colors.orange, colors.bg},
        highlight = {colors.orange, colors.bg}
    }
})

table.insert(gls.left, {
    FileName = {
      provider = 'FileName',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      condition = condition.buffer_not_empty,
      highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.left, {
    GitIcon = {
        provider = function()
            return ''
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
})

table.insert(gls.left, {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.left, {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green, colors.bg}
    }
})
table.insert(gls.left, {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = {colors.blue, colors.bg}
    }
})
table.insert(gls.left, {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
})

table.insert(gls.right, {
    DiagnosticError = {provider = 'DiagnosticError', icon = '  ', highlight = {colors.error_red, colors.bg}}
})
table.insert(gls.right, {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '   ', highlight = {colors.orange, colors.bg}}})

table.insert(gls.right, {
    DiagnosticHint = {provider = 'DiagnosticHint', icon = '   ', highlight = {colors.vivid_blue, colors.bg}}
})

table.insert(gls.right, {DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '   ', highlight = {colors.info_yellow, colors.bg}}})

table.insert(gls.right, {
    TreesitterIcon = {
        provider = function()
            if next(vim.treesitter.highlighter.active) ~= nil then return ' ' end
            return ''
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.green, colors.bg}
    }
})

-- table.insert(gls.right, {
--     Tabstop = {
--         provider = function()
--             return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
--         end,
--         condition = condition.hide_in_width,
--         separator = ' ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- })

table.insert(gls.right, {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.has_icon,
    separator = ' ',
    separator_highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg},
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
  }
})

table.insert(gls.right, {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.right, {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.right, {
    Space = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
})

table.insert(gls.right, {
    ScrollBar = {
        provider = 'ScrollBar',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.lg, colors.bg}
    }
})

table.insert(gls.right, {
    CurProject = {
        provider = function()
          return "  " .. project().project
        end,
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.green, colors.bg}
    }
})

table.insert(gls.right, {
    CurDate = {
        provider = function()
          return '  ' .. project().date
        end,
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.blue, colors.bg}
    }
})

table.insert(gls.right, {
    CurTime = {
        provider = function()
          return '  ' .. project().time
        end,
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.purple, colors.bg}
    }
})

table.insert(gls.right, {
    ViModeEnd = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.purple,
                [''] = colors.purple,
                V = colors.purple,
                c = colors.magenta,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.blue,
                t = colors.blue
            }
            vim.api.nvim_command('hi GalaxyViModeEnd guifg=' .. mode_color[vim.fn.mode()])
            return '  ▊'
        end,
        highlight = {colors.red, colors.bg},
    }
})

table.insert(gls.short_line_left, {
    Space = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
})

table.insert(gls.short_line_left, {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.has_icon,
    separator = '',
    separator_highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg},
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
  }
})

table.insert(gls.short_line_left, {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.buffer_not_empty,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.short_line_left, {
    SFileName = {provider = 'SFileName', condition = condition.buffer_not_empty, highlight = {colors.grey, colors.bg}}
})

--table.insert(gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.bg}}})
