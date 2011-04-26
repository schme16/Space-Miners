
images = 
{
	ship = love.graphics.newImage('img/ship.png'),
	
	planet = love.graphics.newImage('img/planets.png'),
	asteroid = love.graphics.newImage('img/asteroid.png'),

	
	basicPhaser = love.graphics.newImage('img/plasma.png'),
	defenceLaser = love.graphics.newImage('img/laser.png'),
	militaryBlaster = love.graphics.newImage('img/blaster.png'),
	
	background = love.graphics.newImage('img/starfield.gif'),
	--background = love.graphics.newImage('img/tempStars.gif'),
}

colMaps = 
{
	--ship = love.graphics.newImage('img/ship.png'),
	
--	planet = collision:newCollisionMap('img/planets.png'),
--	asteroid = collision:newCollisionMap('img/asteroid.png'),
	
--	basicPhaser = collision:newCollisionMap('img/plasma.png'),
--	defenceLaser = collision:newCollisionMap('img/laser.png'),
--	militaryBlaster = collision:newCollisionMap('img/blaster.png'),

}

sounds = 
	{
		basicPhaser = 'snd/bullet.wav',
		defenceLaser = 'snd/laser.wav',
		militaryBlaster = 'snd/blaster.wav', 'stream',
		engine = 'snd/engine.mp3',
		death = 'snd/gameover.wav',
	}
	
--	TEsound.playLooping(sounds.engine, 'engine', false, 0.050)
	--TEsound.pause('engine')
	
	
	
fonts = 
{
	pauseFont = love.graphics.newFont( 100 ),
	gameOverFont = love.graphics.newFont(50 ),
	menuTitleFont = love.graphics.newFont(100 ),
	menuFont = love.graphics.newFont(20 ),
	shopMenuTitleFont = love.graphics.newFont(25 ),
	shopMenu = love.graphics.newFont(15 ),

}	