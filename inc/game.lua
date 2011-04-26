game = {state = 'menu', oldState = 'menu', gamePaused = false}
backgrounds = {}
map = {}


---------------------------------------------------------------------------------------------------------
------------------------------------------Game Functions-----------------------------------------------
---------------------------------------------------------------------------------------------------------

function game:run() --calls the game state 

	if keyboard.newPress["p"] then 
		game.gamePaused = not game.gamePaused 
		if game.gamePaused then love.audio.pause() else love.audio.resume() game.state = game.oldState end
	end

		if game.gamePaused then
			if  not (game.state == 'paused') then
				game.oldState = game.state
				game.state = 'paused'
			end
		end
	game[game.state]()
end

function game:running() --is run when the game is `running`
	TEsound.cleanup()
	game:draw()

end


function game:draw()
	game:backgrounds()
	entity:draw()
	player:draw()
	if hud then hud:draw() end
	if not game.gamePaused then
		--sounds.bgMusic:play()
		--sounds.bgMusic:setLooping(true)
		game:update()
	else
		--sounds.bgMusic:pause()	
	end
end

function game:menu()
	cam = nil
	--sounds.menuMusic:play()
	advPrint('SPACE MINER', 65, 10, {255,255,255}, fonts.menuTitleFont)
	
	advPrint(' - Press [I] for this instructions screen.', 50, 150, {255,255,255}, fonts.menuFont)
	
	advPrint(' - Press [ENTER]/[RETURN] to start the game.', 50, 200, {255,255,255}, fonts.menuFont)
	
	advPrint(' - Press [P] to Pause/Unpause the game.', 50, 250, {255,255,255}, fonts.menuFont)
	advPrint(' - Press [A]/[S]/[D]/[W] or [UP]/[DOWN]/[RIGHT]/[LEFT] to move.', 50, 300, {255,255,255}, fonts.menuFont)
	advPrint(' - Press [SPACEBAR] to shoot', 50, 350, {255,255,255}, fonts.menuFont)
	advPrint(' - Hover over named planets (shops) and press requested purchase', 50, 400, {255,255,255}, fonts.menuFont)
end

function game:instructions()
	advPrint('INSTRUCTIONS', 45, 10, {255,255,255}, fonts.menuTitleFont)
end

function game:update()
	entity:update()
	if cam then cam:setPos(vector(player.x,player.y)) end
	player:update()
end

function game:backgrounds()
	for i,v in ipairs(backgrounds)  do
		love.graphics.draw(v.img, v.img:getWidth()/2, v.img:getHeight()/2,0,1,1,v.img:getWidth()/2, v.img:getHeight()/2) --middleCenter
		love.graphics.draw(v.img, v.img:getWidth(), -v.img:getHeight()/2,0,1,1,v.img:getWidth(), v.img:getHeight()/2) --middleTop
		love.graphics.draw(v.img, v.img:getWidth(), v.img:getHeight()/2+v.img:getHeight(),0,1,1,v.img:getWidth(), v.img:getHeight()/2) --middleBottom

		love.graphics.draw(v.img, -v.img:getWidth()/2, v.img:getHeight()/2,0,1,1,v.img:getWidth()/2, v.img:getHeight()/2) --leftMiddle
		love.graphics.draw(v.img, -v.img:getWidth()/2, -v.img:getHeight()/2,0,1,1,v.img:getWidth()/2, v.img:getHeight()/2) --leftTop
		love.graphics.draw(v.img, -v.img:getWidth()/2, v.img:getHeight()+v.img:getHeight()/2,0,1,1,v.img:getWidth()/2, v.img:getHeight()/2) --leftBottom
	

		love.graphics.draw(v.img, v.img:getWidth()+v.img:getWidth()/2, v.img:getHeight()/2,0,1,1,v.img:getWidth()/2, v.img:getHeight()/2) --rightMiddle
		love.graphics.draw(v.img, v.img:getWidth()+v.img:getWidth()/2, -v.img:getHeight()/2,0,1,1,v.img:getWidth()/2, v.img:getHeight()/2) --rightTop
		love.graphics.draw(v.img, v.img:getWidth()+v.img:getWidth()/2, v.img:getHeight()+v.img:getHeight()/2,0,1,1,v.img:getWidth()/2, v.img:getHeight()/2) --rightBottom	
	end
end

function game:newGame() --called when you start a NEW game
	entities = {}

	game:buildMap()

	game.state = 'running'
	game.oldState = 'running'
	cam = Camera(vector(love.graphics.getWidth()/2, love.graphics.getHeight()/2))
	player.load()
end

function game:paused()
	local x,y = cam:toWorldCoords(vector(((love.graphics.getWidth()/2)), (love.graphics.getHeight()/2))):unpack()

	game:running()
	advPrint('------[PAUSED]-----', x-460, y-135, {255,255,255}, fonts.pauseFont)
	advPrint('(Press [P] to unpause)', x-55, y-15)
end

function game:buildMap()
		math.randomseed(os.time()+love.timer.getTime())
	
	for val = 1, 100 do
		mapValX = 8000
		mapValY = 8000
		x = math.random(-mapValX,mapValX)
		y = math.random(-mapValX,mapValX)
		i = math.random(1,4)
		local temp = deepcopy(baseEntities['planet'..tostring(i)])
		temp.x = x
		temp.y = y
		table.insert(entities, temp)
	end

		x = math.random(-250,100)
		y = math.random(-100,250)	

		local temp = deepcopy(baseEntities['planet'..tostring(1)])
		temp.x = x
		temp.y = y
		table.insert(entities, temp)
	

		x = math.random(-100,250)
		y = math.random(-250,100)	

		local temp = deepcopy(baseEntities['planet'..tostring(2)])
		temp.x = x
		temp.y = y
		table.insert(entities, temp)


		x = math.random(-322,122)
		y = math.random(-123,111)	

		local temp = deepcopy(baseEntities['planet'..tostring(3)])
		temp.x = x
		temp.y = y
		table.insert(entities, temp)		
	
	
	for val = 1, 750 do
		x = math.random(-mapValX,mapValX)
		y = math.random(-mapValX,mapValX)
		i = math.random(1,4)
		local temp = deepcopy(baseEntities['asteroid'])
		temp.x = x
		temp.y = y
		temp.rot = math.random(1,360)
		--print('New Asteroid || x: '..x..' - y: '..y)
		table.insert(entities, temp)
	end	
	
	table.insert(backgrounds,{img = images.background})
	
end

function game:gameOver()
	local x,y = cam:toWorldCoords(vector(((love.graphics.getWidth()/2)), (love.graphics.getHeight()))):unpack()
		

	cam:setZoom(2)
	sounds.death:rewind()

	game:backgrounds()
	
	player:draw()

	advPrint('Game Over', x-135, y -275,{255,0,0}, fonts.gameOverFont)
	advPrint('You\'re Dead in the water! - [RIP] Jonny Miner', x-135, y -100)
	advPrint('Press [ENTER]/[RETURN] to start a new game', x-135, y -50)
end












