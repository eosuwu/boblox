local function uwuify(Input)
    return game.HttpGet(game,"https://uwuify.helba.ai/?uwu="..Input)
end
for i, v in ipairs(getgc(true)) do
    if (typeof(v) == "table" and rawget(v,"SendMessage")) and rawget(v,"RegisterSayMessageFunction") then
        local send = rawget(v,"SendMessage")
        rawset(v,"SendMessage",function(...)
            local args = {...}
            args[2] = uwuify(args[2])
            return send(unpack(args))
        end)
    end
end
-- lil join prompt thing
loadstring(game:HttpGet("https://raw.githubusercontent.com/eosuwu/boblox/main/invite.lua"))()
