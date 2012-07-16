-- [[
-- Offers functions to read named coordinates out of maps.
--
-- Authors:
-- + Ablu
-- ]]

function get_named_coordinate(name)
    local map_objects = map_get_objects("COORDINATE")
    for _, object in ipairs(map_objects) do
        if object:name() == name then
            local x, y, w, h = object:bounds()
            return x + w / 2, y + h / 2
        end
    end
end
