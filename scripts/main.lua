--[[

  This is the main script file loaded by the server, as configured in
  manaserv.xml. It defines how certain global events should be handled.

  Copyright (C) 2012 Erik Schilling
  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2013 Przemysław Grzywacz 

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

-- Project specific constants
require "scripts/global_constants"

-- Project specific global functions
require "scripts/damage"
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

-- Abilities
require "scripts/abilities"

-- Crafting
require "scripts/crafting"

-- Attributes
require "scripts/attributes"

