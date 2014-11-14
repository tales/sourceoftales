--[[

  Walter
  Home: House 4
  Relationships: Husband of Merchant Anabel

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

local function merchant_talk(npc, ch)
    say("Potions! Do you feel ill? Do you need some explosives to protect "
        .. "yourself? Or do you want to boost your abilities for battle? "
        .. "I have everything you can imagine, and even more! Have a look!")

    local choices = {
        "Show me your goods.",
        "Actually I'd like to sell something.",
        "I'm fine."
    }
    local res = ask(choices)

    if res == 1 then
        trade(false, {
            { "Tiny Healing Potion", 40, 10 },
            { "Small Healing Potion", 30, 20 },
            { "Medium Healing Potion", 20, 30 },
            { "Large Healing Potion", 10, 40 },
            { "Bomb", 10, 100 }
        })
    elseif res== 2 then
        say("Of course!")
        trade(true)
    elseif res == 3 then
        say("I hope you won't have to regret that!")
    end
end

local merchant = create_npc_by_name("Walter", merchant_talk)
