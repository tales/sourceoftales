--[[

  Prisoner Asher
  Relationships: Son of Millicent and Borin

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
    local function ask_favor()
        say("Can you please deliver a message to my mother? Her name is Millicent and she lives on the northern end of Goldenfields.")
        say("Please tell here that I'm ok and not hurt. She must be so worried.")
        say("And tell her that I'm sorry that I lost control. "
            .."I made everything worse by trying to throw out those soldiers and getting myself arrested.")
        say("I really wish I could do something to help her.")
        local res = ask {
            "Ok, I will tell her.",
            "What happened to you?"
        }

        if res == 2 then
            say("I got myself arrested for resisting the orders of the king and his representatives.")
            say("Do you know about the increased taxes because of the war? Well, our family never was rich "
                .."and my father has the habit to visit the pub much too often. "
                .."But we made it somehow.")
            say("But after they increased the taxes again, we couldn't pay anymore. "
                .."They were going to take it anyway, without leaving us enough to make it through the winter and have enough "
                .."for sowing in the next year.")
            say("My mother was crying and my father just stood there staring at them. And I got so angry that I just lost control. "
                .."I screamed at them and tried to push them out of our house. No surprise they didn't like it.")
            say("Now my parents have to deal with the increased workload alone and I'm not likely to get out here soon. "
                .."Resisting the army in times of war is considered a pretty grave crime.")
        end

        chr_set_quest(ch, "soldier_goldenfields_guardduty", "delivermessage")
        ch:set_questlog_description(QUESTID_GODWIN_GUARDDUTY,
            "Talk to Millicent in Goldenfields about her son.", true)
        say("Please, at least tell her I'm ok, so she doesn't have to worry about me. Remember, our house is on the northern end of Goldenfields.")
    end

    local function deliver_food()
        say("Do you have our food? Finally!")

        local bread = ch:inv_count("Bread")
        if (bread >= GUARDDUTY_BREADAMOUNT_MALES) then
            ch:inv_change("Bread", -GUARDDUTY_BREADAMOUNT_MALES)
        else
            say("Oh, you don't have it?")
        end

        local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")

        if guardduty == "gotfood" then
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "deliveredfoodmales")
            say("Don't forget the female prisoners in the other cell.")
            say("But please, can you come back here afterwards? I have a small favor to ask.")
        else
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "deliveredfood")
            ch:set_questlog_description(QUESTID_GODWIN_GUARDDUTY,
                "Talk to Prisoner Asher in the casern prison cell.", true)
            say("Thank you so much! But before you leave, can you listen to me? I have a favor to ask.")
            ask_favor()
        end
    end


    local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")

    if guardduty == "gotfood" or guardduty == "deliveredfoodfemales" then
        deliver_food()
    elseif guardduty == "deliveredfoodmales" then
        say("Don't forget the female prisoners in the other cell.")
    elseif guardduty == "deliveredfood" then
        ask_favor()
    elseif guardduty == "delivermessage" then
        say("Please go talk to my mother Millicent in the northern part of Goldenfields.")
    elseif guardduty == "reportback" or guardduty == "done" then
        say("Thank you for talking to my mother.")
    else
        say("I'm such a fool.")
    end
end

local guard = create_npc_by_name("Prisoner Asher", prisoner_talk)
