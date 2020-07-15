------------------------------------------
--Name: func.lua
--Description: global functions
--Version: 1.0
--License: GNU General Public License v3.0
------------------------------------------

-- [HashKey] model { native: RequestModel }
function modelrequest(model)
    Citizen.CreateThread(function()
        RequestModel(model)
    end)
end

-- [table] table { return lenght of table }
function tablelength(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

-- [int] x , [int] y, [str] text { draw 2D text on screen }
function DrawText(x,y,text)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)--true,false
    SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

-- [int] x , [int] y, [int] z, [str] text { draw 3D text on screen }
function DrawText3D(x,y,z,text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.25, 0.25)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
end

-- [int] x , [int] y, [int] z, [int] _x , [int] _y, [int] _z, [int] r , [int] g, [int] b, [int] a  { draw a line }
function DrawLine(x,y,z,_x,_y,_z,r,g,b,a)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, x, y, z, _x, _y, _z, r, g, b, a)
end
