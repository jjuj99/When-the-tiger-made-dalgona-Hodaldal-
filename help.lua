-----------------------------------------------------------------------------------------
--
-- help.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )

	local sceneGroup = self.view

	local helpGruop = display.newGroup()

	local helpView = display.newImage(helpGruop, "Content/Image/Start/설명창 예시.png")
	helpView.x, helpView.y = display.contentWidth*0.5, display.contentHeight*0.5

	local xView = display.newImage(helpGruop, "Content/Image/Start/옵션창 X.png")
	xView.x, xView.y = display.contentWidth*0.924, display.contentHeight*0.128

	sceneGroup:insert(helpGruop)

	local function close( event )
		composer.hideOverlay( "fade", 400 )
	end

	xView:addEventListener("tap", close)

end
 
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  -- Reference to the parent scene object
 
    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        parent:resumeGame()
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