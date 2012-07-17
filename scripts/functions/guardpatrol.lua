-- [[
-- Libary for handling guard patrols
--
-- Authors:
-- + Ablu
-- ]]

require "scripts/functions/patrol"

GuardPatrol = {}
setmetatable(GuardPatrol, {__index=Patrol})
local mt = {__index=GuardPatrol}

function GuardPatrol:new(name, track_range)
    local patrol = Patrol:new(name)
    setmetatable(patrol, mt)
    patrol.track_range = track_range
    return patrol
end

function GuardPatrol:setTrackRange(radius)
    self.track_range = radius
end

function GuardPatrol:logic()
    local x = self.path[self.position_index].x
    local y = self.path[self.position_index].y
    local all_in_range = true

    local enemys = {}
    local beings = get_beings_in_rectangle(x - self.track_range,
                                           y - self.track_range,
                                           self.track_range * 2,
                                           self.track_range * 2)

    for _, being in ipairs(beings) do
        if self:isAggressiveAgainst(being) then
            table.insert(enemys, being)
        end
    end

    local enemy_count = 0

    for _, member in ipairs(self.members) do
        -- Check for out of range enemys
        local anger_list = monster_get_angerlist(member)
        enemy_count = enemy_count + #anger_list
        for ch, anger in pairs(anger_list) do
            if get_distance(posX(ch), posY(ch), x, y) > self.track_range * 2 then
                monster_drop_anger(member, ch)
                enemy_count = enemy_count - 1
            end
        end

        for _, enemy in ipairs(enemys) do
            monster_change_anger(member, enemy, 1)
        end
    end

    -- No enemys, handle walkcycle
    if enemy_count == 0 then
        Patrol.logic(self)
        return
    end
end

function GuardPatrol:isAggressiveAgainst(being)
    return being_type(being) == TYPE_CHARACTER and
           being_get_base_attribute(being, 13) > 0
end
