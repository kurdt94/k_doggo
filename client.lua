---- LIST OF DOG MODELS
--[1] = "A_C_DogAmericanFoxhound_01",
--[2] = "A_C_DogAustralianSheperd_01",
--[3] = "A_C_DogBluetickCoonhound_01",
--[4] = "A_C_DogCatahoulaCur_01",
--[5] = "A_C_DogChesBayRetriever_01",
--[6] = "A_C_DogCollie_01",
--[7] = "A_C_DogHobo_01",
--[8] = "A_C_DogHound_01",
--[9] = "A_C_DogHusky_01",
--[10] = "A_C_DogLab_01",
--[11] = "A_C_DogLion_01",
--[12] = "A_C_DogPoodle_01",
--[13] = "A_C_DogRufus_01",
--[14] = "A_C_DogStreet_01",

-- usage :
-- " doggo " , spawns or respawn a dog ( you can't spawn multiple dogs )
-- " doggo delete" , deletes your dog

local dog_model = "A_C_DogRufus_01"
local following_range = 4.0
local wandering_range = 10.0

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

local dog_spawned = false
local last_loc = false
RegisterCommand("doggo", function(source, args, rawCommand)
    if dog_spawned ~= false then
        SetEntityAsMissionEntity(dog_spawned, true, true)
        DeletePed(dog_spawned)
        if args[1] == 'delete' then
            return
        end
    end
    local player = PlayerPedId()
    last_loc = GetEntityCoords(player)
    local offset = GetOffsetFromEntityInWorldCoords(player,0.0,5.0,0.0)
    local a, groundZ = GetGroundZAndNormalFor_3dCoord( offset.x, offset.y, offset.z + 10 )

    local pedModel = GetHashKey(dog_model)
    while not HasModelLoaded(pedModel) do
        Wait(500)
        print("loading doggo : " .. dog_model)
        modelrequest(pedModel)
    end
    local created_ped = CreatePed(pedModel,offset.x,offset.y,groundZ,180.0,true,false)
    while not DoesEntityExist(created_ped) do
      Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, created_ped, true)
    print("new doggo : ".. dog_model .. " | id: ".. created_ped)
    dog_spawned = created_ped
    Citizen.InvokeNative(0x304AE42E357B8C7E, created_ped, PlayerPedId(),6.00,0.0,0.0,-1,-1,following_range,true,true,false,true,true)
    SetPedAsGroupMember(created_ped, GetPedGroupIndex(PlayerPedId()))
end, false)

function DoggoWander()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    Citizen.InvokeNative(0xE054346CA3A0F315, dog_spawned, coords.x, coords.y, coords.z, wandering_range, tonumber(1077936128), tonumber(1086324736), 1)
end

function DoggoFollow()
    Citizen.InvokeNative(0x304AE42E357B8C7E, dog_spawned, PlayerPedId(),6.00,0.0,0.0,-1,-1,following_range,true,true,false,true,true)
end

local wandering = false
Citizen.CreateThread(function ()
    while true do
        Wait(1000)
        local player = PlayerPedId()
        local player_loc = GetEntityCoords(player)

        if dog_spawned then
            local doggo_loc = GetEntityCoords(dog_spawned)
            local dist_to_doggo = Vdist(player_loc.x, player_loc.y, player_loc.z, doggo_loc.x,  doggo_loc.y, doggo_loc.z)
            if dist_to_doggo <= wandering_range and not wandering and Citizen.InvokeNative(0xAC29253EEF8F0180,player) then
                following = false
                DoggoWander()
                wandering = true
            end
            if not Citizen.InvokeNative(0xAC29253EEF8F0180,player) and not following then
                wandering = false
                DoggoFollow()
                following = true
            end
        end
    end
end)