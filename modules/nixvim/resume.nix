{ lib, ... }:
{
  extraFiles."lua/rex-resume.lua".source = ./resume.lua;
  extraConfigLuaPre = lib.mkBefore ''require("rex-resume")'';
}
