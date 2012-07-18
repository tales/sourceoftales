--[[
    Inside the casern.
--]]

atinit(function()
    require "scripts/functions/npchelper"
    parse_npcs_from_map()

    require "scripts/npcs/casern_north/chefodo"
    require "scripts/npcs/casern_north/guardhamond"
    require "scripts/npcs/casern_north/recruitalan"
    require "scripts/npcs/casern_north/recruitjordan"
    require "scripts/npcs/casern_north/scullionjohn"

end)

