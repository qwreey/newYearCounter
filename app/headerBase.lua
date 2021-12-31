local module = {}

function module.new(size,Type)
    return {
        {"Content-Length", tostring(size)}, -- Must always be set if a payload is returned
        {"Content-Type", Type or "text/html; charset=utf-8"}, -- Type of the response's payload (res_payload)
        {"Connection", "close"}, -- Whether to keep the connection alive, or close it
        code = 200,
        reason = "OK",
    }
end

function module.notFound(body)
    return {
        {"Content-Length", tostring(#body)}, -- Must always be set if a payload is returned
        {"Content-Type", "text/html; charset=utf-8"}, -- Type of the response's payload (res_payload)
        {"Connection", "close"}, -- Whether to keep the connection alive, or close it
        code = 404,
    }
end
function module.err(body)
    return {
        {"Content-Length", tostring(#body)}, -- Must always be set if a payload is returned
        {"Content-Type", "text/html; charset=utf-8"}, -- Type of the response's payload (res_payload)
        {"Connection", "close"}, -- Whether to keep the connection alive, or close it
        code = 500,
    }
end

return module
