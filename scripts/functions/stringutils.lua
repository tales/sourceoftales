-- [[
-- Useful functions for working with string
-- ]]

--- Returns wether a string starts with another one
function string.starts(base_string, starting_string)
   return string.sub(base_string, 1, string.len(base_string)) == starting_string
end
