ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--===============================================
--==          Quick Withdraws                 ==
--==============================================

RegisterServerEvent('bank:fastdep')
AddEventHandler('bank:fastdep', function(base)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    base = xPlayer.getMoney()
    
    if base == nil or base <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Üstünde nakit para yok!'})
    else

    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'inform', text = 'Banka\'ya $100 dolar yatırdın.'})
    xPlayer.addAccountMoney('bank', 100)
    xPlayer.removeMoney(100)
    end
end)

   

RegisterServerEvent('bank:fastw')
AddEventHandler('bank:fastw', function(base)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    base = xPlayer.getAccount('bank').money
    
    if base == nil or base <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Bankada para yok!'})
    else

    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'inform', text = 'Hesabından $100 dolar çektin.'})   
    xPlayer.addMoney(100)
    xPlayer.removeAccountMoney('bank', 100) 
    end
end)

RegisterServerEvent('bank:fastwt')
AddEventHandler('bank:fastwt', function(base)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    base = xPlayer.getAccount('bank').money
    
    if base == nil or base <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Bankada para yok!'})
    else
    
    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'inform', text = 'Hesabına $200 dolar yatırdın.'})    
    xPlayer.addMoney(200)
    xPlayer.removeAccountMoney('bank', 200) 
    end

end)

--================================================
--==          Quick Withdraw Events -End-     --==  
--================================================


RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Geçersiz miktar!'})
    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Geçersiz miktar!'})
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)

    end
end)


RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
  
    balance = ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil and GetPlayerEndpoint(to) ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money

        if tonumber(_source) == tonumber(to) then
            TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Kendine para transfer edemezsin!'})
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
                    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Transfer edecek paran yok!'})
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))

                TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Transferi gerçekleştirdin!'})

                TriggerClientEvent('mythic_notify:client:SendAlert',  to, { type = 'inform', text = 'Size para transferi gerçekleştirildi!'})

            end

        end
    end

end)
