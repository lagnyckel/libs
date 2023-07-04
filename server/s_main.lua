ESX = nil 

Libs = {}; 

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj  
end) 

function Libs:getCharacters()
    local sqlQuery = ('SELECT * FROM %s'):format(Settings[Settings.Framework].characterTable); 
    local result = MySQL.Sync.fetchAll(sqlQuery, {});

    if not results then 
        print(('^1[ERROR]^7 %s'):format(sqlQuery));
        return; 
    end

    return result;
end

function Libs:getSpecificCharacter(identifier)
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

exports('getCharacters', function()
    return Libs:getCharacters();
end)

exports('getSpecificCharacter', function(identifier)
    return Libs:getSpecificCharacter(identifier);
end)