Main = {}; 

local framework = Settings.Framework;

if framework == 'ESX' then 
    ESX = nil 

    TriggerEvent('esx:getSharedObject', function(obj) 
        Main.ESX = obj  
    end) 
end

function getCharacters()
    local sqlQuery = ('SELECT * FROM %s'):format(Settings[Settings.Framework].characterTable); 
    local result = MySQL.Sync.fetchAll(sqlQuery, {});

    if not results then 
        print(('^1[ERROR]^7 %s'):format(sqlQuery));
        return; 
    end

    return result;
end

function getSpecificCharacter(identifier)
    local sqlQuery = ('SELECT * FROM %s WHERE %s = @identifier'):format(Settings[Settings.Framework].characterTable, Settings[Settings.Framework].characterId); 
    
    local result = MySQL.Sync.fetchAll(sqlQuery, {
        ['@identifier'] = identifier
    });

    if not results then 
        print(('^1[ERROR]^7 %s'):format(sqlQuery));
        return; 
    end

    return result;
end

function getPlayerJob(source)
    local framework = Settings.Framework;

    if not framework then return end; 

    local player = {}

    if framework == 'ESX' or 'Revoked' then 
        player = Main.ESX.GetPlayerFromId(source); 
    else
        local sqlQuery = ('SELECT * FROM %s WHERE %s = @identifier'):format(Settings[Settings.Framework].characterTable, Settings[Settings.Framework].characterId);

        player = MySQL.Sync.fetchAll(sqlQuery, {
            ['@identifier'] = identifier
        });

        if not results then 
            print(('^1[ERROR]^7 %s'):format(sqlQuery));
            return; 
        end
    end

    if not player then return end;

    return player.job;
end

exports('getCharacters', function()
    return Libs:getCharacters();
end)

exports('getSpecificCharacter', function(identifier)
    return Libs:getSpecificCharacter(identifier);
end)