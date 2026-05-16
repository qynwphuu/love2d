---@diagnostic disable: undefined-global
---@meta
local love = _G.love

local player = {
	x = 400,
	y = 200,
	speed = 1,
	sprite = love.graphics.newImage("sprites/character_green_idle.png"),
}

local background = love.graphics.newImage("sprites/background.png")

function love.load() end

function love.update(dt)
	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed
	end

	if love.keyboard.isDown("left") then
		player.x = player.x - player.speed
	end

	if love.keyboard.isDown("down") then
		player.y = player.y + player.speed
	end

	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed
	end
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	love.graphics.draw(player.sprite, player.x, player.y)
end
