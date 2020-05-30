ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print('CHQ Money Log Is Now Loaded')

TriggerEvent('chq:GetUser')

RegisterNetEvent('chq:GetUser')
AddEventHandler('chq:GetUser', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 

    local default = 0

    repeat
        Citizen.Wait(0)
        local result = MySQL.Sync.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })

        local name = result[1].name
        local firstname = result[1].firstname
        local lastname = result[1].lastname
        local group = xPlayer.getGroup()
        local money = xPlayer.getMoney()
        local bank = xPlayer.getAccount('bank').money

        Citizen.Wait(30 * 1000)
        if group == Config.Group then

            if money >= Config.Money then
                TriggerEvent('chq:Notify')
                print(name, group, money)               -- If you want more declared in Server Console, add from above.
                TriggerEvent('chq:MsgMoney')
            end
        
            if bank >= Config.Bank then
                TriggerEvent('chq:Notify')
                print(name, group, bank)
                TriggerEvent('chq:MsgBank')
            end
        
        else 

            if money >= Config.Money then
                TriggerEvent('chq:Notify')
                print(name, group, money)
                TriggerEvent('chq:MsgMoney')
            end
        
            if bank >= Config.Bank then
                TriggerEvent('chq:Notify')
                print(name, group, bank)
                TriggerEvent('chq:MsgBank')
            end

        end

    until default ~= 0

end)

RegisterNetEvent('chq:Notify')
AddEventHandler('chq:Notify', function()
    print('^1CHQ Money Logger^7')
end)

RegisterNetEvent('chq:MsgMoney')
AddEventHandler('chq:MsgMoney', function()
    print('^2High Deposit to Money^7')
end)

RegisterNetEvent('chq:MsgBank')
AddEventHandler('chq:MsgBank', function()
    print('^2High Deposit to Bank^7')
end)

