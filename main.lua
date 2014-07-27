function love.load()
	t = 0
	max_bubbles = 10
	max_size = 35
	
	bubble_grow = 7
	math.randomseed(os.time())
	
	points = 0
	
	bubbles = {}
	for i = 1, max_bubbles do
		bubbles[i] = bubble_reset(5 * i)
	end		
	print("Peli alustettu")
end

function love.update(dt)
	t = t + dt
	for i = 1, max_bubbles do
		bubbles[i].radius = bubbles[i].radius + bubble_grow * dt
		if bubbles[i].radius > max_size then
			bubbles[i] = bubble_reset(0)
		end
	end
end

function love.draw()
	for k,v in pairs(bubbles) do
		love.graphics.circle("fill", v.x, v.y, v.radius)
	end
	love.graphics.print("Points: " .. points, 400, 575)
end

function love.mousepressed(x, y, button)
	if button == "l" then
		print("Painettu kohdassa " .. x .. " " .. y)
		local hit = bubble_isInside(x,y)
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