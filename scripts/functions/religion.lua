--[[

  Religion related scripts

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

function creation_myth(npc, ch)
    local creation_myth_array = {
        "There are three gods. The god of fire, "
        .. "Ignis, the goddess of water, Aquaria, and The Third God. I won't "
        .. "say his name, because that might call misfortune upon myself.",
        "It happened that Ignis and Aquaria came "
        .. "together and life was born from their connection. Seeing this, "
        .. "the Third God felt rejected and created an empty rock where he "
        .. "hid to be alone with his suffering.",
        "In the meanwhile, Ignis and Aquaria saw that "
        .. "the life they created wasn't able to persist in the void where "
        .. "the gods live. They saw the place that was created by the Third "
        .. "God and ask if their creatures can live on it.",
        "The Third God, still angry, allows this only "
        .. "under the condition that the time they can spend on his place is "
        .. "limited. After the creatures' time is over, the Third God will "
        .. "take over the divine power of Ignis and Aquaria that made them "
        .. "live and absorb it to strengthen himself.",
        "Ignis and Aquaria hesitate to accept this "
        .. "demand, since their power would get weaker and weaker over time "
        .. "while the Third God would grow. But they love their creations, "
        .. "and can't bring themselves to abandon them. So they accept.",
        "Then something surprising happens. The "
        .. "creatures living on the earth, love back their creators and "
        .. "this replenishs Ignis's and Aquaria's power.",
        "This is why it is important to honor life "
        .. "and worship the gods of Ignis and Aquaria. If the humans ever "
        .. "fail to create enough spiritual power to replenish the gods of "
        .. "life, all their energy will be absorbed by death one day, and "
        .. "all life will end."
    }

    return creation_myth_array
end

function ignis_myth(npc, ch)
    local ignis_myth_array = {
        "Ignis is known as the god of fire and is "
        .. "often represented by a sun symbol.",
        "But due to his explosive temper he's also associated with the "
        .. "art of fighting and war. That's why especially warriors and "
        .. "soldiers ask him for aid."
    }

    return ignis_myth_array
end

function aquaria_myth(npc, ch)
    local aquaria_myth_array = {
        "Aquaria is the goddess of water, the "
        .. "moon is often used to represent her. She's known to be calm "
        .. "and pacifying.",
        "Her domains are fertility and growth. Due to this, she's often "
        .. "asked for aid by woman, but also farmers praying for a large "
        .. "harvest."
    }


    return aquaria_myth_array
end

function thirdgod_myth(npc, ch)
    local thirdgod_myth_array = {
        "Ah, the Third God. He's often feared "
        .. "and missunderstood, since after we die he takes the divine power "
        .. "given to us by our creators Ignis and Aquaria.",
        "But how can humans judge the actions of a god? It is not uppon "
        .. "us to decide if he's right to do that.",
        "It would be wise to honor him, as he's where we go after our "
        .. "live ended."
    }

    return thirdgod_myth_array
end
