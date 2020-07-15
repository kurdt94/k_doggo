------------------------------------------
--Name: k_dog
--URI: https://github.com/kurdt94
--Description: spawn a dog with the " dog " command
--Version: 1.1
--Author: kurdt94
--Author URI: https://github.com/kurdt94
--License: GNU General Public License v3.0
------------------------------------------
Config = {}
Config.enable_blip = true
Config.enable_debugger = false

local doggo = false

-- Dog [nil|string] delete, del, remove, rem (no args (re)spawns a dog)
RegisterCommand('dog',function(source,args,rawcommand)
    Citizen.CreateThread(function()
        deleteDog()
        if args[1] == 'delete' or args[1] == 'del' or args[1] == 'remove' or args[1] == 'rem' then return end

        doggo = newDoggo("A_C_DogRufus_01","Rufus")

        while not doggo.id do
            print("wait")
            Wait(100)
            init = true
        end
    end)
end)

function deleteDog()
    if doggo then
        doggo.delete()
        doggo = false
    end
end

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