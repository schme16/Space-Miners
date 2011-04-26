hud = {}

function hud:draw()
	hud:entityLife()
	hud:entityTitle()
	hud:shopMenu()
	hud:credits()
	hud:fuel()
end



function hud:credits()
	local x,y = cam:toWorldCoords(vector(((love.graphics.getWidth())), (10))):unpack()
	advPrint('Credits $ '..tostring(player.credits), x-220, y,{255,255,255})
end

function hud:fuel()
	local x,y = cam:toWorldCoords(vector(((love.graphics.getWidth())), (20))):unpack()
	percentage = 200 / products[player.fuelTank].fuel
	local r,g,b,a = love.graphics.getColor()
	love.graphics.setColor(255,255,0,255)
		love.graphics.rectangle('fill', x - 220, y+10, (percentage*player.fuel), 14)
	love.graphics.setColor(r,g,b,a)
	
	love.graphics.rectangle('line', x - 220, y+10, 200, 15)
end

function hud:entityLife()
	for i,v in ipairs(entities) do
	
		percentage = 50 / v.maxHealth
		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(180,255,0)
			love.graphics.rectangle('fill', v.x +images[v.image]:getWidth()/3, v.y+images[v.image]:getHeight() +10, (percentage*v.health), 4)
		love.graphics.setColor(200,200,200)
					love.graphics.rectangle('line', v.x +images[v.image]:getWidth()/3, v.y+images[v.image]:getHeight() +10, 50, 5)
		love.graphics.setColor(r,g,b,a)
	end
end

function hud:entityTitle()
	local temp = {}
	local temp2 = {x = player.x, y = player.y, radius = 5,}
	
	player.inStore = false
	
	for i,v in ipairs(entities) do

		if v.shopID then
			
			temp.x = v.x + (images[v.image]:getWidth()/2)
			temp.y = v.y + (images[v.image]:getHeight()/2)
			temp.radius = images[v.image]:getWidth()/2

		
			if circleOverlap(temp, temp2) then player.inStore = v.shopID     love.graphics.circle('line', temp2.x, temp2.y, temp2.radius)   love.graphics.circle('line', temp.x, temp.y, temp.radius)     end

			advPrint(shops[v.shopID].name, v.x +images[v.image]:getWidth()/4, v.y - 20)
		end
	end
end


function hud:shopMenu()
	if player.inStore then
		local x,y = cam:toWorldCoords(vector(0,0)):unpack()
		local extra = ''
		local selected = ''
		advPrint('[Shop Menu]', x+5, y+100, false, fonts.shopMenuTitleFont)
		for i,v in pairs(shops[player.inStore].products) do
			selected = ''
			if purchased[v] then extra = 'PURCHASED Press '..i..' to Select' else	 extra = 'Press '..i..' to Buy' end
			
			if player.currentWeapon == v  then itemType = 'currentWeapon' selected = ' - Selected' end
			if player.engine == v then itemType = 'engine' selected = ' - Selected' end
			if player.fuelTank == v then itemType = 'fuelTank' selected = ' - Selected' end
			
			advPrint('     ['..extra..'] - '..products[v].name..' - Price: $'..products[v].price..selected, x+5, y+120+(20*i))
			
			if keyboard.newPress[tostring(#shops[player.inStore].products+1)] and player.credits >= 3500 then
				player.fuel = products[player.fuelTank].fuel
				player.credits = player.credits - 3500
				
			end
			
			if keyboard.newPress[tostring(i)] then
				if not purchased[v] then
						
					if player.credits >= products[v].price then
						purchased[v] = true
						player[itemType] = v
						player.credits = player.credits - products[v].price
					end
				else
					player[itemType] = v
				end
			end
			
		end
		advPrint('     Press 4 to fill your tank - Price: $3500', x+5, y+120+(20*4))
	end
end


















