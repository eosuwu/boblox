local http_request = http_request or request or (syn and syn.request) or (http and http.request)
if not http_request or not getgc then
    game.Players.LocalPlayer:Kick("Your exploit does not support this script!\nPlease try the auto grammar script instead.\nhttps://discord.gg/nSEbfnvtfF")
    setclipboard("https://discord.gg/nSEbfnvtfF")
end
local function uwuify(Input)
    local fortnite = http_request({
      Url = "https://uwuify.helba.ai/?uwu="..Input,
      Method = "GET"
    })
    return fortnite.Body
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
