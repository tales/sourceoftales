--[[

  Libary for handling npc patrols

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

require "scripts/functions/patrol"

NPCPatrol = {}
setmetatable(NPCPatrol, {__index=Patrol})
local mt = {__index=NPCPatrol}

function NPCPatrol:new(name)
    local patrol = Patrol:new(name)
    setmetatable(patrol, mt)
    patrol.blocked_dialouges = {}
    return patrol
end

function NPCPatrol:block(ch, delay)
    self.blocked_dialouges[ch] = delay or -1
    for _, member in ipairs(self.members) do
        member:walk(member:position())
    end
    if ch then
        on_remove(ch, function() self:unblock(ch) end)
    end
end

function NPCPatrol:unblock(ch)
    self.blocked_dialouges[ch] = nil
end

function NPCPatrol:logic()
    local free = true
    for ch, timer in pairs(self.blocked_dialouges) do
        if timer > 1 or timer < 0 then
            free = false
            self.blocked_dialouges[ch] = timer - 1
        else
            self.blocked_dialouges[ch] = nil
        end
    end

    if free then
        Patrol.logic(self)
    end
end

