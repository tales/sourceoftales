-- [[
-- Script defining the behaviour of the soldier:
-- If the soldier is attacked it will call the other soldiers around to help him
-- to defend against the aggressor
--
-- Authors:
-- - Jurkan
-- ]]

require "scripts/monsters/group_monster"

local soldier = get_monster_class("Soldier")
soldier:on_damage(group_monster.damage_recieved)
