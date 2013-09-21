--[[

  Pile of gold that turns into real money on pickup

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

local money = get_item_class("Few Gold Coins")

local amount_min = 3
local amount_max = 7

money:on("pickup", function(user)
    local count = user:inv_count(money)
    local amount = count * math.random(amount_min, amount_max)
    user:inv_change(money, -count)
    user:change_money(amount)
end)
