define.module "cardinal.maps"
define "cardinal.maps.introTest": type "instance":
  extends "bishop.map.tiled": as({ "assets/intro.lua" })

require "cardinal.maps.intro"
