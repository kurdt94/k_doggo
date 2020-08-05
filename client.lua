------------------------------------------
--Name: k_dog
--URI: https://github.com/kurdt94
--Description: spawn a dog with the " dog " command
--Version: 1.2
--Author: kurdt94
--Author URI: https://github.com/kurdt94
--License: GNU General Public License v3.0
------------------------------------------
Config = {}
Config.default_name = "Rufus"
Config.default_model = "A_C_DogRufus_01"
Config.enable_blip = true
Config.enable_debugger = false
Config.whistle_dog = 0x4AF4D473 -- { Q }
Config.wait_after_whistle = 10000

local doggo = false

-- Dog [nil|string] delete, del, remove, rem (no args (re)spawns a dog)
RegisterCommand('dog',function(source,args,rawcommand)
    ---- Default model
    model = Config.default_model
    name = Config.default_name
    ---- LIST OF DOG MODELS
    local mList = {
        [1] = "A_C_DogAmericanFoxhound_01",
        [2] = "A_C_DogAustralianSheperd_01",
        [3] = "A_C_DogBluetickCoonhound_01",
        [4] = "A_C_DogCatahoulaCur_01",
        [5] = "A_C_DogChesBayRetriever_01",
        [6] = "A_C_DogCollie_01",
        [7] = "A_C_DogHobo_01",
        [8] = "A_C_DogHound_01",
        [9] = "A_C_DogHusky_01",
        [10] = "A_C_DogLab_01",
        [11] = "A_C_DogLion_01",
        [12] = "A_C_DogPoodle_01",
        [13] = "A_C_DogRufus_01",
        [14] = "A_C_DogStreet_01",
    }

    Citizen.CreateThread(function()
        deleteDog()
        if args[1] == 'delete' or args[1] == 'del' or args[1] == 'remove' or args[1] == 'rem' then return end
        if type(tonumber(args[1])) == 'number' and tonumber(args[1]) <= 14 and tonumber(args[1]) >= 1 then model = mList[tonumber(args[1])] end

        if args[2] ~= nil then
            name = args[2]
        end

        doggo = newDoggo(model,name)
        while not doggo.id do
            Wait(100)
        end
    end)

end,false)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if doggo ~= false and IsControlJustReleased(0, Config.whistle_dog) then
            doggo.whistle()
            Wait(Config.wait_after_whistle)
        end

    end
end)

function deleteDog()
    if doggo then
        doggo.delete()
        doggo = false
    end
end

