--[[

 Basic stroll ai

--]]

local STROLL_TIMEOUT = 20
local STROLL_TIMEOUT_RANDOMNESS = 10

local TARGET_SEARCH_DELAY = 10

local mob_stati = {}
local angerlist = {}

local function create_mob_status()
    return {
        angerlist = {},
    }
end

function Entity:angerlist()
    local mob_status = mob_stati[self]
    if not mob_status then
        return {}
    end

    return mob_status.angerlist
end

function Entity:change_anger(target, amount)
    local mob_status = mob_stati[self]
    if not mob_status then
        mob_status = create_mob_status()
        mob_stati[self] = mob_status
    end

    local anger = mob_status.angerlist[target]
    if not anger then
        on_remove(target, function() mob_status.angerlist[target] = nil end)
        on_death(target, function() mob_status.angerlist[target] = nil end)
    end
    anger = anger or 0
    mob_status.angerlist[target] = anger + amount
    mob_stati[self].update_target_timer = 0 -- Enforce looking for new target
end

function Entity:drop_anger(target)
    local mob_status = mob_stati[self]
    if not mob_status then
        return
    end

    mob_status.angerlist[target] = nil
end

local mob_config = require "scripts/monsters/settings"

local function calculate_position_priority(x1, y1, x2, y2, anger, range)
    if math.floor(x1 / TILESIZE) == math.floor(x2 / TILESIZE) and
       math.floor(y1 / TILESIZE) == math.floor(y2 / TILESIZE)
    then
        -- Both on the same tile
        return anger * range
    end

    local path_length = get_path_length(x1, y1, x2, y2, range, "w")
    return (range - path_length) * anger
end

local function update_attack_ai(mob, tick)
    local config = mob_config[mob:name()]

    local target
    local target_priority
    local attack_x, attack_y

    local mob_status = mob_stati[mob]
    local timer = mob_status.update_target_timer
    if timer and timer > tick then
        return false
    end

    local attack_distance = mob:modified_attribute("Range")

    for _, being in ipairs(get_beings_in_circle(mob, config.trackrange)) do
        if being:type() == TYPE_CHARACTER
           and being:action() ~= ACTION_DEAD
        then
            local anger = mob_status.angerlist[being] or 0
            if anger == 0 and config.aggressive then
                anger = 1
            end

            local possible_attack_positions = {
                {
                    x = being:x() - attack_distance,
                    y = being:y(),
                },
                {
                    x = being:x(),
                    y = being:y() - attack_distance,
                },
                {
                    x = being:x() + attack_distance,
                    y = being:y(),
                },
                {
                    x = being:x(),
                    y = being:y() + attack_distance,
                },
            }
            for _, point in ipairs(possible_attack_positions) do
                local priority = calculate_position_priority(mob:x(),
                                                             mob:y(),
                                                             point.x,
                                                             point.y,
                                                             anger,
                                                             config.trackrange)

                if priority > 0 and (not target or priority > target_priority)
                then
                    target = being
                    target_priority = priority
                    attack_x, attack_y = point.x, point.y
                end
            end
        end
    end

    mob_status.update_target_timer = tick + TARGET_SEARCH_DELAY

    if not target then
        return false
    end

    if config.cowardly then
        local d_x = mob:x() - attack_x
        local d_y = mob:y() - attack_y

        local squared_length = d_x * d_x + d_y * d_y
        d_x = d_x * (d_x < 0 and -d_x or d_x) / squared_length
        d_y = d_y * (d_y < 0 and -d_y or d_y) / squared_length

        d_x = d_x * config.strollrange + math.random(-TILESIZE, TILESIZE)
        d_y = d_y * config.strollrange + math.random(-TILESIZE, TILESIZE)

        local speed_modifier = config.flee_speed_modifier;
        if speed_modifier then
            mob:apply_attribute_modifier("Movement speed", speed_modifier, 0, 100)
        end
        mob:walk(mob:x() + d_x, mob:y() + d_y)
        return
    end

    if get_distance(mob, target) <= attack_distance then
        mob:use_ability(config.ability_id, target)
    else
        mob:walk(attack_x, attack_y)
    end
    return true
end

local function update_stroll_timer(mob_status, tick)

    mob_status.stroll_timer = tick + STROLL_TIMEOUT
                                   + math.random(STROLL_TIMEOUT_RANDOMNESS)
end

local function update_stroll(mob, tick)
    local mobconfig = mob_config[mob:name()]

    local mob_status = mob_stati[mob]
    local strollrange = mobconfig and mobconfig.strollrange or nil
    if (not mob_status.stroll_timer or mob_status.stroll_timer <= tick) and
        strollrange
    then
        local x, y = mob:position()
        local destination_x = math.random(x - strollrange, x + strollrange)
        local destination_y = math.random(y - strollrange, y + strollrange)
        if is_walkable(destination_x, destination_y) then
            mob:walk(destination_x, destination_y)
        end
        update_stroll_timer(mob_status, tick)
    end
end

local function remove_mob(mob)
    mob_stati[mob] = nil
end

local function update(mob, tick)
    local mob_status = mob_stati[mob]
    if not mob_status then
        mob_status = create_mob_status()
        mob_stati[mob] = mob_status
        on_remove(mob, remove_mob)
    end

    local stop_stroll = update_attack_ai(mob, tick)
    if stop_stroll then
        update_stroll_timer(mob_status, tick)
    else
        update_stroll(mob, tick)
    end
end

local function mob_attack(mob, target, ability_id)
    local config = mob_config[mob:name()]
    local damage = {
        base = mob:modified_attribute("Damage"),
        delta = mob:modified_attribute("Damage Delta"),
        chance_to_hit = mob:modified_attribute("Hit chance"),
    }
    target:damage(damage, mob)
end

local function mob_recharged(mob, ability_id)
    local mob_status = mob_stati[mob]
    if mob_status then
        mob_status.update_target_timer = 0 -- Enforce looking for new target
    end
end

local mob_attack_ability = get_ability_info("Monster attacks/Strike")
mob_attack_ability:on_use(mob_attack)
mob_attack_ability:on_recharged(mob_recharged)

-- Register all update functions for the ai
for name, settings in pairs(mob_config) do
    if not settings.noai then
        get_monster_class(name):on_update(update)
    end
end
