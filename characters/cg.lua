function onCreatePost()
    if songName == 'City Funk' then
        for i = 0, getProperty('unspawnNotes.length') - 1 do
            if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'animSuffix', '-alt')
            end
        end

        triggerEvent('Alt Idle Animation', 'dad', '-alt')
        playAnim('dad', 'idle-alt', true)
    end
end
