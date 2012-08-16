--[[

  Script defining the behaviour of the soldier:
  If the soldier is attacked it will call the other soldiers around to help him
  to defend against the aggressor

  Copyright (C) 2012 jurkan
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

require "scripts/monsters/group_monster"

-- local function drop_letter(mob, aggressor)
--     local quest = chr_try_get_quest(aggressor, "rebelphilip_mole")
--     if quest == "step2"
--         item_drop(posX(mob), posY(mob), "Councellor Letter")
--     end
-- end

local function damaged(mob, aggressor, hploss)
    group_monster.damage_recieved(mob, aggressor, hploss)

    if being_get_base_attribute(mob, ATTR_HP) > 0 then return end

    local reputation_soldier = tonumber(chr_try_get_quest(aggressor, "soldier_reputation"))
    local reputation_rebel = tonumber(chr_try_get_quest(aggressor, "rebel_reputation"))
    if not reputation_soldier or not reputation_rebel then return end

    change_reputation(ch, "soldier_reputation", "Army", -4)
    change_reputation(ch, "rebel_reputation", "Rebels", 2)
end

local soldiers = {
    get_monster_class("Soldier Messenger")
}



for _, soldier in ipairs(soldiers) do
    soldier:on_damage(damaged)
    -- soldier:on_death(mob, function() self:drop_letter(mob) end)
end
