-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImage("image/main.png" , display.contentWidth/2, display.contentHeight/2)
	background.width = display.contentWidth
	background.height = display.contentHeight
	
	--매대--
	local out = display.newImage("image/out.png", 1215, 360)
	out.width = 132
	out.height = 725

	--달고나1--
	local dalgona1 = display.newImage("image/dalgona.png", 720, 450)
	dalgona1.width = 250
	dalgona1.height = 250
	--달고나2
	local dalgona2 = display.newImage("image/dalgona.png", 988, 450)
	dalgona2.width = 250
	dalgona2.height = 250
	
	--달고나1제출
	local function catch( event )
		if ( event.phase == "began") then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
		elseif(event.phase == "moved") then
			if(event.target.isFocus) then
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif (event.phase == "ended" or event.phase == "cancelled") then		
			if(event.target.isFocus) then
				if event.target.x<out.x+100 and event.target.x>out.x-100
					and event.target.y<out.y+100 and event.target.y>out.y-100 then
					
					composer.setVariable(flag1)
					display.remove(event.target)
					--composer.gotoScene("veiw2")
				end
			else
				event.target.x=event.xStart
				event.target.y=event.yStart
			end
		end
	end
	dalgona1:addEventListener("touch",catch)

	--flag1 = 0
	--달고나2제출 후 엔딩씬
	local function catch( event )
		if ( event.phase == "began") then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
		elseif(event.phase == "moved") then
			if(event.target.isFocus) then
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif (event.phase == "ended" or event.phase == "cancelled") then		
			if(event.target.isFocus) then
				if event.target.x<out.x+100 and event.target.x>out.x-100
					and event.target.y<out.y+100 and event.target.y>out.y-100 then
							
					display.remove(event.target)
					composer.setVariable(flag2)
					composer.gotoScene("view2")
				end
			else
				event.target.x=event.xStart
				event.target.y=event.yStart
			end
		end
	end
	dalgona2:addEventListener("touch",catch)

	sceneGroup:insert(background)
	sceneGroup:insert(out)
	sceneGroup:insert(dalgona1)
	sceneGroup:insert(dalgona2)
end




function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
