--[[

  Millicent
  Home: House 6
  Relationships: Wife of Borin, mother of Prisoner Asher

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

local patrol = NPCPatrol:new("Millicent")

local function woman_talk(npc, ch)
    patrol:block(ch)

    local function hear_message()
        local res = ask {"I have a message for you. (Deliver message)"}

        chr_set_quest(ch, "soldier_goldenfields_guardduty", "reportback")
        ch:set_questlog_description(QUESTID_GODWIN_GUARDDUTY,
          "Report back to Veteran Godwin.", true)

        say("It's very kind of you to come here and tell me about that. Thank you!")

        local res = ask {
            "I'm glad I could help, see you.",
            "What happened to get him into prison?"
        }
        if res == 2 then
            say("Oh, it was a stupid, stupid thing. We couldn't pay our taxes and "
                .. "he resisted the soldiers coming to get them, he got angry and attacked them.")
            say("You know, we weren't doing so good even when times were better, "
                .. "and my husband spending so much time and money at the pub certainly didn't help.")
            say("But nowadays with the war and the increased taxes, it's just impossible.")
            say("I'm just glad we're still allowed to stay in our house. To be able to pay the taxes, "
                .. "we had to sell it and our fields to Arbert. If we don't work hard enough "
                .. "he's going to kick us out and hire someone else instead.")
            say("Not that I blame him for that, times are hard and he has to pay his taxes too.")
            say("Really, I'm not surprised that so many of the young people go and join those rebel group.")
        end
    end

    say("Have you seen my husband Borin? I bet he's in the pub again...")
    say("I work all day, and he has nothing better to do than taking our "
        .. "money and spend it on getting drunk.")

    local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")
    if guardduty == "delivermessage" then
        hear_message()
    end

    patrol:unblock(ch)
end

local woman = create_npc_by_name("Millicent", woman_talk)
woman:set_base_attribute(16, 1)
patrol:assign_being(woman)
schedule_every(11, function() patrol:logic() end)
