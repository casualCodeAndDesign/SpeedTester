function love.load()
	math.randomseed(os.time())
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	points = 0
	love.window.setTitle("SpeedTester")
	
	--Pelin kuvat
	background = love.graphics.newImage("speed_test_bg.png")
	startGame = love.graphics.newImage("start_game.png")
	soundOn = love.graphics.newImage("sound_on.png")
	soundOff = love.graphics.newImage("sound_off.png")
	greenOn = love.graphics.newImage("green_on.png")
	blueOn = love.graphics.newImage("blue_on.png")
	yellowOn = love.graphics.newImage("yellow_on.png")
	redOn = love.graphics.newImage("red_on.png")
	
	--Pelin äänet
	blue_sound = love.audio.newSource("blue.wav", "static")
	green_sound = love.audio.newSource("green.wav", "static")
	yellow_sound = love.audio.newSource("yellow.wav", "static")
	red_sound = love.audio.newSource("red.wav", "static")
	start_sound = love.audio.newSource("go.wav", "static")
	gameOver_sound = love.audio.newSource("game_over.wav", "static")
	
	
	--img_x = 80
	--img_y = 80
	
	game_status = false
	sound = true
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
	love.graphics.draw(startGame, 45, 71) --45, 630
	love.graphics.draw(change_soundMode(), 645, 57)
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

function change_soundMode()
	if sound then
		return soundOn
	else
		return soundOff
	end
end

function game_step()
	print("Askellus")
end

function love.quit()
	print("Peli suljettu")
end