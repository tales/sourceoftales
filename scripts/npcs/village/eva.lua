--[[

  Eva - gossiping on the market place
  Home: House 7
  Relationships: Sister of Thea, aunt of Emma

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

local patrol = NPCPatrol:new("Eva")

local function woman_talk(npc, ch)
    patrol:block(ch)

    local hair_color = chr_get_hair_color(ch)
    if hair_color == 0 then

        local quest = chr_get_quest(ch, "eva_pink_hair")
        if quest ~= "finished" then
            say("Oh!")
            say("My!")
            say("God!")
            say("I looooooooooooooooove your hair!")
            say("I wish I had pink hair like you. Don't you think it would "
                .. "look good on me?")
            local res = {
                "Yes, of course.",
                "Not really..."
            }
            local res = npc_choice(npc, ch, res)
            if res == 1 then
                say("I know! I know! You are such a wonderful person, "
                    .. "can I have an autograph? Please, pretty please??? ")
                say("I'll pay you for it. I... I think I'm in love...")
                chr_money_change(ch, 10)
                chat_message(ch, "You have recieved 10 gold.")
                say("There you go, will you sign this?")
                local autograph = npc_ask_string(npc, ch)
                say("Thank you, " .. autograph .. ", I will keep it close to my "
                    .. "heart.")
                chr_set_quest(ch, "eva_pink_hair", "finished")

            elseif res == 2 then
                say("Hmph! Your hair is actually ugly, I was lying.")
                chr_set_quest(ch, "eva_pink_hair", "finished")
            end
        else
            say("Did you see Anabel in front of the casern? And her husband "
                .. "Walter?")
            say("Since so many soldiers arrived and the casern is so lively, "
                .. "they spend most of their time fawning around the soldiers, "
                .. "trying to earn some money by selling their mediocre goods.")
            say("It's really a shame, this village used to be such a lovely "
                .. "place to live, and with these soldiers around everyone "
                .. "behaves differently. Instead of doing honest and decent "
                .. "farm work, they think they can be merchants now!")
        end

    else
        say("Did you see Anabel in front of the casern? And her husband Walter?")
        say("Since so many soldiers arrived and the casern is so lively, they "
            .. "spend most of their time fawning around the soldiers, "
            .. "trying to earn some money by selling their mediocre goods.")
        say("It's really a shame, this village used to be such a lovely place "
            .. "to live, and with these soldiers around everyone behaves "
            .. "differently. Instead of doing honest and decent farm work, "
            .. "they think they can be merchants now!")
    end
    patrol:unblock(ch)
end

local woman = create_npc_by_name("Eva", woman_talk)
woman:set_base_attribute(16, 1)
patrol:assign_being(woman)
schedule_every(10, function() patrol:logic() end)
