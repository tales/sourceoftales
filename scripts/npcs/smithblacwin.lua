-- authors: Jenalya

-- variable use
-- tutorial_equip: saves if got equipment from smith

local function smithTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function getEquipment()
        say("Yes?")
        local ask_equip = { "I need my equipment!",
                            "Nevermind."}
        local res = npc_choice(npc, ch, ask_equip)
        if res == 1 then
            say("Here.")
            chr_inv_change(ch, "Kettle hat", 1)
            chr_inv_change(ch, "Rusty chain armor", 1)
            chr_set_quest(ch, "tutorial_equip", "done")
            local reply_equip = { "You're not very talkative, are you?",
                                "Thanks."}
            local res = npc_choice(npc, ch, reply_equip)
            if res == 1 then
                say("No.")
            else
                say("Hm.")
            end
        else
            say("Hmph.")
        end
    end

    local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
    local tutorial_shop = chr_get_quest(ch, "tutorial_shop")
    if tutorial_equip ~= "done" then
        getEquipment()
    else
        say("Hrm.")
        if tutorial_shop == "done" then
            local ask_shop = { "I heard you could sell me better armor?",
                                "Nevermind."}
            local res = npc_choice(npc, ch, ask_shop)
            if res == 1 then
                say("TODO: shop")
                -- those stuff isn't intended to be sold, but he does that to boost his pay
            else
                say("Hmph.")
            end
        end
    end
end

local function smithWaypointReached(npc)
    gotoNextWaypoint(npc)
end

local smith_way = {
        {x=tileToPixel(67), y=tileToPixel(96), wait=10},
        {x=tileToPixel(68), y=tileToPixel(96), wait=2},
        {x=tileToPixel(67), y=tileToPixel(96), wait=8},
        {x=tileToPixel(66), y=tileToPixel(96), wait=3}}

local smith = npc_create("Smith Blacwin", 8, GENDER_MALE,
                              tileToPixel(67), tileToPixel(96),
                              smithTalk, nil)

setWaypoints(smith, smith_way, 3, smithWaypointReached)
gotoNextWaypoint(smith)
