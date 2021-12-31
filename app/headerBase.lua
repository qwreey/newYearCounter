local module = {}

function module.new(body)
    return {
        {"Content-Length", tostring(#body)}, -- Must always be set if a payload is returned
        {"Content-Type", "text/html; charset=utf-8"}, -- Type of the response's payload (res_payload)
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
        code = 505,
    }
end

return module
