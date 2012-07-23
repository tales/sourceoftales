--[[

  This is the main script file loaded by the server, as configured in
  manaserv.xml. It defines how certain global events should be handled.

--]]

-- Project specific constants
require "scripts/global_constants"

-- Project specific global functions
require "scripts/functions/coordinatehelper"
require "scripts/functions/reputation"
require "scripts/functions/stringutils"
require "scripts/functions/tiletopixel"

-- Monster scripts
require "scripts/monsters"

-- Item scripts
require "scripts/items"

-- Global Events
require "scripts/global_events"

-- Specials
require "scripts/specials"

-- Crafting
require "scripts/crafting"

