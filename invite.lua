local req = request or http_request or (syn and syn.request)
if req then
local event = Instance.new("BindableFunction")
event.OnInvoke = function(answer)
    if answer == "Yes" then
    req({
    Url = "http://127.0.0.1:6463/rpc?v=1",
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json",
        ["Origin"] = "https://discord.com"
    },
    Body = game:GetService("HttpService"):JSONEncode({
        cmd = "INVITE_BROWSER",
        args = {
            code = "nSEbfnvtfF",
        },
        nonce = game:GetService("HttpService"):GenerateGUID(false)
    }),
    })
end
end
game.StarterGui:SetCore("SendNotification",  {
 Title = "Discord Server",
 Text = "Would you like to join our Discord server?";
 Icon = "";
 Duration = 5;
 Button1 = "Yes!";
 Button2 = "Nope";
 Callback = event;
})
end
