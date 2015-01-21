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

    if guardduty == "gotfood" or guardduty == "deliveredfoodmales" then
        say("Do you bring our food? I'm so glad.")
        say("The regular guard often takes some of the food for himself, "
            .."so we're starving.")

        local bread = ch:inv_count("Bread")
        if (bread >= GUARDDUTY_BREADAMOUNT_FEMALES) then
            ch:inv_change("Bread", -GUARDDUTY_BREADAMOUNT_FEMALES)
        else
            say("Oh, you don't have it?")
        end

        if guardduty == "gotfood" then
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "deliveredfoodfemales")
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
