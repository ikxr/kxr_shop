ESX = exports['es_extended']:getSharedObject()

RegisterCommand('sklep', function()
    OpenShopMenu()
end)

function OpenShopMenu()
    local elements = {
        {label = "Bandaż ($100)", value = 'bandage', price = 100},
        {label = "Pistolet ceramiczny ($200)", value = 'ceramicpistol', price = 200},
        {label = "SNS MK2 ($100)", value = 'snspistol_mk2', price = 100}
    }

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_shop', {
        title = "Sklep",
        align = 'center',
        elements = elements
    }, function(data, menu)
        PurchaseItem(data.current.value, data.current.price)
    end, function(data, menu)
        menu.close()
    end)
end

function PurchaseItem(item, price)
    ESX.TriggerServerCallback('esx_shop:buyItem', function(success)
        if success then
            ESX.ShowNotification('Zakupiono ' .. item)
        else
            ESX.ShowNotification('Nie masz wystarczająco pieniędzy')
        end
    end, item, price)
end