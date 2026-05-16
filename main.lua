---@diagnostic disable: undefined-global
---@meta
local love = _G.love

local player = {
	x = 400,
	y = 200,
	speed = 1.2,

	sprite = nil,
	spriteSheet = nil,
	grid = nil,
	animations = {},
}

local background = nil

function love.load()
	anim8 = require("libraries/anim8")
	love.graphics.setDefaultFilter("nearest", "nearest")

	background = love.graphics.newImage("sprites/background.png")
	player.sprite = love.graphics.newImage("sprites/smaller-char-sprites/character_green_idle.png")
	player.spriteSheet = love.graphics.newImage("sprites/spritesheet.png")

	player.grid = anim8.newGrid(128, 128, 1152, 128)
	player.animations.walk = anim8.newAnimation(player.grid("2-3", 1), 0.2)
end

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

	player.animations.walk:update(dt)
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	player.animations.walk:draw(player.spriteSheet, player.x, player.y)
end
