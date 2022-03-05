-- credits to Stefanuk12 for basically making the whole QuillBot thing
local http_request = http_request or request or (syn and syn.request) or (http and http.request)
local HttpService = game:GetService("HttpService")
if not http_request or not getgc then
    game.Players.LocalPlayer:Kick("Your exploit does not support this script!\nPlease try the auto grammar script instead.\nhttps://discord.gg/nSEbfnvtfF")
    setclipboard("https://discord.gg/nSEbfnvtfF")
end
local function GetCookie()
    -- Send cookie request
    local Response = http_request({
        Url = "https://rest.quillbot.com/api/tracking",
        Method = "POST"
    })

    -- Grab the cookie
    local Cookie = Response.Headers["set-cookie"]

    -- do some popbob trolling and griefing
    http_request({
        Url = "https://rest.quillbot.com/api/auth/spam-check",
        Method = "GET",
        Headers = {
            Cookie = Cookie
        }
    })

    return Cookie:sub(1,Cookie:find(";"))
end
local function ImproveQuillBot(Input)
    -- // Send
    local UrlFormat = "https://rest.quillbot.com/api/paraphraser/single-paraphrase/2?text=%s&strength=2&autoflip=false&wikify=false&fthresh=-1&inputLang=en&quoteIndex=-1"
    local Response = http_request({
        Url = UrlFormat:format(HttpService:UrlEncode(Input)),
        Method = "GET",
        Headers = {
            Cookie = GetCookie()
        }
    })

    -- // Make sure it did not error
    if (not Response.Success) then
        return Input
    end

    -- //
    local Body = HttpService:JSONDecode(Response.Body)
    local Improved = Body.data[1].paras_3
    local ImprovedInput = Improved[1].alt

    -- // Return
    return ImprovedInput
end


for i, v in ipairs(getgc(true)) do
    if (typeof(v) == "table" and rawget(v,"SendMessage")) and rawget(v,"RegisterSayMessageFunction") then
        local send = rawget(v,"SendMessage")
        rawset(v,"SendMessage",function(...)
            local args = {...}
            args[2] = ImproveQuillBot(args[2])
            return send(unpack(args))
        end)
    end
end
-- lil join prompt thing
loadstring(game:HttpGet("https://raw.githubusercontent.com/eosuwu/boblox/main/invite.lua"))()
