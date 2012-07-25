--[[
    The starting map.
--]]

atinit(function()
    require "scripts/functions/npchelper"
    require "scripts/functions/triggerhelper"
    parse_npcs_from_map()
    parse_triggers_from_map()

    -- Inside of casern
    require "scripts/npcs/village/guardfordwin"
    require "scripts/npcs/village/guardterric"
    require "scripts/npcs/village/instructoralard"
    require "scripts/npcs/village/recruithugh"
    require "scripts/npcs/village/recruitmaurice"
    require "scripts/npcs/village/smithblacwin"
    require "scripts/npcs/village/veterangodwin"

    -- People in front of casern
    require "scripts/npcs/village/emma"
    require "scripts/npcs/village/merchantanabel"
    require "scripts/npcs/village/merchantgilbert"
    require "scripts/npcs/village/merchantwalter"
    require "scripts/npcs/village/monkmartin"

    -- Shrine
    require "scripts/npcs/village/priestesslinota"
 
    -- Village
    require "scripts/npcs/village/durmark"

end)

