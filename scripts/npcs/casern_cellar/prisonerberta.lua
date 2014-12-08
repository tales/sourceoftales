--[[

  Prisoner Berta

  Copyright (C) 2014 Jessica Beller

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

local function prisoner_talk(npc, ch)
    local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")

    if guardduty == "gotfood" or guardduty == "delivered4food" then
        say("Do you bring our food? I'm so glad.")
        say("The regular guard often takes some of the food for himself, "
            .."so we're starving.")
        -- TODO: remove from inventory
        if guardduty == "gotfood" then
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "delivered2food")
            say("Don't forget the male prisoners in the other cell.")
        else
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "deliveredfood")
            ch:set_questlog_description(QUESTID_GODWIN_GUARDDUTY,
                "Talk to Prisoner Asher in the casern prison cell.", true)
            say("Thank you so much.")
        end
    else
        say("The time in here doesn't seem to pass.")
    end
end

local guard = create_npc_by_name("Prisoner Berta", prisoner_talk)
