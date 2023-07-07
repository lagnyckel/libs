Settings = {
    Framework = 'ESX', -- ESX, Revoked, Standalone

    -- Standalone Settings
    Standalone = {
        characterTable = 'characters',
        characterId = 'identifier',
        jobGradeTable = 'job_grades',
        job_nameTable = 'job_name',
    }, 

    -- ESX Settings
    ESX = {
        characterTable = 'users',
        characterId = 'identifier',
        jobGradeTable = 'job_grades',
        job_nameTable = 'job_name',
    },

    -- Revoked Framework Settings
    Revoked = {
        characterTable = 'characters',
        characterId = 'id',
        jobGradeTable = 'job_grades',
        job_nameTable = 'job_name',
    },
}

exports('getSettings', function()
    return Settings 
end)