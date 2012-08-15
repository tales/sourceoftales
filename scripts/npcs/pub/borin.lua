--[[

  Borin

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

local patrol = NPCPatrol:new("Borin")

local function man_talk(npc, ch)
    patrol:block(ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("He-hello ma friend. Have ya - would ya, would ya give me "
        .. "some coins for another drink?")
    say("Feeling so sh-sh-shirsty.")
    local res = {
        "No! You definetly had enough!",
        "Ok, have some."
    }
    local res = npc_choice(npc, ch, res)
    if res == 2 then
        local donation = npc_ask_integer(npc, ch, 1, 10, 5)
        local money = chr_money(ch)
        if money >= donation then
            chr_money_change(ch, -donation)
            say("B-b-bless ya.")
        else
            say("Eh? Ya as broke as I am...")
        end
    end
    patrol:unblock(ch)
end

local man = create_npc_by_name("Borin", man_talk)
being_set_base_attribute(man, 16, 1)
patrol:assign_being(man)
schedule_every(43, function() patrol:logic() end)
