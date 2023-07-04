Utilites = {};

function Utilites:DrawText3D(coords, text)
    SetDrawOrigin(coords)
    
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextCentre(1)
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    EndTextCommandDisplayText(0.0, 0.0)
  
    BeginTextCommandGetWidth("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    local textWidth = EndTextCommandGetWidth(1)
    local width = textWidth + 0.0015
    local characterHeight = GetRenderedCharacterHeight(0.35, 4) * 1.3
    DrawRect(0.0, characterHeight/2, width, characterHeight, 45, 45, 45, 150)
    
    ClearDrawOrigin()
end

function Utilites:CreateObject(data)
    local model = (type(data.model) == 'number' and data.model or GetHashKey(data.model))
    
    RequestModel(model)
    
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    
    local obj = CreateObject(data.model, data.coords.x, data.coords.y, data.coords.z, true, true, true); 

    return obj
end

function Utilites:CreatePed(data)
    RequestModel(data.model)

    while not HasModelLoaded(data.model) do
        Citizen.Wait(0)
    end

    local ped = CreatePed(4, data.model, data.coords.x, data.coords.y, data.coords.z - 0.98, data.coords.w, true, true, true); 

    SetEntityAsMissionEntity(ped, true, true); 
    SetBlockingOfNonTemporaryEvents(ped, true);
    
    FreezeEntityPosition(ped, true)

    if data.anim.animDict and data.anim.animName then
        self:PlayAnimation(ped, data.anim)
    end

    return ped
end

function Utilites:CreateVehicle(data)
    RequestModel(data.model); 

    while not HasModelLoaded(data.model) do
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(data.model, data.coords.x, data.coords.y, data.coords.z, data.coords.w, true, true);

    SetVehicleOnGroundProperly(vehicle);
    SetEntityAsMissionEntity(vehicle, true, true);

    NetworkFadeInEntity(vehicle, true, true)

    if data.plate then
        SetVehicleNumberPlateText(vehicle, data.plate or 'LOWKEY')
    end

    return vehicle
end

function Utilites:PlayAnimation(ped, data)
    RequestAnimDict(data.animDict)
    
    while not HasAnimDictLoaded(data.animDict) do
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(ped, data.animDict, data.animName, 8.0, 8.0, -1, data.flag, 0, false, false, false)
end

function Utilites:CreateScene(data)
    local scene = NetworkCreateSynchronisedScene(data.coords, data.rot, 2, false, false, 1065353216, 0, 1.3); 

    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, data.animDict, data.animName, 2.0, -2.0, 13, 16, 1148846080, 0);
    NetworkStartSynchronisedScene(scene)

    return scene
end

function Utilites:DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function Utilites:DrawScriptMarker(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end  

function Utilites:HelpNotification(text)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end