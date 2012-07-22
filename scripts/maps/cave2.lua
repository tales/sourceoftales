-- [[
-- Script file of cave2.
-- This map will contain various traps / scripted spawns
--
-- Authors:
-- + Ablu
-- ]]

local alcoves_monster_number = 0

local function alcovesOnRemove()
    alcoves_monster_number = alcoves_monster_number - 1
end

local function alcovesSpawn(being)
    if being_type(being) == TYPE_CHARACTER and alcoves_monster_number == 0 then
        local mobs = {}
        alcoves_monster_number = 6
        table.insert(mobs, monster_create("Skeleton",
                     get_named_coordinate("Skeleton Spawn")))
        table.insert(mobs, monster_create("Skeleton",
                     get_named_coordinate("Skeleton2 Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier2 Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier3 Spawn")))
        table.insert(mobs, monster_create("Skeleton Soldier",
                     get_named_coordinate("Skeleton Soldier4 Spawn")))

        for _, mob in ipairs(mobs) do
            on_remove(mob, alcovesOnRemove)
        end
    end
end

atinit(function()
    require "scripts/functions/triggerhelper"
    parse_triggers_from_map()

    create_trigger_by_name("alcoves spawn", alcovesSpawn)
end)
