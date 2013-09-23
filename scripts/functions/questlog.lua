--[[

  Questlog API

  Copyright (C) 2013 Przemysław Grzywacz

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]

function questlog_status_to_text(status)
    if status == QUEST_OPEN then
        return "OPEN"
    elseif status == QUEST_FINISHED then
        return "FINISHED"
    elseif status == QUEST_FAILED then
        return "FAILED"
    else
        WARN("Invalid quest status [" .. tostring(status) .. "]")
        return "INVALID(" .. tostring(status) .. ")"
    end
end

function create_questlog(ch, quest_id, status, notify, title, description)
    ch:message("Questlog updated: id=" .. tostring(quest_id) .. ", status=" .. questlog_status_to_text(status) .. ", title=[" .. title .. "], desc=[" .. description .. "], notify=" .. tostring(notify))

    ch:set_questlog(quest_id, status, title, description, notify)
end

function set_questlog_title(ch, quest_id, title, notify)
    ch:message("Questlog updated: id=" .. tostring(quest_id) .. ", title=[" .. title .. "], notify="..tostring(notify))

    ch:set_questlog_title(quest_id, title, notify)
end

function set_questlog_description(ch, quest_id, description, notify)
    ch:message("Questlog updated: id=" .. tostring(quest_id) .. ", desc=[" .. description .. "], notify="..tostring(notify))

    ch:set_questlog_description(quest_id, description, notify)
end

function set_questlog_status(ch, quest_id, status, notify)
    ch:message("Questlog updated: id=" .. tostring(quest_id) .. ", status=" .. questlog_status_to_text(status) .. ", notify="..tostring(notify))

    ch:set_questlog_state(quest_id, status, notify)
end
