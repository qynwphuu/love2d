---@diagnostic disable: undefined-global, undefined-variable
---@meta
local love = _G.love

local player = {
	x = 103,
	y = 50,
	speed = 100,

	sprite = nil,
	spriteSheet = nil,
	grid = nil,
	animations = {},

	collider = nil,
}

local background = nil

function love.load()
	-- Load libraries
	wf = require("libraries/windfield")
	world = wf.newWorld(0, 0)

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

	player.collider = world:newBSGRectangleCollider(103, 50, 11, 13, 2)
	player.collider:setFixedRotation(true)

	-- Load walls collision
	local function createWallFromTiles(xStart, yStart, xEnd, yEnd)
		local x = xStart * 16
		local y = yStart * 16

		local width = (xEnd - xStart + 1) * 16
		local height = (yEnd - yStart + 1) * 16

		local wall = world:newRectangleCollider(x, y, width, height)
		wall:setType("static")
	end

	walls = {}
	if gameMap.layers["Walls"] then
		for i, obj in pairs(gameMap.layers["Walls"].objects) do
			if obj.polygon then
				local vertices = {}
				for _, point in ipairs(obj.polygon) do
					-- Calculate the absolute position of each vertex
					table.insert(vertices, obj.x + (point.x - obj.polygon[1].x))
					table.insert(vertices, obj.y + (point.y - obj.polygon[1].y))
				end

				-- Create collider polygon
				local w = world:newPolygonCollider(vertices)
				w:setType("static")
				table.insert(walls, w)

			-- Create rectangle colliders
			elseif obj.width > 0 and obj.height > 0 then
				local w = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
				w:setType("static")
				table.insert(walls, w)
			end
		end
	end
	cam:zoom(4)
end

function love.update(dt)
	-- MOVEMENTS
	local isMoving = false
	local vx = 0
	local vy = 0
	if love.keyboard.isDown("right") then
		vx = player.speed
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("left") then
		vx = player.speed * -1
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
		isMoving = false
	end

	if love.keyboard.isDown("down") then
		vy = player.speed
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("up") then
		vy = player.speed * -1
		player.anim = player.animations.walk
		isMoving = true
	end

	if love.keyboard.isDown("down") and love.keyboard.isDown("up") then
		isMoving = false
	end

	if isMoving == false then
		player.anim = player.animations.idle
	end

	player.collider:setLinearVelocity(vx, vy)

	world:update(dt)

	player.anim:update(dt)
	gameMap:update(dt)

	cam:lookAt(player.x, player.y)

	player.x = player.collider:getX()
	player.y = player.collider:getY()

	-- CAMERA
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

	if player.y < 128 then
		player.anim:draw(player.spriteSheet, player.x, player.y - 2.8, 0, 0.18, 0.18, 64, 64)
		gameMap:drawLayer(gameMap.layers["Trees"])
		gameMap:drawLayer(gameMap.layers["Fences"])
		gameMap:drawLayer(gameMap.layers["House"])
	else
		gameMap:drawLayer(gameMap.layers["House"])
		player.anim:draw(player.spriteSheet, player.x, player.y - 2.8, 0, 0.18, 0.18, 64, 64)
		gameMap:drawLayer(gameMap.layers["Trees"])
		gameMap:drawLayer(gameMap.layers["Fences"])
	end

	-- world:draw()
	cam:detach()

	love.graphics.print("Hello!", 10, 10)
end
