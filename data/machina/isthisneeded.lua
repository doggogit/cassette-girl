function onStartCountdown() -- i dont know i dont like using camFollowPos since it doesnt exist in 0.7b | i need to figure out something better
    if isStoryMode then
        setProperty('camFollowPos.x', getMidpointX('dad') + 200)

        setProperty('camFollowPos.y', getMidpointY('dad') - 100)
        setProperty('camFollowPos.y', getProperty('camFollowPos.y') + getProperty('dad.cameraPosition[1]')) 
        
        setProperty('skipCountdown', true)
    end
end