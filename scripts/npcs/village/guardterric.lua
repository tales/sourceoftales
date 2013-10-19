--[[

  Guard Terric

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

local function guard_talk(npc, ch)
    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("Oh my, I'm bored. I wish I'd be back in Kingstown.")

        local choices = {
            "Tell me about Kingstown!",
            "What's your problem with Goldenfields?",
            "See you later."
        }
        local res = ask(choices)

        if res == 1 then
            say("Well, that's a place where you can have fun! It's big, "
                .. "probably much bigger than a country bumpkin "
                .. "like you can imagine.")
            say("And it's full of shops where you can buy anything you can "
                .. "dream of, taverns with the tastiest beer on the entire "
                .. "continent! Hah, and if you're looking for a little fight, "
                .. "you won't have a problem to find one there.")
            say("Or someone to play a decent game, cards or dice, whatever "
                .. "you want. But you have to watch out for crooks. "
                .. "A greenhorn like you would probably get his pockets "
                .. "emptied faster than you can say 'Long live King Richard!'.")
        elseif res == 2 then
            say("Problem, you say? Hah! This place is a big NOTHING. "
                .. "Endless fields and trees and more fields.")
            say("And when something happens, it's trouble. Like those "
                .. "agitators who told the village people not to pay their "
                .. "taxes. Pah.")
        elseif res ==3 then
            say("Sure.")
        end
    elseif reputation > REPUTATION_RELUCTANT then
        say("To get amnesty for your misconducts talk to Magistrate Eustace.")
        ch:change_reputation("Soldier reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage(80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
end

local guard = create_npc_by_name("Guard Terric", guard_talk)
