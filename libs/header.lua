local module = {}

module.__index = module

function module.get(header,key)
    local raw = header[key]
    if raw then
        return raw
    end
    local this,rindex,ritem
    for index,item in ipairs(header) do
        if item[1] == key then
            this,rindex,ritem = item[2],index,item
            break
        end
    end
    return this,rindex,ritem
end

local insert = table.insert
function module.set(header,key,value)
    local last,_,item = module.get(header,key)
    if item then
        item[2] = value
        return
    end
    if last then
        header[key] = value
    end
    insert(header,{key,value})
end

local remove = table.remove
function module.remove(header,key)
    local last,index,item = module.get(header,key)
    if last then
        if item then
            remove(header,index)
            return last
        else
            header[key] = nil
        end
    end
end

return module
