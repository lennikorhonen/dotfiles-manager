{ config, pkgs, lib, ... }:
let
  nixGL = import ./nixGL.nix { inherit pkgs config; };
in
{
  programs.alacritty = {
    enable = true;
    package = (nixGL pkgs.alacritty);
    settings = {
      window.dimensions = {
        lines = 50;
        columns = 150;
      };
      window.opacity = 0.95;
      font = {
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };
        size = 12.0;
      };
    };
  };
}
