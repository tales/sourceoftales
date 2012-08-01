--[[

  This function is used to give rewards for killing patrols of the opposite faction.

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2012 Stefan Beller

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


function goldenfields_check_bounty(questvar, monster)
    local killcount = chr_get_kill_count(ch, monster)
    local killcountold = tonumber(chr_get_quest(ch, questvar))
    if killcountold == nil then
        killcountold = 0
    end

    local d = killcount - killcountold
    local r = 0
    local bombvalue = 10
    local largehpotionvalue = 4
    local mediumhpotionvalue = 3
    local smallpotionvalue = 2
    local tinyhpotionvalue = 1

    local finished = false
    while not finished do
        r = math.random(5)
        if r == 1 then
            if d > bombvalue then
                chr_inv_change(ch, "Bomb", 1)
                d = d - bombvalue
            else
                finished = true
            end
        elseif r == 2 then
            if d > largehpotionvalue then
                chr_inv_change(ch, "Large Healing Potion", 1)
                d = d - largehpotionvalue
            else
                finished = true
            end
        elseif r == 3 then
            if d > mediumhpotionvalue then
                chr_inv_change(ch, "Medium Healing Potion", 1)
                d = d - mediumhpotionvalue
            else
                finished = true
            end
        elseif r == 4 then
            if d > smallpotionvalue then
                chr_inv_change(ch, "Small Healing Potion", 1)
                d = d - smallpotionvalue
            else
                finished = true
            end
        elseif r == 5 then
            if d > tinypotionvalue then
                chr_inv_change(ch, "Tiny Healing Potion", 1)
                d = d - tinypotionvalue
            else
                finished = true
            end
        end
    end
    chr_money_change(ch, d*(5+math.random(10)))

    if killcount >= GOLDENFIELDS_BOUNTY_LOW and killcountold < GOLDENFIELDS_BOUNTY_LOW then
        chr_inv_change(ch, "Iron Gloves", 1)
    end
    if killcount >= GOLDENFIELDS_BOUNTY_MEDIUM and killcountold < GOLDENFIELDS_BOUNTY_MEDIUM then
        chr_inv_change(ch, "Iron Boots", 1)
    end
    if killcount >= GOLDENFIELDS_BOUNTY_HIGH and killcountold < GOLDENFIELDS_BOUNTY_HIGH then
        chr_inv_change(ch, "Iron Pants", 1)
    end
    if killcount >= GOLDENFIELDS_BOUNTY_VERY_HIGH and killcountold < GOLDENFIELDS_BOUNTY_VERY_HIGH then
        chr_inv_change(ch, "Iron Armor", 1)
    end
    say("Good job! Enjoy your reward.")
end
