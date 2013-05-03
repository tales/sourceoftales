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


function goldenfields_check_bounty(npc, ch, questvar, monster)
    local killcount = ch:kill_count(monster)
    local killcount_old = tonumber(chr_get_quest(ch, questvar))
    if killcount_old == nil then
        killcount_old = 0
    end

    local d = killcount - killcount_old
    local r = 0
    local bombvalue = 10
    local largepotionvalue = 4
    local mediumpotionvalue = 3
    local smallpotionvalue = 2
    local tinypotionvalue = 1

    local finished = false
    while not finished do
        r = math.random(5)
        if r == 1 then
            if d > bombvalue then
                ch:inv_change("Bomb", 1)
                d = d - bombvalue
            else
                finished = true
            end
        elseif r == 2 then
            if d > largepotionvalue then
                ch:inv_change("Large Healing Potion", 1)
                d = d - largepotionvalue
            else
                finished = true
            end
        elseif r == 3 then
            if d > mediumpotionvalue then
                ch:inv_change("Medium Healing Potion", 1)
                d = d - mediumpotionvalue
            else
                finished = true
            end
        elseif r == 4 then
            if d > smallpotionvalue then
                ch:inv_change("Small Healing Potion", 1)
                d = d - smallpotionvalue
            else
                finished = true
            end
        elseif r == 5 then
            if d > tinypotionvalue then
                ch:inv_change("Tiny Healing Potion", 1)
                d = d - tinypotionvalue
            else
                finished = true
            end
        end
    end
    ch:change_money(d*(5+math.random(10)))

    if (killcount >= GOLDENFIELDS_BOUNTY_LOW
        and killcount_old < GOLDENFIELDS_BOUNTY_LOW)
    then
        ch:inv_change("Iron Gloves", 1)
    end
    if (killcount >= GOLDENFIELDS_BOUNTY_MEDIUM
        and killcount_old < GOLDENFIELDS_BOUNTY_MEDIUM)
    then
        ch:inv_change("Iron Boots", 1)
    end
    if (killcount >= GOLDENFIELDS_BOUNTY_HIGH
        and killcount_old < GOLDENFIELDS_BOUNTY_HIGH)
    then
        ch:inv_change("Iron Pants", 1)
    end
    if (killcount >= GOLDENFIELDS_BOUNTY_VERY_HIGH
        and killcount_old < GOLDENFIELDS_BOUNTY_VERY_HIGH)
    then
        ch:inv_change("Iron Armor", 1)
    end
    chr_set_quest(ch, questvar, tostring(killcount))
    if killcount ~= killcount_old then
        say("Good job! Enjoy your reward.")
    end
end
