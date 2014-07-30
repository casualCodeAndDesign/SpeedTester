function love.load()
	math.randomseed(os.time())
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	points = 0
	max_levels = 9
	current_level = 1
	missed = 0
	player_did_miss = false
	
	love.window.setTitle("SpeedTester")
	
	--pelin fontti
	font = love.graphics.newFont("Let's go Digital Regular.ttf", 44)
	love.graphics.setFont(font)
	
	--Pelin kuvat
	background = love.graphics.newImage("speed_test_bg.png")
	startGame = love.graphics.newImage("start_game.png")
	soundOn = love.graphics.newImage("sound_on.png")
	soundOff = love.graphics.newImage("sound_off.png")
	greenOn = love.graphics.newImage("green_on.png")
	blueOn = love.graphics.newImage("blue_on.png")
	yellowOn = love.graphics.newImage("yellow_on.png")
	redOn = love.graphics.newImage("red_on.png")
	settings = love.graphics.newImage("settings.png")
	
	--Pelin äänet
	blue_sound = love.audio.newSource("blue.wav", "static")
	green_sound = love.audio.newSource("green.wav", "static")
	yellow_sound = love.audio.newSource("yellow.wav", "static")
	red_sound = love.audio.newSource("red.wav", "static")
	start_sound = love.audio.newSource("go.wav", "static")
	gameOver_sound = love.audio.newSource("game_over.wav", "static")
	levelUp_sound = love.audio.newSource("level_up.wav", "static")
	
	
	--img_x = 80
	--img_y = 80
	
	game_is_started = false
	sound_is_on = true
	sound_icon = soundOn
	
	print("Ikkunan koko " .. love.graphics.getWidth() ..
		" x " .. love.graphics.getHeight())

	-- pelin sisäinen aikalaskuri
	game_time = 0
	-- kutsutaan game_step() funktiota kerran sekunnissa
	game_step_time = 2.0
	print("Peli alustettu")
end

function love.update(deltaTime)
	game_time = game_time + deltaTime
	if game_time >= game_step_time then
		game_time = game_time - game_step_time
		game_step()
	--elseif player_did_miss == false then
		--game_step()
	end
end


function love.draw()
	--for k,v in pairs(bubbles) do
		--love.graphics.circle("fill", v.x, v.y, v.radius)
	--end
	--love.graphics.print("Points: " .. points, 400, 575)
	love.graphics.setColor(255, 255, 255)	
	love.graphics.draw(background, 0 , 0)

	if game_is_started == false then
		love.graphics.draw(startGame, 45, 75) --45, 630
	end
	
	if  game_is_started then
		level_info()
		draw_button()
	end
	
	love.graphics.draw(sound_icon, 635, 75)
	love.graphics. draw(settings, 703, 75)

	love.graphics.setColor(255, 2 , 9)
	love.graphics.print(points, 220, 295) --nykyiset pisteet
	love.graphics.print("0", 588, 295) --piste ennätys
	
end

function love.mousepressed(x, y, button)
	local player_hit_start = { x = 45, y = 71, width = 152, height = 40 } 
	local setting_buttons = {}
	local sound = { x = 635, y = 75, width = 48, height = 48 }
	local display_settings = { x = 703, y = 75, width = 48, height = 48 }
	
	if button == "l" then
		if x > player_hit_start.x and y > player_hit_start.y and x < player_hit_start.x + player_hit_start.width and y < player_hit_start.y + player_hit_start.height then
			print("Painettu start game")
			game_start()
		elseif x > sound.x and y > sound.y and x < sound.x + sound.width and y < sound.y + sound.height then
				print("Painettu sound buttonia")
				change_soundMode()
		elseif x > display_settings.x and y > display_settings.y and x < display_settings.x + display_settings.width and y < display_settings.y + display_settings.height then
			print("Painettu settings buttonia")
		else
			print("Painettu kohdassa " .. x .. " " .. y)
		end	
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
	
	button_color = color_index
	
	if button_color == 1 then --green
		love.graphics.draw(greenOn, 27, 422)
	elseif button_color == 2 then --blue
		love.graphics.draw(blueOn, 231, 422)
	elseif button_color == 3 then --yellow 
		love.graphics.draw(yellowOn, 435, 422)
	else
		love.graphics.draw(redOn, 639, 422)
	end
end

function change_soundMode()
	if sound_is_on == true then
		sound_is_on = false
		sound_icon = soundOff
		print("Sound is off")
	else
		sound_is_on = true
		sound_icon = soundOn
		print("Sound is on")
	end
end

function game_start()
	if sound_is_on == true then
		love.audio.play(start_sound)
	end
	game_is_started = true
	
end

function level_info()
	local display_level = {  }
	love.graphics.setColor(218, 209, 59)
	local level_x = 189
	local level_y = 190
	local level_radius = 20
	
	
	for i = 1, current_level do
		local l = display_level[i]
		display_level[i] = love.graphics.circle("fill", level_x, level_y, level_radius)
		level_x = level_x + 50
	end
	--love.graphics.circle("fill", 189, 190, 20)
end

function game_step()
	print("Askellus")
	previous_index = 0
	
	color_index = math.random(1,4)
	
	if game_is_started then
		if sound_is_on == true then
			if color_index == 1 then
				love.audio.play(green_sound)
			elseif color_index  == 2 then
				love.audio.play(blue_sound)		
			elseif color_index == 3 then
				love.audio.play(yellow_sound)	
			else
				love.audio.play(red_sound)
			end
		end
	end
	
	if player_did_miss then
		if missed < 3 then
			missed = missed + 1
		else
			game_over()
		end
	end
end

function love.keypressed(key)
	
	if color_index == 1 and key == "a" then
		print("Painettu " .. key .. "osui")
		player_did_miss = false
		points = points + 1
		game_step()
	elseif color_index == 2 and key == "s" then
		print("Painettu " .. key .. "osui")		
		player_did_miss = false
		points = points + 1
		game_step()
	elseif color_index == 3 and key == "d" then
		print("Painettu " .. key .. "osui")
		player_did_miss = false
		points = points + 1
		game_step()
	elseif color_index == 4 and key == "f" then
		print("Painettu " .. key .. "osui")
		player_did_miss = false
		points = points + 1
		game_step()
	else
		player_did_miss = true
	end
end

function game_over()
	print("game over")
end

function love.quit()
	print("Peli suljettu")
end