local xresources = require("beautiful.xresources");
local dpi = xresources.apply_dpi;

local theme = {};

theme.font = "GohuFont 11 Nerd Font Mono 8";

theme.bg_normal   = "#000000";
theme.bg_focus    = "#1f1f1f";
theme.bg_urgent   = "#ff0000";
theme.bg_minimize = "#00ff00";
theme.bg_systray  = theme.bg_normal;

theme.fg_normal   = "#aaaaaa";
theme.fg_focus    = "#ffffff";
theme.fg_urgent   = "#ffffff";
theme.fg_minimize = "#ffffff";

theme.useless_gap   = dpi(0);
theme.border_width  = dpi(1);
theme.border_normal = "#000000";
theme.border_focus  = "#1f1f1f";
theme.border_marked = "#0000ff";

return theme;
