--[[

  Script defining the behaviour of the skeleton boss on cave3

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

local attack_directions = {
    { x=-2 * TILESIZE, y= 0            },
    { x= 0,            y=-2 * TILESIZE },
    { x= 2 * TILESIZE, y= 0            },
    { x= 0,            y= 2 * TILESIZE }
}

-- Add same mob more often for higher probabillity
local mobs = {
    "Skeleton",
    "Skeleton",
    "Skeleton Soldier",
    "Skeleton Soldier",
    "Skeleton Mage"
}

local skeleton_king = get_monster_class("Skeleton King")
local spawned_mobs = {}

skeleton_king:on_damage(function(boss, target, hploss)
    local possible_directions = {}
    for _, p in ipairs(attack_directions) do
        local x, y = p.x + posX(target), p.y + posY(target)
        if is_walkable(x, y) then
            table.insert(possible_directions, p)
        end
    end

    for _, p in ipairs(possible_directions) do
        local mobname = mobs[math.random(#mobs)]
        local mob = monster_create(mobname, posX(target) + p.x, posY(target) + p.y)
        on_death(mob, function() spawned_mobs[mob] = nil end)
        spawned_mobs[mob] = 0
    end
end)

schedule_every(60, function()
    for mob, lifetime in pairs(spawned_mobs) do
        if #monster_get_angerlist(mob) == 0 then
            if lifetime == 1 then
                being_set_base_attribute(mob, 13, 0)
                spawned_mobs[mob] = nil
            else
                spawned_mobs[mob] = 1
            end
        end
    end
end)

local function spawn_king()
    local current_king = monster_create(skeleton_king, get_named_coordinate("boss_position"))
    on_death(current_king, function()
        -- Kill all mobs on the map
        -- TODO: do this when map size is fixed
        schedule_in(3600, spawn_king)
    end)
end

spawn_king()
