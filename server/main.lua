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

        local name = result[1].name                 -- If you would like more declared, add to print() below
        local firstname = result[1].firstname
        local lastname = result[1].lastname
        local group = xPlayer.getGroup()
        local money = xPlayer.getMoney()
        local bank = xPlayer.getAccount('bank').money

        Citizen.Wait(30 * 1000)
        if group ~= Config.Group then
            local msg
            if money >= Config.Money then
                msg = name.." high deposit to money "..money
                TriggerEvent('chq:Notify', msg, "high")
            end
        
            if bank >= Config.Bank then
                msg = name.." high deposit to bank "..bank
                TriggerEvent('chq:Notify', msg, "high")
            end
        end

    until default ~= 0

end)

RegisterNetEvent('chq:Notify')
AddEventHandler('chq:Notify', function(msg, status)
    local prefix
    -- you can add different status here and append different colors for each
    if status == "high" then
        prefix = "^2"
    else
        prefix = "^7"
    end

    print(status..msg.."^7")
end)