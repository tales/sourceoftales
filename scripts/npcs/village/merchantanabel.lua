--[[

  Anabel
  Home: House 4
  Relationships: Wife of Merchant Walter

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2012 Erik Schilling

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
    say("Would you like some fresh food? It's delicious and you might be "
        .. "glad about some refreshment after battle.")

    local choices = {
        "Show me your goods.",
        "Do you also buy something?",
        "I don't need anything."
    }
    local res = ask(choices)

    if res == 1 then
        trade(false, {
            { "Pumpkin", 10, 50 },
            { "Food Shank", 10, 130 },
            { "Apple", 10, 40 },
            { "Bread", 10, 50 }
        })
    elseif res== 2 then
        say("Sure. Show me what you have.")
        trade(true)
    elseif res == 3 then
        say("As you wish.")
    end
end

local merchant = create_npc_by_name("Anabel", merchant_talk)
