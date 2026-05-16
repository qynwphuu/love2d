function love.load()
	player = {}
	player.x = 400
	player.y = 200
end

function love.update(dt)
	if love.keyboard.isDown("right") then
		player.x = player.x + 1
	end

	if love.keyboard.isDown("left") then
		player.x = player.x - 1
	end
end

function love.draw()
	love.graphics.circle("fill", player.x, player.y, 100)
end
