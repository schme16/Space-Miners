require('inc/entities')
require('inc/media')
---------------------------------------------------------------------------------------------------------
------------------------------------------Player Functions-----------------------------------------------
---------------------------------------------------------------------------------------------------------

bullets = {}
player = {}

function player.load()


	player.facing = 'left'
	player.x = love.graphics.getWidth()/2
	player.y = love.graphics.getHeight()/2
	player.rot = 0
	player.speed = 140
	player.score = 0
	player.credits = 1000
	player.colMap = collision:newCollisionMap('img/ship.png')
	player.image = images.ship
	player.flames = love.graphics.newParticleSystem( love.graphics.newImage('img/particles.png'), 60 )
	player.isMoving = false
	
	player.currentWeapon = 'basicPhaser'
	player.engine = 'thermalEngine'
	player.fuelTank = 'smallTank'
	
	player.fuel = products['smallTank'].fuel	
		
			bulletX1 = 387
			bulletY1 = 270
 			
			bulletX2 = 410 
			bulletY2 = 270
			
			bulletYMult = -2
			bulletXMult = 0
			
   player.flames:setBufferSize( 100 )
   player.flames:setEmissionRate( 100 )
   player.flames:setLifetime( -1 )
   player.flames:setParticleLife( 0.2 )
   player.flames:setSize(1.5, 3, 1 )
   player.flames:setSpeed( 5, 10  )
   player.flames:setSpread( math.rad(player.rot) )

   


	
end
	
	
function player.weaponMechanics()

	local image = love.graphics.newImage('img/plasma.png')
	local x,y = 0
	local temp = {}
	local temp2 = {}
	for i,v in ipairs(bullets) do
		if v and v.x and v.y then
			v.x = v.x + (v.weaponSpeed*v.xMult)
			v.y = v.y + (v.weaponSpeed*v.yMult)
			x,y = cam:toWorldCoords(vector(v.x,v.y)):unpack()
			love.graphics.draw(images[v.image], x, y, math.rad(v.rot))
			
			if math.abs(player.x - x) > 800 then table.remove(bullets, i) end
			if math.abs(player.y - y) > 600 then table.remove(bullets, i) end
			
			
				temp.x = x
				temp.y = y
				temp.radius = 10

			for k,d in ipairs(entities) do
				temp2.x = d.x
				temp2.y = d.y
				temp2.radius = images[d.image]:getWidth()/2


				
				if d.destructable  and circleOverlap(temp, temp2) then
					d.health = d.health - v.power
					
					table.remove(bullets, i)
					if d.health <=0 then
						player.credits = player.credits + d.dropOre
						player.score = player.credits + d.dropOre
						table.remove(entities, k)
					end
				end
				
			end
		end
	
	end

end






function player:draw()
	love.graphics.draw(player.flames, flameX, flameY)
	love.graphics.draw(self.image, player.x, player.y, math.rad(player.rot), 1, 1, self.image:getWidth()/2, self.image:getHeight()/2) 
end

