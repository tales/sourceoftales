--[[

  Magistrate Eustace
  Home: House 9
  Relationships: Husband of Lady Primeveire, employer of Maid Golda

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2014 Jessica Beller

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

local patrol = NPCPatrol:new("Magistrate Eustace")

local function magistrate_talk(npc, ch)
    patrol:block(ch)
    local function set_respawn()
         -- LATER: find out how this can be done without hard coded numbers
        local position = 1 .. " " .. 2272 .. " " .. 1472
        chr_set_quest(ch, "respawn", position)
    end

    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("These rebels are really annoying. I mean as if there aren't "
            .. "already enough problems with the war.")
        say("And you won't believe it, there are even people swearing "
            .. "they've seen skeletons walking around! "
            .. "What a nonsense! But the priestess seemed to be rather "
            .. "worried about it. Pah.")
        -- LATER: some more talk, maybe depending on the quest state
    else
        say("Ah. I already heard about your misconducts against the kingdom. "
            .. "Did you come here to recompense for them?")
        local choices = {
            "Yes, what do I have to pay?",
            "No!",
            "What would be the consequences?"
        }
        local res = ask(choices)
        if res == 1 then
            apply_amnesty(npc, ch, "Soldier reputation", "Rebel reputation")
            set_respawn()
        elseif res == 3 then
                say("You'd be granted amnesty for your crimes, the army's "
                    .. "patrols would stop attacking you and members "
                    .. "of the army will be willing to talk to you again.")
                say("Those rebel scum you collaborated with won't like that "
                    .. "of course and they'll turn hostile against you.")
                say("So, what's your decision?")
                local choices = {
                    "I accept, what do I have to pay?",
                    "I don't want to pay."
                }
                local res = ask(choices)
                if res == 1 then
                    apply_amnesty(npc, ch, "Soldier reputation", "Rebel reputation")
                    set_respawn()
                end
        else
            say("No? Well, we don't have any business with each other then.")
        end
    end
    patrol:unblock(ch)
end

local magistrate = create_npc_by_name("Magistrate Eustace", magistrate_talk)

magistrate:set_base_attribute(16, 1)
patrol:assign_being(magistrate)
schedule_every(15, function() patrol:logic() end)
