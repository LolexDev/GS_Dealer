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

local itemiTabela = Config.Itemi
local ceneTabela = Config.Cene

local stvar = getujRandomItem(itemiTabela)
local cena = getujRandomItem(ceneTabela)

if Config.KoristiBlipove == true then
    Citizen.CreateThread(function ()
      for i, v in pairs(Config.Blipovi) do
          local blip = AddBlipForCoord(v.Kordinate.x, v.Kordinate.y, v.Kordinate.z)
    
          SetBlipSprite(blip, v.Ikonica)
    
          if v.Boja ~= nil then
              SetBlipColour(blip, v.Boja)
          end
    
          SetBlipDisplay(blip, v.Pokazuj)
    
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(v.Ime)  -- Stavi ime blipu
          EndTextCommandSetBlipName(blip)
    
    
          local display = v.Pokazuj
    
          SetBlipDisplay(blip, display)
      end
    end)
    else
      TriggerServerEvent('GS_dealer:notUsingBlips')
end

Citizen.CreateThread(function()
    for _,v in pairs(Config.Diler) do
      RequestModel(GetHashKey(v.model))
      while not HasModelLoaded(GetHashKey(v.model)) do
        Wait(1)
      end
      PostaviPeda = CreatePed(4, v.model, vector3(v.coords.x, v.coords.y, v.coords.z - 1) , v.coords.w, false, true)
      TaskStartScenarioInPlace(PostaviPeda, "WORLD_HUMAN_STAND_MOBILE", 0, true)
      FreezeEntityPosition(PostaviPeda, true) 
      SetEntityInvincible(PostaviPeda, true)
      SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
        exports.qtarget:AddBoxZone('zapocni', vector3(v.coords.x, v.coords.y, v.coords.z - 1), v.coords.w, 1.0, {
            name= 'zapocni',
            heading= v.coords.w,
            debugPoly= Config.Debug,
            minZ= v.coords.z -1,
            maxZ= v.coords.z +2,
            }, {
              options = {
                {
                  action = function()
                    lib.showContext('dealer')
                  end,
                  icon = "fa-solid fa-user-secret",
                  label = _U("dealernpctext"),
                },
              }
            })
    end
end)

RegisterNetEvent("GS_dealer:kupi", function ()
    ESX.TriggerServerCallback('GS_dealer:provera', function (ima)
        if ima then
            progressbar(_U('buyingprog'), 5 * 1000)
            TriggerServerEvent("GS_dealer:kupiItem", cena, stvar)
        end
    end)
end)

-- Diler menu

lib.registerContext({
    id = 'dealer',
    title = _U('dealertitle'),
    options = {
        {
            title = _U('catalog'),
            description = _U('catalogtxt'),
            icon = 'fa-regular fa-calendar',
            disabled = false,
            onSelect = function()
                lib.showContext('katalog')
            end,
        },
    }
})

---------------------------------------------

-- Catalog menu

lib.registerContext({
    id = 'katalog',
    title = _U('catalog'),
    menu = '',
    onBack = function()
        lib.showContext('dealer')
    end,
    options = {
        {
            title = _U('catalogoptiont')..stvar,
            description =  _U('price')..cena,
            icon = "fas fa-sack-dollar",
            onSelect = function()
                diluj()
                TriggerEvent("GS_dealer:kupi")
                obavesti(_U('dealertitle'), _U('boughtitem')..stvar, 'success', 'top')
            end,
        },
        {
            title = _U('catalogsell'),
            description =  _U('selldesc'),
            icon = "fa-brands fa-sellsy",
            onSelect = function()
                local input = lib.inputDialog(_U('selltitle'), {
                    {type = 'input', label = _U('item'), required = true, min = 4, max = 16},
                    {type = 'number', label =_U('amount'), description = _U('amountD'), required = true, min = 1},
                })

                if not input then return end

                ESX.TriggerServerCallback('GS_dealer:proveraProdaje', function (ima)
                    if ima then
                        diluj()
                        progressbar(_U('sellingprog'), 5 * 1000)
                        TriggerServerEvent('GS_dealer:sell', input[1], input[2])
                    else
                        obavesti(_U('notfound'), _U('notfoundd'), 'error', 'top')
                    end
                end, input[1], input[2], cena)
            end,
        }
    }
})

---------------------------------------------