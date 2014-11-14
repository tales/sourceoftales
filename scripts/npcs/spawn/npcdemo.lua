local npc = npc_create("npc 1", 10, GENDER_FEMALE,
                              tileToPixel(38), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 2", 11, GENDER_FEMALE,
                              tileToPixel(40), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 3", 12, GENDER_FEMALE,
                              tileToPixel(42), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 4", 13, GENDER_FEMALE,
                              tileToPixel(44), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 5", 14, GENDER_FEMALE,
                              tileToPixel(46), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 6", 15, GENDER_FEMALE,
                              tileToPixel(48), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 7", 16, GENDER_FEMALE,
                              tileToPixel(50), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 8", 17, GENDER_FEMALE,
                              tileToPixel(52), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 9", 18, GENDER_FEMALE,
                              tileToPixel(54), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 10", 19, GENDER_FEMALE,
                              tileToPixel(56), tileToPixel(122),
                              npcTalk, nil)
local npc = npc_create("npc 11", 20, GENDER_FEMALE,
                              tileToPixel(58), tileToPixel(122),
                              npcTalk, nil)

local function npcTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say ("...")
end
