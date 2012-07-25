--[[

  Walter

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

local function merchantTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Potions! Do you feel ill? Do you need some explosives to protect yourself? Or do you want to boost your abilities for battle? I have everything you can imagine, and even more! Have a look!")

    local choices = { "Show me your goods.",
                    "I'm fine." }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("TODO: shop with potions")
    elseif res == 2 then
        say("I hope you won't have to regret that!")
    end
end

local merchant = create_npc_by_name("Walter", merchantTalk)
