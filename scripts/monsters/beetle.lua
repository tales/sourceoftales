-- [[
-- Script defining the behaviour of the beetle:
-- If the beetle is attacked it will call the other beetles around to help him
-- to defend against the aggressor
--
-- Authors:
-- - Ablu
-- ]]

require "scripts/monsters/group_monster"

local beetle = get_monster_class("Beetle")
beetle:on_damage(group_monster.damage_recieved)
