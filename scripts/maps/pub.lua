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

local patrol = Patrol:new("Scullion John")
schedule_every(3, function() patrol:logic() end)

local function create_scullion()
    local function scullionTalk(npc, ch)
        local function say(message)
            npc_message(npc, ch, message)
        end

        say("Sorry for being so rude earlier, but you shouldn't "..
        "be venturing inside the casern. It is way to dangerous, "..
        "even for someone as sneaky as you. All this has really "..
        "stressed me out, how about you get me a drink and we'll "..
        "call it quits?")

        local choices = {"Well of course, let us talk.",
                    "I don't see why I would spend a dime for you."}
        local res = npc_choice(ch, npc, choices)

        if res == 1 then
            local check_for_beer = chr_inv_count(ch, true, true,
                "Pint of beer")
            if check_for_beer < 1 then
                say("I think Norman sells some great homebrews. "..
                    "If it's available, you should try his "..
                    "wonderfull Scotch Ale, or even his "..
                    "Imperial Stout. Even though it would never "..
                    "beat 'Le trou du diable'!")

            elseif check_for_beer >= 1 then
                chr_inv_change(ch, "Pint of beer", -1)
                say("Ahhh, this feels much better. So what do you "..
                    "want from me exactly?")
                local choices_beer = {""}
            end
        end

    end

    local scullion = create_npc_by_name("Scullion John", scullionTalk)

    being_set_base_attribute(scullion, 16, 2)
    patrol:assignBeing(scullion)

end

local function rebelphilip_mole(being,id)
    if being_type(being) ~= TYPE_CHARACTER then
        return
    end

    local quest_mole = chr_try_get_quest(being, "rebelphilip_mole")
    if (quest_mole == "step1") and (#patrol.members < 1) then
        create_scullion()
    end
end

atinit(function()
    require "scripts/functions/npchelper"
    parse_npcs_from_map()

    require "scripts/functions/npcpatrol"

    require "scripts/functions/triggerhelper"
    require "scripts/npcs/pub/arbert"
    require "scripts/npcs/pub/innkeepernorman"
    require "scripts/npcs/pub/borin"

    parse_triggers_from_map()
    create_trigger_by_name("rebelphilip mole quest", rebelphilip_mole)

end)
