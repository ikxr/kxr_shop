ESX = exports['es_extended']:getSharedObject()

function sendToDiscord(webhook, title, message)
    local discordInfo = {
        {
            ["color"] = 3447003,
            ["title"] = title,
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S"),
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Sklep logi", embeds = discordInfo}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('esx_shop:buyItem', function(source, cb, item, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    if money >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1)
        cb(true)

        sendToDiscord('https://discord.com/api/webhooks/1250810293886386247/Kh3696POrCUtqn-PJIRVZbvDGq2CHstYu2CZxnwtf05KV6MIwuOLZBJz5KiSHfe1vfY-', 'Zakup przedmiotu', ('%s zakupił %s za $%s'):format(xPlayer.getName(), item, price))
    else
        cb(false)
    end
end)