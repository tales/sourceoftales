--[[

  Oliver
  Home: House 8
  Relationships: Son of Merchant Gilbert and Mary

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

local patrol = NPCPatrol:new("Oliver")

local function man_talk(npc, ch)
    patrol:block(ch)

    say("Hello.")
    local choices = {
        "I don't have time to chat.",
        "What are you doing here?"
    }
    local res = ask(choices)
    if res == 2 then
        say("Oh, I'm just hanging around. I helped my father to bring his "
            .. "goods in front of the casern and now I feel tired.")
        say("I don't like all this work. My father wants me to take over "
            .. "his shop when I'm a bit older, but all this "
            .. "merchant stuff is so terribly boring.")
        say("Being a soldier is probably much more exciting. But probably a "
            .. "lot of work as well. And dangerous.")
        say("Did you know that there are some rebels hiding in the forest? "
            .. "If I became a soldier, I'd have to fight them!")
        -- LATER: quest involving his father to motivate him to be
        -- interested in the shop
    end
    patrol:unblock(ch)
end

local man = create_npc_by_name("Oliver", man_talk)
man:set_base_attribute(16, 1)
patrol:assign_being(man)
schedule_every(10, function() patrol:logic() end)
