
_G.require = require

--#region require modules
local corohttp = require "coro-http" ---@module "deps/coro-http"
local log = require "log" ---@module "libs/logger"
local settings = require "settings" ---@module "settings"
local httpHeader = require "header" ---@module "libs/header"
local json = require "json"
local fs = require "fs"
local headerBase = require "app.headerBase" ---@module "app/headerBase"
--#endregion require modules

local errNotfound = fs.readFileSync(settings.baseRoot:format("505.html"))
local errNotfoundHeader = headerBase.notFound(errNotfound)

--#region server
corohttp.createServer(settings.host,settings.port,function (req, body)
    local ref = (httpHeader.get(req,"Referer") or ""):gsub("%.%.",""):match("http://.-/(.-)")
    ref = ((not ref) or ref == "" or ref == "/") and "index.html" or ref

    local file = fs.readFileSync(settings.baseRoot:format(ref))
    local header
    if not file then
        file = errNotfound
        header = errNotfoundHeader
    end
    header = header or headerBase.new(file)

    return header, file
end)
--#endregion server

log.infof("Server was created at %s:%s",settings.host,settings.port)
