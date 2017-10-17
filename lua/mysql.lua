local mysql = require "resty.mysql"

local config = {
      host = "127.0.0.1",
      port = 3306,
      database = "RUNOOB",
      user = "root",
      password = "#shmeofDY123456",
      charset = "utf8",
      max_package_size = 1204 * 1204,
}

local _M = {}

function _M.new(self)
         local db, err = mysql:new()
         if not db then
            ngx.log(ngx.ALERT, 'not db')
            return nil
         end

         db:set_timeout(1000)

         local ok, err, errno, sqlstate = db:connect(config)

         if not ok then
            ngx.log(ngx.ALERT, err, errno, 'not ok')
            return nill
         end

         db.close = close
         return db
end

function close(self)
         local sock = self.sock
         if not sock then
            return nil, "not initialized"
         end

         if self.subscribed then
            return nil, "subscribed state"
         end

         return sock:setkeepalive(10000, 50)
end

return _M