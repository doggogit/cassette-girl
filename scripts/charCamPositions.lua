function onMoveCamera(char)
    if char == 'dad' then 
        setProperty('camFollow.x', getMidpointX('dad') + 200)
        setProperty('camFollow.y', getMidpointY('dad') - 100)

        setProperty('camFollow.y', getProperty('camFollow.y') + getProperty('dad.cameraPosition[1]'))
    else
        setProperty('camFollow.x', getMidpointX('boyfriend') - 100)
        setProperty('camFollow.y', getMidpointY('boyfriend') - 230)

        setProperty('camFollow.x', getProperty('camFollow.x') - getProperty('boyfriend.cameraPosition[0]'))
        setProperty('camFollow.y', getProperty('camFollow.y') + getProperty('boyfriend.cameraPosition[1]'))
    end
end