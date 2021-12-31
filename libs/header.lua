local module = {}

module.__index = module

function module.get(header,key)
    local this,index
    for itemindex,item in ipairs(header) do
        if item[1] == key then
            this,index = item[2],itemindex
            break
        end
    end
    return this,index
end

local insert = table.insert
function module.set(header,key,value)
    local last = module.get(header,key)
    if last then
        last[2] = value
        return
    end
    insert(header,{key,value})
end

local remove = table.remove
function module.remove(header,key)
    local last,index = module.get(header,key)
    if last then
        remove(header,index)
        return last
    end
end

return module