function player:doRotation()
	player.isMoving = false
	local rA = 1
	
	if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
			player.rot = 270
			flameX = 35
			flameY = 0 
			
			
			
			bulletX1 = 370
			bulletY1 = 290
 			
			bulletX2 = 370 
			bulletY2 = 312
			
			bulletYMult = 0
			bulletXMult = -2
			
			
			
			player.isMoving = true			
	end	
	
	if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
			player.rot = 90
			
			flameX = -35
			flameY = 0
			
			bulletX1 = 430
			bulletY1 = 285
 			
			bulletX2 = 430 
			bulletY2 = 310
			
			bulletYMult = 0
			bulletXMult = 2

			player.isMoving = true
	end	
	
	if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
		if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
			player.rot = 45
			flameX = -25
			flameY = 25
			
			
			bulletX1 = 410
			bulletY1 = 270
 			
			bulletX2 = 430 
			bulletY2 = 280
			
						
			
			bulletYMult = -2
			bulletXMult = 2
		elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
		
			flameX = 25
			flameY = 25
			player.rot = 315
			
			bulletX1 = 370
			bulletY1 = 290
 			
			bulletX2 = 390 
			bulletY2 = 270
			
			bulletYMult = -2
			bulletXMult = -2			
		else
			flameX = 0
			flameY = 35
			player.rot = 0

			
			bulletX1 = 387
			bulletY1 = 270
 			
			bulletX2 = 410 
			bulletY2 = 270
			
			bulletYMult = -2
			bulletXMult = 0
			
		end
		player.isMoving = true
	end	
	
	if love.keyboard.isDown('down') or love.keyboard.isDown('s') then
		if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
			player.rot = 135
			flameX = -25
			flameY = -25
			
			bulletX1 = 430
			bulletY1 = 315
 			
			bulletX2 = 415 
			bulletY2 = 330
			
						
			bulletYMult = 2
			bulletXMult = 2			
			
			
		elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
			flameX = 25
			flameY = -25
			player.rot = 225

			
			bulletX1 = 380
			bulletY1 = 315
 			
			bulletX2 = 390 
			bulletY2 = 330
			
			
			
			bulletYMult = 2
			bulletXMult = -2			
		else
			player.rot = 180
			flameX = 0
			flameY = -35
			
			bulletX1 = 410
			bulletY1 = 330
 			
			bulletX2 = 390 
			bulletY2 = 330
			
			bulletYMult = 2	
			bulletXMult = 0
			
		end
		player.isMoving = true
	end	



	
end

function player:update()
	player.flames:setDirection(math.rad(player.rot))
	player.flames:setPosition( player.x, player.y )	
	player.flames:update( love.timer.getDelta() )

		
	
		
	if not player.isMoving then
		player.flames:stop()
	else
		player.flames:start()
	end
	
	player.weaponMechanics()
	
	
	if player.fuel > 0 then
		if love.keyboard.isDown( 'up') or love.keyboard.isDown( 'w')  then
			player.y = player.y - products[player.engine].speed
		end

		if love.keyboard.isDown( 'down') or love.keyboard.isDown( 's')  then
			player.y = player.y + products[player.engine].speed
			
		end

		if love.keyboard.isDown( 'left') or love.keyboard.isDown( 'a')  then
			player.x = player.x - products[player.engine].speed
		
		end

		if love.keyboard.isDown( 'right') or love.keyboard.isDown( 'd') then
			player.x = player.x + products[player.engine].speed
					
		end
		if not love.keyboard.isDown( 'right')   and not love.keyboard.isDown( 'd') and not love.keyboard.isDown( 'left') and  not love.keyboard.isDown( 'a') and not love.keyboard.isDown( 'up') and not love.keyboard.isDown( 'w') and not love.keyboard.isDown( 'down') and not love.keyboard.isDown( 's') then
			TEsound.pause('engine')
		else
			player.fuel = player.fuel - products[player.engine].speed/8	
			TEsound.resume('engine')
		end
		if keyboard.newPress['space'] then print('Pew!') player:shoot() player.fuel = player.fuel - weapons[player.currentWeapon].fuelUsage  end
	else
		love.audio.stop()
		sounds.death:play()
		love.audio.stop()
		player.flames:stop()
		player.flames:reset()
		game.state = 'gameOver'
	end
	


	player:doRotation()
end

function player:shoot()   

	local temp = deepcopy(weapons[player.currentWeapon])
		temp.x = bulletX1
		temp.y = bulletY1
		temp.rot = player.rot
		temp.xMult = bulletXMult
		temp.yMult = bulletYMult
		
	table.insert(bullets, temp)
	

	temp = deepcopy(weapons[player.currentWeapon])
		temp.x = bulletX2
		temp.y = bulletY2
		temp.rot = player.rot
		temp.xMult = bulletXMult
		temp.yMult = bulletYMult		
	table.insert(bullets, temp)	
	

end









