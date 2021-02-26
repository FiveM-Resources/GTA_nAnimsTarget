RegisterServerEvent("nServerSendRequest:Anims")
AddEventHandler("nServerSendRequest:Anims", function(target)
     TriggerClientEvent("nClientSendRequest:Anims", target)
end)

--||ANIMS THE TARGET AND THE SOURCE PLAYER. TAKE EXAMPLE OF THIS EVENT TO DO YOUR||--
RegisterServerEvent("nServerValidRequest:Anims") 
AddEventHandler("nServerValidRequest:Anims", function(target)
        TriggerClientEvent("GiveAnims", target)
        TriggerClientEvent("GiveAnims", source)
end)