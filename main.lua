function love.load()
	t = 0

	math.randomseed(os.time())
	
	points = 0
	love.window.setTitle("SpeedTester")
	background = love.graphics.newImage("speed_test_bg.png")
	startGame = love.graphics.newImage("start_game.png")
	soundOn = love.graphics.newImage("sound_on.png")
	soundOff = love.graphics.newImage("sound_off.png")
	
	print("Peli alustettu")
end

function love.update(dt)
	t = t + dt
end

function love.draw()
	--for k,v in pairs(bubbles) do
		--love.graphics.circle("fill", v.x, v.y, v.radius)
	--end
	--love.graphics.print("Points: " .. points, 400, 575)
	love.graphics.setColor(255, 255, 255)	
	love.graphics.draw(background, 0 , 0)
end

function love.mousepressed(x, y, button)
	if button == "l" then
		print("Painettu kohdassa " .. x .. " " .. y)
	end
	return x,y
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	else
		print("Painettu " .. key)
	end
end

function love.quit()
	print("Peli suljettu")
end