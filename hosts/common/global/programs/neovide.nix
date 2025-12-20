{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.neovide = {
    enable = true;
    settings = {
      fork = true;
      box-drawing.mode = "font-glyph";
    };
  };
}
