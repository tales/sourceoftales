--[[

  Goldenfields Inn.

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2012 Philippe Groarke

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

--TODO: use world variable to check if already created
local function rebelphilip_mole(being,id)
    if being_type(being) ~= TYPE_CHARACTER then
        return
    end

    --debug
    --map["scullion_created"] = 0

    local quest_mole = chr_try_get_quest(being, "rebelphilip_mole")
    local scullion_created = map["scullion_created"]

    if map["scullion_created"] == "" then
        map["scullion_created"] = 0
    end

    WARN(map["scullion_created"])
    if (quest_mole == "step1") and (tonumber(map["scullion_created"]) < 1)
    then
        map["scullion_created"] = tonumber(map["scullion_created"]) + 1
        WARN(map["scullion_created"])
        create_scullion()


    end

    --debug
    -- elseif (quest_mole == "step2") and (#scullion_patrol.members < 1) then
    -- create_scullion()
    -- end
end

atinit(function()
    require "scripts/functions/npchelper"
    parse_npcs_from_map()

    require "scripts/functions/npcpatrol"
    require "scripts/functions/triggerhelper"
    require "scripts/npcs/pub/arbert"
    require "scripts/npcs/pub/innkeepernorman"
    require "scripts/npcs/pub/borin"
    require "scripts/npcs/pub/scullionjohn"

    parse_triggers_from_map()
    create_trigger_by_name("rebelphilip mole quest", rebelphilip_mole)

end)
