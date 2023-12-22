--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--─██████████████─████████████████───██████████████─██████──██████─██████████████────██████████████─██████████████─████████████████───██████████─██████████████─██████████████─██████████████─
--─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░░░░░██────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─
--─██░░██████████─██░░████████░░██───██░░██████░░██─██░░██──██░░██─██░░██████████────██░░██████████─██░░██████████─██░░████████░░██───████░░████─██░░██████░░██─██████░░██████─██░░██████████─
--─██░░██─────────██░░██────██░░██───██░░██──██░░██─██░░██──██░░██─██░░██────────────██░░██─────────██░░██─────────██░░██────██░░██─────██░░██───██░░██──██░░██─────██░░██─────██░░██─────────
--─██░░██─────────██░░████████░░██───██░░██──██░░██─██░░██──██░░██─██░░██████████────██░░██████████─██░░██─────────██░░████████░░██─────██░░██───██░░██████░░██─────██░░██─────██░░██████████─
--─██░░██──██████─██░░░░░░░░░░░░██───██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░██────██░░░░░░░░░░██─██░░██─────────██░░░░░░░░░░░░██─────██░░██───██░░░░░░░░░░██─────██░░██─────██░░░░░░░░░░██─
--─██░░██──██░░██─██░░██████░░████───██░░██──██░░██─██░░██──██░░██─██░░██████████────██████████░░██─██░░██─────────██░░██████░░████─────██░░██───██░░██████████─────██░░██─────██████████░░██─
--─██░░██──██░░██─██░░██──██░░██─────██░░██──██░░██─██░░░░██░░░░██─██░░██────────────────────██░░██─██░░██─────────██░░██──██░░██───────██░░██───██░░██─────────────██░░██─────────────██░░██─
--─██░░██████░░██─██░░██──██░░██████─██░░██████░░██─████░░░░░░████─██░░██████████────██████████░░██─██░░██████████─██░░██──██░░██████─████░░████─██░░██─────────────██░░██─────██████████░░██─
--─██░░░░░░░░░░██─██░░██──██░░░░░░██─██░░░░░░░░░░██───████░░████───██░░░░░░░░░░██────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██░░░░░░██─██░░░░░░██─██░░██─────────────██░░██─────██░░░░░░░░░░██─
--─██████████████─██████──██████████─██████████████─────██████─────██████████████────██████████████─██████████████─██████──██████████─██████████─██████─────────────██████─────██████████████─
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
assert(GetCurrentResourceName() == "GS_dealer", _U('license')) -- Ne diraj te // Do not touch¸

RegisterNetEvent('GS_dealer:notUsingBlips', function ()
    print(_U("noblips"))
end)

RegisterNetEvent('GS_dealer:kupiItem', function(cena, stvar)
    local player = ESX.GetPlayerFromId(source)

    player.removeInventoryItem('money', cena)
    player.addInventoryItem(stvar, 1)
    discordlogs("GS DEALER » Logs", "[" .. player.identifier .. "] [" .. GetPlayerName(player.source) .. "] je kupio : " .. stvar .. " za cenu od : "..cena.."$")
end)

ESX.RegisterServerCallback('GS_dealer:provera', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local minNovac = 50
    if xPlayer.getInventoryItem('money').count >= minNovac then
     cb(true)
    else
      cb(false)
    end
end)

ESX.RegisterServerCallback('GS_dealer:proveraProdaje', function(source, cb, stvar, kolicina)
    local xPlayer = ESX.GetPlayerFromId(source)

    if tablaIma(Config.DilerKupuje, stvar) then

        if xPlayer.getInventoryItem(stvar).count >= kolicina then
            cb(true)
        else
            cb(false)
        end
    else
        obavesti(_U('notbuying'),_U('notbuyingd'),error,'top')
        cb(false)
    end
end)

RegisterNetEvent("GS_dealer:sell", function (stvar, kolicina)
    local xPlayer = ESX.GetPlayerFromId(source)
    local kvantiti = tonumber(kolicina)

    if tablaIma(Config.DilerKupuje, stvar) then
        if xPlayer.getInventoryItem(stvar).count >= kvantiti then
            local prodaje = math.random(50, 100) * kvantiti
            xPlayer.addAccountMoney('black_money', prodaje)
            xPlayer.removeInventoryItem(stvar, kvantiti)
            discordlogs("GS DEALER » Logs", "[" .. xPlayer.identifier .. "] [" .. GetPlayerName(xPlayer.source) .. "] je prodao : " .. stvar)
        else

        end
    else
        
    end
end)

function discordlogs(name, message)
    local vreme = os.date("*t")
    local poruka = {
        {
            ["color"] = 2061822,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"]= "Vreme: " .. vreme.hour .. ":" .. vreme.min .. ":" .. vreme.sec, -- Time
            },
        }
      }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.LogHeader, embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end