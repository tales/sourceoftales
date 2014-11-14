--[[

 Global event script file

 This file allows you to modify how certain events which happen frequently in
 the game on different maps are supposed to be handled. It is a collection of
 script functions which are always called when certain events happen,
 regardless on which map. Script execution is done in the context of the map
 the event happens on.

  Copyright (C) 2012 Erik Schilling
  Copyright (C) 2013 Przemysław Grzywacz

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

-- This function is called when a new character enters the world for the
-- first time. This can, for example, be used to give starting equipment
-- to the character and/or initialize a tutorial quest.
local function on_chr_birth(ch)
    local spawn_items = { "Simple shirt", "Pants", "Boots" }
    for _, item in ipairs(spawn_items) do
        ch:inv_change(item, 1)
        ch:equip_item(item)
    end

    ch:heal()

    -- create initial quest
    ch:set_questlog(QUESTID_TUTORIAL_GODWIN_TALK, QUEST_OPEN, "Get your first orders",
        "You just arrived to the Caserns.\nAs a fresh recruit, you should get your orders.\n" ..
        "Talk to veteran Godwin to get your first assignment.", true)

    -- give players the strike ability
    ch:give_ability("Strike")
end


-- Register the callback that is called when the hit points of a character
-- reach zero.
on_character_death(function(ch)
    ch:say("Noooooo!!!")
end)

-- This function is called when the player clicks on the OK button after the
-- death message appeared. It should be used to implement the respawn
-- mechanic (for example: warp the character to the respawn location and
-- bring HP above zero in some way)
on_character_death_accept(function(ch)
    -- restores to full hp
    ch:heal()
    -- restores 1 hp (in case you want to be less nice)
    -- ch:heal(1)
    -- warp the character to the respawn location
    local position = chr_try_get_quest(ch, "respawn")
    if position == "" then
        position = 1 .. " " .. 2272 .. " " .. 1472 -- LATER: find out how this can be done without hard coded numbers
        chr_set_quest(ch, "respawn", position)
    end
    local map = tonumber(position:split(" ")[1])
    local x = tonumber(position:split(" ")[2])
    local y = tonumber(position:split(" ")[3])
    ch:warp(map, x, y)
end)

-- This function is called when a character logs into the game. This can,
-- for example, be utilized for a message-of-the-day or for various
-- handlings of offline processing mechanics.
on_character_login(function(ch)
    chr_request_quest(ch, "respawn", function(ch, var, value) end)
    chr_request_quest(ch, "tutorial_fight", function(ch, var, value) end)
    chr_request_quest(ch, "goldenfields_shrine", function(ch, var, value) end)
    chr_request_quest(ch, "firstlogin", function(ch, var, value)
        if value == "" then
            chr_set_quest(ch, var, "false")
            on_chr_birth(ch)
        end
    end)
end)

--
-- TODO: All of the below functions are not implemented yet!
--

-- This function is called after chr_death_accept. The difference is that
-- it is called in the context of the map the character is spawned on after
-- the respawn logic has happened.
local function on_chr_respawn(ch)
    -- calls the local_respawn_function of the map the character respawned
    -- on when the script of the map has one
    if local_respawn_function ~= nil then
        local_respawn_function(ch)
    end
end


-- This function is called when a character is disconnected. This could
-- be useful for various handling of offline processing mechanics.
local function on_chr_logout(ch)
    -- notifies nearby players of logout
    local around = get_beings_in_circle(ch, 1000)
    local msg = ch:name().." left the game."
    for b in pairs(around) do
        if b:type() == TYPE_CHARACTER then
            b:message(msg)
        end
    end
end
