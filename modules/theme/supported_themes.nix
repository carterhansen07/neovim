{lib, ...}:
with lib;
with builtins; let
  themeSubmodule.options = {
    setup = mkOption {
      description = "Lua code to initialize theme";
      type = types.str;
    };
    styles = mkOption {
      description = "The available styles for the theme";
      type = with types; nullOr (listOf str);
      default = null;
    };
    defaultStyle = mkOption {
      description = "The default style for the theme";
      type = types.str;
    };
  };
in {
  options.vim.theme = {
    supportedThemes = mkOption {
      description = "Supported themes";
      type = with types; attrsOf (submodule themeSubmodule);
    };
  };

  config.vim.theme.supportedThemes = {
    tokyonight = {
      setup = ''
        -- tokyo theme
         require('tokyonight').setup({
           style = "storm",
           light_style = "day",
           transparent = false,
           terminal_colors = true,
           styles = {
             comments = { italic = true },
             keywords = { italic = true },
             functions = {},
             variables = {},
             sidebars = "dark",
             floats = "dark",
           },
           sidebars = { "qf", "help" },
           day_brightness = 0.3,
           hide_inactive_statusline = false,
           dim_inactive = false,
           lualine_bold = false,
           on_colors = function(colors)
             colors.bg = "#272727"
             colors.bg_dark = "#262626"
           end,
           on_highlights = function(highlights, colors) end,
         })
         vim.cmd[[colorscheme tokyonight]]
      '';
    };
  };
}
