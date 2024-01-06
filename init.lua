local utf8, rsv

utf8 = require("utf8")
rsv  = {}

rsv.encode = function(tbl)
    local result = {}

    for _, v in ipairs(tbl) do
        for i = 1, select("#", unpack(v)), 1 do
            local vv = v[i]

            if vv == nil then
                result[#result + 1] = "\xFE"
            else
                for _, c in utf8.codes(tostring(vv)) do
                    result[#result + 1] = utf8.char(c)
                end
            end
            
            result[#result + 1] = "\xFF"
        end

        result[#result + 1] = "\xFD"
    end

    return table.concat(result)
end

rsv.decode = function(str)
    local result, line, val, len, i
    
    result = { {} }
    val    = ""
    line   = 1
    i      = 1
    len    = #str

    while true do
        local cmd, pos = utf8.len(str, i)

        if pos - 1 >= i then
            table.insert(result[line], utf8.char(utf8.codepoint(str, i, pos - 1)))
        end

        cmd = string.sub(str, pos, pos)
        
        if cmd == "\xFE" then
            table.insert(result[line], nil)
        elseif cmd == "\xFF" then
            table.insert(result[line], val)
        elseif cmd == "\xFD" then
            line = line + 1
            
            result[line] = {}
        end

        i = pos + 1

        if i > len then break end
    end

    table.remove(result)

    return result
end

return rsv