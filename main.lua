require 'inc/supportFunctions'
require 'inc/TEsound'
require 'inc/input'
require 'inc/vector'
require 'inc/camera'
require 'inc/pPCollision'
require 'inc/media'
require 'inc/entities'
require 'inc/game'
require 'inc/player'
require 'inc/debug'
require 'inc/hud'

require 'inc/json'

	table.save = json.encode
	table.load = json.decode
	
	
	tempCam = nil
function love.load()
	
end

function love.update(dt)
	if keyboard.newPress['return'] and game then game.state = 'newGame' end
	if keyboard.newPress['i'] and game then
		if not (game.state == 'menu') then
			tempCam = cam
			cam = nil
			game.oldState =  game.state
			game.state = 'menu'
			--sounds.bgMusic:pause()
			--sounds.menuMusic:resume()
			--sounds.menuMusic:setLooping(true)
		else
			--sounds.menuMusic:pause()
			--sounds.bgMusic:resume()
			cam = tempCam
			tempCam = nil
			game.state = game.oldState 			
		end
	end
	
		if game.state == 'menu' then
			--sounds.bgMusic:pause()
			--sounds.menuMusic:resume()

		else
			--sounds.menuMusic:pause()
			--sounds.bgMusic:resume()		
		end
	input:update()
end

function love.keypressed(key)
	if key == ' ' then key = 'space' end
	keyboard.newPress[key] = true
end
	
function love.mousepressed(x,y,key)
	if key == 'wd' then key = 'wheelDown' end
	if key == 'wu' then key = 'wheelUp' end

		mouse.newPress[key] = true
end

function love.keyreleased(key)

	if key == ' ' then key = 'space' end
	keyboard.newPress[key] = false
end
	
function love.mousereleased(x,y,key)
	mouse.newPress[key] = false
end	

function love.draw()
	if cam then cam:draw(function() game:run()   end )  else game:run() end
end

addDraw('MainDraw', love.draw)