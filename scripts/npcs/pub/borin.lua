--[[

  Borin
  Home: House 6
  Relationships: Husband of Millicent, father of Prisoner Asher

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

    say("He-hello ma friend. Have ya - would ya, would ya give me "
        .. "some coins for another drink?")
    say("Feeling so sh-sh-shirsty.")
    local res = {
        "No! You definitely had enough!",
        "Ok, have some."
    }
    local res = ask(res)
    if res == 2 then
        local donation = ask_number(1, 10, 5)
        local money = ch:money()
        if money >= donation then
            ch:change_money(-donation)
            say("B-b-bless ya.")
        else
            say("Eh? Ya as broke as I am...")
        end
    end
    patrol:unblock(ch)
end

local man = create_npc_by_name("Borin", man_talk)
man:set_base_attribute(16, 1)
patrol:assign_being(man)
schedule_every(43, function() patrol:logic() end)
