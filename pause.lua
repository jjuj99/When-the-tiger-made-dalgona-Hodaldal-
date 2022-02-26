-----------------------------------------------------------------------------------------
--
-- pause.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )

	local sceneGroup = self.view

	vol = event.params.vol
	bgm = event.params.bgm

	-- 브금 정보 --

	audio.pause(2)

	local pauseGroup = display.newGroup()

	local pauseView = display.newImage(pauseGroup, "Content/Image/MainGame/PauseView/옵션창.png")
	pauseView.x, pauseView.y = display.contentWidth*0.5, display.contentHeight*0.45

	local continueBtn = display.newImage(pauseGroup, "Content/Image/MainGame/PauseView/이어하기.png")
	continueBtn.x, continueBtn.y = display.contentWidth*0.38, display.contentHeight*0.39

	local restartBtn = display.newImage(pauseGroup, "Content/Image/MainGame/PauseView/재시작.png")
	restartBtn.x, restartBtn.y = display.contentWidth*0.625, display.contentHeight*0.39

	sceneGroup:insert(pauseGroup)

	local function continue( event )
		--audio.resume(2)
		audio.rewind( { channel=2 } )
		timer.resume("gameLimit")
		composer.hideOverlay( "fade", 400 )
	end

	local function restart( event )
		composer.removeScene("game", true)
		composer.gotoScene("game")
	end

	restartBtn:addEventListener("tap", restart)

	continueBtn:addEventListener("tap", continue)

end
 
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  -- Reference to the parent scene object
 
    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        parent:resumeGame(vol)
    end
end
 
-- By some method such as a "resume" button, hide the overlay
composer.hideOverlay( "fade", 400 )
 
scene:addEventListener( "hide", scene )


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