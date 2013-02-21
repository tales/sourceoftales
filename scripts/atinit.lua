--[[

  Provides override for the manaserv atinit function in order to load project
  specific initialization stuff.

  Copyright (C) 2012 Erik Schilling

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]


require "scripts/functions/npchelper"
require "scripts/functions/trap"
require "scripts/functions/triggerhelper"

local server_atinit = atinit

local function init_map()
    parse_npcs_from_map()
    parse_triggers_from_map()
    trap.parse_traps_from_map()
end

-- Override old atinit
function atinit(callback)
    server_atinit(function()
        init_map()
        callback()
    end)
end