function onMoveCamera(char)
    if char == 'dad' then 
        runHaxeCode([[
            game.camFollow.set(game.dad.getMidpoint().x + 150, game.dad.getMidpoint().y - 100);
            game.camFollow.x += game.dad.cameraPosition[0];
            game.camFollow.y += game.dad.cameraPosition[1];
            game.camFollow.x = game.dad.getMidpoint().x + 200;
        ]])
    else
        runHaxeCode([[
            game.camFollow.set(game.boyfriend.getMidpoint().x - 100, game.boyfriend.getMidpoint().y - 100);
            game.camFollow.y = game.boyfriend.getMidpoint().y - 230;

            game.camFollow.x -= game.boyfriend.cameraPosition[0];
            game.camFollow.y += game.boyfriend.cameraPosition[1];
        ]])
    end
end