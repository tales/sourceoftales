--[[
    Inside the casern.
--]]

atinit(function()
    require "scripts/functions/npchelper"
    parse_npcs_from_map()

    require "scripts/npcs/casern_north_2nd_floor/commanderranulf"
    require "scripts/npcs/casern_north_2nd_floor/lieutenantgiles"
    require "scripts/npcs/casern_north_2nd_floor/lieutenantbennet"

end)

