Settings = {
    Framework = 'ESX', -- ESX, Revoked, Standalone; 

    -- Standalone Settings
    Standalone = {
        characterTable = 'characters',
        characterId = 'identifier',
    }, 

    -- ESX Settings
    ESX = {
        characterTable = 'users',
        characterId = 'identifier',
    },

    -- Revoked Framework Settings
    Revoked = {
        characterTable = 'characters',
        characterId = 'id',
    },
}

exports('getSettings', function()
    return Settings 
end)