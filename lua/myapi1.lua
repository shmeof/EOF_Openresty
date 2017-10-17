local cjson = require "cjson"
local mysql = require "mysql"
local req = require "req"

local args = req.getArgs()

if args == nill then
   return {}
end

country = args['country']
if country == nil or country == "" then
   country = "root"
end

country = ngx.quote_sql_str(country) -- SQL转义，'转成\'，防SQL注入，并且转义后的变量包含了引号，所以可以直接当成条件值使用

local db = mysql:new()
local sql = "select * from websites where country = " .. country

ngx.say(sql)
ngx.say("<br/>")

if db == nill then
   return {}
end

local res, err, errno, sqlstate = db:query(sql)
db:close()

if not res then
   ngx.say(err)
   return {}
end

ngx.say(cjson.encode(res))

