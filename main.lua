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
	-- Load libraries
	anim8 = require("libraries/anim8")
	love.graphics.setDefaultFilter("nearest", "nearest")

	-- Load images
	background = love.graphics.newImage("sprites/background.png")
	player.sprite = love.graphics.newImage("sprites/smaller-char-sprites/character_green_idle.png")
	player.spriteSheet = love.graphics.newImage("sprites/spritesheet.png")

	-- Load animations
	player.grid = anim8.newGrid(128, 128, 1152, 128)
	player.animations.walk = anim8.newAnimation(player.grid("2-3", 1), 0.2)
	player.animations.idle = anim8.newAnimation(player.grid(1, 1), 0.2)

	player.anim = player.animations.walk
end

function love.update(dt)
	local isMoving = false

	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("left") then
		player.x = player.x - player.speed
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
		isMoving = false
	end

	if love.keyboard.isDown("down") then
		player.y = player.y + player.speed
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("down") and love.keyboard.isDown("up") then
		isMoving = false
	end

	if isMoving == false then
		player.anim = player.animations.idle
	end
	player.anim:update(dt)
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	player.anim:draw(player.spriteSheet, player.x, player.y)
end
