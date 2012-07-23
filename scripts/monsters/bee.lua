-- [[
-- Script defining the behaviour of the bee:
-- If the bee is attacked it will call the other bee around to help him
-- to defend against the aggressor
--
-- Authors:
-- - Ablu
-- ]]

require "scripts/monsters/group_monster"

local bee = get_monster_class("Bee")
bee:on_damage(group_monster.damage_recieved)
