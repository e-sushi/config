local wezterm = require("wezterm");

local config = wezterm.config_builder();

config.font = wezterm.font("Gohu GohuFont", {weight="Medium", stretch="Normal", style="Normal"});

return config;
