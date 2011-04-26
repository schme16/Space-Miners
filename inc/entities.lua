if not images then require('inc/media') end
if not images then require('inc/supportFunctions') end

entity = {}

entities = {}



products = 
{
	--engines
	thermalEngine = {name = 'Thermal Engine', price = 1000, speed = 3},
	nuclearEngine = {name = 'Nuclear Engine', price = 50000, speed = 5},
	fusionEngine = {name = 'Fusion Engine', price = 180000, speed = 10},
	
	--Fuel Tanks 
	smallTank = {name = 'Small Tank', price = 1000, fuel = 5000,},
	mediumTank = {name = 'Medium Tank', price = 50000, fuel = 15000,},
	largeTank = {name = 'Large Tank', price = 180000, fuel = 50000,},
	
	--Weapons
	basicPhaser = {name = 'Basic Phaser', price = 1000},
	defenceLaser = {name = 'Defence Laser', price = 50000},
	militaryBlaster = {name = 'Military Blaster', price = 180000}	
}

shops = 
{
	weapons = {name = 'Weapons Systems Shop', products = {'basicPhaser', 'defenceLaser', 'militaryBlaster'}},
	fuel = {name = 'Fuel Systems Store', products = {'smallTank', 'mediumTank', 'largeTank'}},
	propulsion = {name = 'Propulsion Systems Store', products = {'thermalEngine', 'nuclearEngine', 'fusionEngine'}},
}





purchased = {thermalEngine = true, smallTank = true, basicPhaser = true,}



baseEntities =
{
	planet1 = {dockable = true, destructable = true, health = 400, maxHealth = 400, dropOre = 50000,  x =0, y = 0, shopID = 'weapons', colour = {255,0,0,255}, image = 'planet', colMap = 'planet', rot = 0, rotInc =0  },
	planet2 = {dockable = true, destructable = true, health = 400, maxHealth = 400, dropOre = 50000,  x =0, y = 0,  shopID = 'fuel',  colour = {0,255,0,255}, image = 'planet', colMap = 'planet', rot = 0, rotInc =0  },
	planet3 = {dockable = false, destructable = true, health = 400,  maxHealth = 400, dropOre = 50000, x =0, y = 0,  shopID = 'propulsion',  colour = {0,0,255,255}, image = 'planet', colMap ='planet', rot = 0, rotInc =0  },
	planet4 = {dockable = false, destructable = true, health = 400, maxHealth = 400, dropOre = 50000,  x =0, y = 0, name = '', shopID = false,  colour = {123,223,221,255}, image = 'planet', colMap = 'planet', rot= 0, rotInc =0  },

	asteroid = {dockable = false, destructable = true, health = 75, maxHealth = 75, dropOre = 8000, x =0, y = 0, name = 'Asteroid', shopID = false,  colour = {255,255,255,255}, image = 'asteroid', colMap = 'asteroid', rot= 0, rotInc =0  },
}





function entity:update()
	
end

function entity:draw()
	love.graphics.setColorMode("modulate")
	for i,v in ipairs(entities) do
		if v.colour and  #v.colour == 4 then
			love.graphics.setColor( v.colour[1],v.colour[2],v.colour[3],v.colour[4])
		end

			love.graphics.draw(images[v.image], v.x+images[v.image]:getWidth()/2, v.y+images[v.image]:getHeight()/2, math.rad(v.rot),1,1,images[v.image]:getWidth()/2,images[v.image]:getHeight()/2)

	end
	love.graphics.setColorMode("replace")
end







  weapons = 
  {
	  basicPhaser =  {
			image = 'basicPhaser', 
			colMap = 'militaryBlaster', 
			x = 0,
			y = 0,
			power = 0.5,
			sound = 'basicPhaser',
			fuelUsage = 0.75,
			weaponSpeed = 4,
		},
		   
	  defenceLaser =  {
			image =  'defenceLaser',
			colMap = 'militaryBlaster', 
			x = 0,
			y = 0,
			power = 9,
			sound = 'defenceLaser',
			fuelUsage = 3,
			weaponSpeed = 1,
		},
		   
	  militaryBlaster =  {
			image =  'militaryBlaster', 
			colMap = 'militaryBlaster', 
			x = 0,
			y = 0,
			power = 80,
			sound = 'militaryBlaster',
			weaponSpeed = 0.75,
			fuelUsage = 35,
		}
}
























