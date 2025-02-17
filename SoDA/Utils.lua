-- https://stackoverflow.com/a/15706820
function SoDA:spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys + 1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a, b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function SoDA:GetClassColor(class)
    if class == "SHAMAN" then
        return 0.0, 0.44, 0.87, "#0070DD"
    else
        return GetClassColor(class)
    end
end
