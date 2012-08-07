--[[

  Rebel Philip

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2012 Philippe Groarke

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

local patrol = NPCPatrol:new("Rebel Philip")

local function rebel_talk(npc, ch)
    patrol:block(ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function start_daggers()

    	function choice1(newchoices)
    		say("The Rebels cannot trust any new recruit, you have to prove your allegiance... "..
        		"and there may be a little reward for you.")
    		table.remove(newchoices, 1)

    		local newres = npc_choice(npc, ch, newchoices)
    		if newres == 1 then
				choice2()
    		elseif newres == 2 then
    			choice3()
    		end
    	end

    	function choice2()
    		say("Don't let me down.")
	        chr_set_quest(ch, "rebelphilip_daggers", "started")
    	end


    	function choice3()
    		say("Come back when you feel ready.")
    	end

        say("I see you have chosen the path of righteousness!" ..
        	"Our forces are getting stronger, but we need to take action. "..
            "I have devised a wonderful plan and I need your help. You need to steal "..
            "the cellar key Smith Blackwin keeps in his workshop. "..
            "What do you say?")

        local choices = { "What's in it for me?",
        				"Consider it done, I'll be as sneaky as a beetle.",
                        "I have other plans right now."}

        local res = npc_choice(npc, ch, choices)
        if res == 1 then
        	choice1(choices)
        elseif res == 2 then
			choice2()
        elseif res == 3 then
            choice3()
        end
    end

    local function finish_daggers()

    	say("Ah Ha! You have brought back the key. I never doubted your courage young Rebel. "..
    		"I feel like this is just the beginning of endeavors. Here are some blades "..
    		"that will make you as quick as a hawk. ")
    	chr_inv_change(ch, 61, -1, 60, 2)
        change_reputation(ch, "rebel_reputation", "Rebels", 20)
        change_reputation(ch, "soldier_reputation", "Army", -10)
        chr_set_quest(ch, "rebelphilip_daggers", "finished")

    end

    local function start_mole()

    	function choice1(newchoices)
    		say("Tell him I sent you, and by all means, make sure he pledges his allegiance.")
    		table.remove(newchoices, 1)

    		local newres = npc_choice(npc, ch, newchoices)
    		if newres == 1 then
    			choice2()
    		elseif newres == 2 then
    			choice3()
    		end
    	end

    	function choice2()
			say("God speed.")
    		chr_set_quest(ch, "rebelphilip_mole", "started")
    	end


    	function choice3()
    		say("You disappoint me...")
    	end

    	say("I have been informed that we may have an accomplice inside the "..
    		"army's very own casern. You can never trust leaked information, "..
    		"that is why I need you to make contact. He is working as Chef Odo's "..
    		"assistant in the kitchens. Any questions?")

    	local choices = { "What will I tell him?",
    					"I will make contact.",
    					"Maybe some other time."}

    	local res = npc_choice(npc, ch, choices)
    	if res == 1 then
    		choice1(choices)
    	elseif res == 2 then
    		choice2()
    	elseif res == 3 then
    		choice3()
    	end

    end

    local function rebelphilip_quests()
    	local daggers = chr_get_quest(ch, "rebelphilip_daggers")
    	local mole = chr_get_quest(ch, "rebelphilip_mole")

        if (daggers ~= "started") and (daggers ~= "finished") then
        	start_daggers()

        elseif daggers == "started" then
        	local inventorycheck = chr_inv_count(ch, true, true, 61)
        	if inventorycheck < 1 then
		        say("I see you have chosen the path of righteousness!")
        	elseif inventorycheck >= 1 then
        		finish_daggers()
        	end

        elseif mole == "step1" then
        	say("I see you've made first contact. The Inn will be a secure place "..
        		"to talk. Please continue your mission, it is of the "..
        		"utmost importance.")

        elseif mole == "started" then
        	say("I cannot wait to hear more about this assistant chef.")

        elseif (mole ~= "started") and (daggers == "finished") then
        	start_mole()
        else
        	say("BLEEBLAABLOUBLEE")


        end
    end

    local reputation = read_reputation(ch, "rebel_reputation")

    if reputation >= REPUTATION_ONTRIAL then
        rebelphilip_quests()
    elseif reputation >= REPUTATION_NEUTRAL then
        say("Henry is really inspiring. I was frustrated with the situation since a long while, but now Henry finally "..
            "shows me a way to do something against the unjustice of the king and his followers.")
    elseif reputation > REPUTATION_RELUCTANT then
        say("You worked against us. Talk to Innkeeper Norman to settle this conflict.")
        change_reputation(ch, "rebel_reputation", "Rebels", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        being_damage(ch, 50, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end

local rebel = create_npc_by_name("Rebel Philip", rebel_talk)
being_set_base_attribute(rebel, 16, 1)
patrol:assign_being(rebel)
schedule_every(23, function() patrol:logic() end)
