---- LIST OF DOG MODELS:
--A_C_DogAmericanFoxhound_01		
--A_C_DogAustralianSheperd_01		
--A_C_DogBluetickCoonhound_01		
--A_C_DogCatahoulaCur_01			
--A_C_DogChesBayRetriever_01		
--A_C_DogCollie_01		
--A_C_DogHobo_01			
--A_C_DogHound_01			
--A_C_DogHusky_01			
--A_C_DogLab_01		
--A_C_DogLion_01	
--A_C_DogPoodle_01		
--A_C_DogRufus_01			
--A_C_DogStreet_01	

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

local dog_spawned = false
RegisterCommand("doggo", function(source, args, rawCommand)
    if dog_spawned ~= false then
        SetEntityAsMissionEntity(dog_spawned, true, true)
        DeletePed(dog_spawned)
    end
    local player = PlayerPedId()
    local pCoords = GetEntityCoords(player)
    local offset = GetOffsetFromEntityInWorldCoords(player,0.0,5.0,0.0)

    local a, groundZ = GetGroundZAndNormalFor_3dCoord( offset.x, offset.y, offset.z + 10 )

    local pedModel = GetHashKey("A_C_DogRufus_01")
    while not HasModelLoaded(pedModel) do
        Wait(500)
        print("loading doggo")
        modelrequest(pedModel)
    end
    local created_ped = CreatePed(pedModel,offset.x,offset.y,groundZ,180.0,true,false)
    while not DoesEntityExist(created_ped) do
      Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, created_ped, true)
    print("new doggo : ".. created_ped)
    dog_spawned = created_ped
    Citizen.InvokeNative(0x304AE42E357B8C7E, created_ped, PlayerPedId(),6.00,0.0,0.0,-1,-1,15.0,true,true,false,true,true)
    SetPedAsGroupMember(created_ped, GetPedGroupIndex(PlayerPedId()))
end, false)
