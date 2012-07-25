--[[

  Priestess Linota

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

require "scripts/functions/religion"

local function priestessTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function legends()
        say("What would you like me to tell you about?")
        local choices = { "Where do we come from?",
                        "Please tell me about Ignis.",
                        "Can you tell me about Aquaria?",
                        "I'd like to know more about the Third God." }
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            creation_myth(npc, ch)
        elseif res == 2 then
            ignis_myth(npc, ch)
        elseif res == 3 then
            aquaria_myth(npc, ch)
        else
            thirdgod_myth(npc, ch)
        end
    end

    legends()
end

local priestess = create_npc_by_name("Priestess Linota", priestessTalk)
