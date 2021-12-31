
_G.require = require

--#region require modules
local mimes = require "app.mimes"
local corohttp = require "coro-http" ---@module "deps/coro-http"
local log = require "log" ---@module "libs/logger"
local settings = require "settings" ---@module "settings"
local httpHeader = require "header" ---@module "libs/header"
local json = require "json"
local fs = require "fs"
local headerBase = require "app.headerBase" ---@module "app/headerBase"
--#endregion require modules

local errNotfoundHtml = fs.readFileSync(settings.baseRoot:format("404.html")) or ""
local errNotfoundHeader = headerBase.notFound(errNotfoundHtml)
local errHtml = fs.readFileSync(settings.baseRoot:format("500.html")) or ""
local errHeader = headerBase.err(errHtml)

--#region server
local baseRoot = settings.baseRoot
corohttp.createServer(settings.host,settings.port,function (req, body)
    local ref = (httpHeader.get(req,"path") or ""):gsub("%.%.","")
    ref = ((not ref) or ref == "" or ref == "/") and "/index.html" or ref
    ref = baseRoot:format(ref:sub(1,1) == "/" and ref or ("/" .. ref))

    local stat,err,code = fs.statSync(ref)
    if err then
        if code == "ENOENT" then
            return errNotfoundHeader,errNotfoundHtml
        end
        return errHeader,errHtml
    end
    if stat.type ~= 'file' then
        return errNotfoundHeader,errNotfoundHtml
    end

    return headerBase.new(stat.size,mimes.getType(ref)),fs.readFileSync(ref)
end)
--#endregion server

log.infof("Server was created at %s:%s",settings.host,settings.port)
