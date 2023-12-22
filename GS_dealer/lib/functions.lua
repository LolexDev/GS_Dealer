function progressbar(message, time)
    lib.progressBar({
        duration = time,
        label = message,
        position = 'bottom',
        useWhileDead = false,
    })
end

function obavesti(naslov,deskripcija,type,pozicija)
    lib.notify({
        title = naslov,
        description = deskripcija,
        type = type,
        position = pozicija,
    })
end

function getujRandomItem(table)
    local randomIndex = math.random(1, #table)
    return table[randomIndex]
end

-- function upozorenje()
--     lib.alertDialog({
--         header = _U('suretitle'),
--         content = _U('areusure'),
--         centered = true,
--         cancel = true,
--         labels = {
--             confirm = _U('confirm'),
--             cancel = _U('cancel')
--         }
--     })
-- end

function diluj()
    local igrac = PlayerPedId()

    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do
        Wait(500)
    end

    TaskPlayAnim(igrac, "mp_common", "givetake1_a", 8.0, 1.0, -1, 0, 0, false, false, false)

end

function tablaIma(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end