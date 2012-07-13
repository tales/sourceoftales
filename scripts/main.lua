--[[

  This is the main script file loaded by the server, as configured in
  manaserv.xml. It defines how certain global events should be handled.

--]]

-- At the moment the event handlers are split up over the following files:
require "scripts/global_events"
require "scripts/special_actions"
require "scripts/crafting"

-- Project specific constants
require "scripts/global_constants"

-- Project specific global functions
require "scripts/functions/tiletopixel"
require "scripts/functions/stringutils"

-- Monster scripts
require "scripts/monsters"
