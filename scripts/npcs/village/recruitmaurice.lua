--[[

  Recruit Maurice

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

local patrol = NPCPatrol:new("Recruit Maurice")

local function recruit_talk(npc, ch)
    patrol:block(ch)

    local function chat()
        say("Hello " .. ch:name() .. ". Let's talk a bit.")

        local choices = {
            "Why did you become a soldier?",
            "Do you know why they're hiring so many recruits?",
            "I need to go."
        }
        local res = ask(choices)

        if res == 1 then
            say("Oh, I just don't want to spent the rest of my life with "
                .. "farm work. You know, I've got so many brothers and "
                .. "sisters, I didn't like the thought to drudge on a dirty "
                .. "farm all my life for my oldest brothers benefit. "
                .. "So I ran away when I was twelve.")
            say("I tramped around the area some while, finding some work to "
                .. "do here and there, but that's a cumbersome life. "
                .. "When I met the recruiter, I decided to rather become I "
                .. "soldier. I'm going to see the world, and maybe I can "
                .. "find some nice place to live after my time of service.")
        elseif res == 2 then
            say("Because of war, you dumbhead. Why else should they even come "
                .. "out here to Goldenfields to hire people? I mean, nothing "
                .. "ever happens here and usually there are only a handful of "
                .. "old soldiers here in the casern who feel bored to death.")
            say("After the basic training we're probably going to be send to "
                .. "more interesting places.")
            say("At least I hope so. If those rebels become a more serious "
                .. "problem, they might need us here.")

            local choices = {
                "Well, thanks for the information.",
                "Rebels? What do you mean?"
            }
            local res = ask(choices)

            if res == 2 then
                say("Didn't you hear? Some people got upset about the "
                    .. "increased taxes and started rioting. So far they "
                    .. "didn't seem very organized, but I heard rumors that "
                    .. "they're getting more successful.")
            end
        elseif res == 3 then
            say("Oh, ok. See you later then.")
        end
    end

    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        chat()
    elseif reputation > REPUTATION_RELUCTANT then
        say("To get amnesty for your misconducts talk to Magistrate Eustace.")
        ch:change_reputation("Soldier reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage({
            base = 80,
            delta = 10,
            chance_to_hit = 9999
        })
    end
    patrol:unblock(ch)
end

local recruit = create_npc_by_name("Recruit Maurice", recruit_talk)
recruit:set_base_attribute(16, 1)
patrol:assign_being(recruit)
schedule_every(16, function() patrol:logic() end)
