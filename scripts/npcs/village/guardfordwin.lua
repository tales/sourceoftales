--[[

  Guard Fordwin

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

-- authors: Jenalya

local patrol = NPCPatrol:new("Guard Fordwin")

local function guard_talk(npc, ch)
    patrol:block(ch)

    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("These merchants are worse than blowflies! If I don't pay "
            .. "attention for a moment, they'll sneak into the casern "
            .. "to distract the new recruits with their goods.")

        local emma = chr_get_quest(ch, "rebels_emmas_camouflage")
        if emma == "ask" then
            local choices = {
                "That girl, Emma, could you let her enter?",
                "Then I won't distract you."
            }
            local res = ask(choices)
            if res == 1 then
                say("What, now she started to ask soldiers to beg for her? "
                    .. "That girl drives me insane.")
                say("Listen, this is an army. This isn't the place to fool "
                    .. "around. No civilians in the casern.")
                chr_set_quest(ch, "rebels_emmas_camouflage", "deny")
            end
        end
    elseif reputation > REPUTATION_RELUCTANT then
        say("To get amnesty for your misconducts talk to Magistrate Eustace "
            .. "in Goldenfields.")
        ch:reputation("Soldier reputation", "Army", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage(80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end

local function guard_denyExit(ch)
    if ch:type() ~= TYPE_CHARACTER then
        return
    end

    local quest = chr_try_get_quest(ch, "tutorial_fight")
    if quest ~= "done" then
        ch:message("Guard Fordwin: Hey! I can't let you pass like this. "
                    .. "Get your equipment and finish your basic training!")
        local x, y = get_named_coordinate("Gate Warp")
        ch:warp(nil, ch:x(), y)
        ch:set_direction(DIRECTION_UP)
    end
end

local guard = create_npc_by_name("Guard Fordwin", guard_talk)
create_trigger_by_name("Casern south gate", guard_denyExit)
guard:set_base_attribute(16, 1)
patrol:assign_being(guard)
schedule_every(34, function() patrol:logic() end)
