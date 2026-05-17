---@diagnostic disable: undefined-global, undefined-variable
---@meta
local love = _G.love

local player = {
	x = 103,
	y = 50,
	speed = 0.3,

	sprite = nil,
	spriteSheet = nil,
	grid = nil,
	animations = {},
}

local background = nil

function love.load()
	-- Load libraries
	camera = require("libraries/camera")
	cam = camera()
	anim8 = require("libraries/anim8")

	sti = require("libraries/sti")
	gameMap = sti("maps/testmap.lua")

	-- Load images
	background = love.graphics.newImage("sprites/background.png")
	player.sprite = love.graphics.newImage("sprites/smaller-char-sprites/character_green_idle.png")
	player.spriteSheet = love.graphics.newImage("sprites/spritesheet.png")

	-- Load animations
	player.grid = anim8.newGrid(128, 128, 1152, 128)
	player.animations.walk = anim8.newAnimation(player.grid("2-3", 1), 0.2)
	player.animations.idle = anim8.newAnimation(player.grid(1, 1), 0.2)

	player.anim = player.animations.walk

	cam:zoom(4)
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
	gameMap:update(dt)

	cam:lookAt(player.x, player.y)

	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()

	local mapW = gameMap.width * gameMap.tilewidth
	local mapH = gameMap.height * gameMap.tileheight

	-- Hide left border
	if cam.x < (w / 2) / 4 then
		cam.x = (w / 2) / 4
	end

	-- Hide upper border
	if cam.y < (h / 2) / 4 then
		cam.y = (h / 2) / 4
	end

	-- Hide right border
	if cam.x > mapW - (w / 2) / 4 then
		cam.x = mapW - (w / 2) / 4
	end

	-- Hide bottom border
	if cam.y > mapH - (h / 2) / 4 then
		cam.y = mapH - (h / 2) / 4
	end
end

function love.draw()
	cam:attach()
	gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
	gameMap:drawLayer(gameMap.layers["Trees"])
	gameMap:drawLayer(gameMap.layers["Fences"])
	gameMap:drawLayer(gameMap.layers["House"])

	player.anim:draw(player.spriteSheet, player.x, player.y, 0, 0.18, 0.18, 64, 64)
	cam:detach()
	love.graphics.print("Hello!", 10, 10)
end
