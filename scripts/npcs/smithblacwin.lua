local function smithTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("TODO.")
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
