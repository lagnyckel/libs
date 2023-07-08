Main = {}; 

ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj  
end) 


function getCharacters()
    local sqlQuery = ('SELECT * FROM %s'):format(Settings[Settings.Framework].characterTable); 
    local result = MySQL.Sync.fetchAll(sqlQuery, {});

    if not results then 
        print(('^1[ERROR]^7 %s'):format(sqlQuery));
        return; 
    end

    return result;
end

function getSpecificCharacter(source)
    local identifier = {}; 

    if Settings.Framework == 'ESX' or 'Revoked' then 
        local player = ESX.GetPlayerFromId(source); 

        identifier = Settings.Framework == 'ESX' and player.identifier or player.character.id; 
    end

    print(Settings[Settings.Framework].characterTable)

    local sqlQuery = ('SELECT * FROM %s WHERE %s = @identifier'):format(Settings[Settings.Framework].characterTable, Settings[Settings.Framework].characterId); 

    local result = MySQL.Sync.fetchAll(sqlQuery, {
        ['@identifier'] = identifier
    });

    if not result then 
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
        player = ESX.GetPlayerFromId(source); 
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

function hasMoney(amount)
    local player = ESX.GetPlayerFromId(source);

    if not player then return end;

    if player.getMoney() >= amount then 
        player.removeMoney(amount)

        return true; 
    end

    return false; 
end

function formatDate(date)
    local year, month, day = date:match('(%d+)-(%d+)-(%d+)');

    return day .. '/' .. month .. '/' .. year;
end