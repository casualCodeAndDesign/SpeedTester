function love.load()
	math.randomseed(os.time())

	
	points = 0
	love.window.setTitle("SpeedTester")
	background = love.graphics.newImage("speed_test_bg.png")
	startGame = love.graphics.newImage("start_game.png")
	soundOn = love.graphics.newImage("sound_on.png")
	soundOff = love.graphics.newImage("sound_off.png")
	greenOn = love.graphics.newImage("green_on.png")
	blueOn = love.graphics.newImage("blue_on.png")
	yellowOn = love.graphics.newImage("yellow_on.png")
	redOn = love.graphics.newImage("red_on.png")
	
	game_status = false
	print("Ikkunan koko " .. love.graphics.getWidth() ..
		" x " .. love.graphics.getHeight())

	-- pelin sisäinen aikalaskuri
	game_time = 0
	-- kutsutaan game_step() funktiota kerran sekunnissa
	game_step_time = 1.0
	print("Peli alustettu")
end

function love.update(deltaTime)
	game_time = game_time + deltaTime
	if game_time >= game_step_time then
		game_time = game_time - game_step_time
		game_step()	
	end
end


function love.draw()
	--for k,v in pairs(bubbles) do
		--love.graphics.circle("fill", v.x, v.y, v.radius)
	--end
	--love.graphics.print("Points: " .. points, 400, 575)
	love.graphics.setColor(255, 255, 255)	
	love.graphics.draw(background, 0 , 0)
	
	draw_button()
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

function draw_button()

end

function game_step()
	print("Askellus")
end

function love.quit()
	print("Peli suljettu")
end