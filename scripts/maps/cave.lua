--[[

  Script file of cave2.
  This map will contain various traps / scripted spawns

  Copyright (C) 2012 Erik Schilling
  Copyright (C) 2012 Jessica Tölke

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

local alcoves_monster_number = 0

local function alcoves_onRemove()
    alcoves_monster_number = alcoves_monster_number - 1
end

local function alcoves_spawn(being)
    if being:type() == TYPE_CHARACTER and alcoves_monster_number == 0 then
        local mobs = {}
        alcoves_monster_number = 6
        table.insert(mobs, monster_create("Skeleton",
                     get_named_coordinate("Skeleton Spawn")))
        table.insert(mobs, monster_create("Skeleton",
                     get_named_coordinate("Skeleton2 Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier2 Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier3 Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier4 Spawn")))

        for _, mob in ipairs(mobs) do
            on_remove(mob, alcoves_onRemove)
        end
    end
end

local function shrinequest_spawn(being, id)
    if being:type() ~= TYPE_CHARACTER then
        return
    end

    local quest = chr_try_get_quest(being, "goldenfields_shrine")
    if quest == "started" then
        if id == 1 then
            monster_create("Skeleton", get_named_coordinate("Shrinequest Skeleton Spawn West"))
        elseif id == 2 then
            monster_create("Skeleton", get_named_coordinate("Shrinequest Skeleton Spawn East"))
        end
        being:say("A skeleton! I should return and tell Priestess Linota about this!")
        chr_set_quest(being, "goldenfields_shrine", "skeletonspotted")
    end
end

atinit(function()
    require "scripts/functions/triggerhelper"
    require "scripts/functions/trap"
    parse_triggers_from_map()
    trap.parse_traps_from_map()

    create_trigger_by_name("alcoves spawn", alcoves_spawn)
    create_trigger_by_name("shrinequest spawn west", shrinequest_spawn)
    create_trigger_by_name("shrinequest spawn east", shrinequest_spawn)
end)
