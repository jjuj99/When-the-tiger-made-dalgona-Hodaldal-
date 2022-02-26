-----------------------------------------------------------------------------------------
--
-- option.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )

	local sceneGroup = self.view

	-- 배경 --
	local background = display.newImage("Content/Image/Start/옵션창배경.png")
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5

	sceneGroup:insert(background)

	local optionGruop = display.newGroup()

	local xView = display.newImage(optionGruop, "Content/Image/Start/옵션창 X.png")
	xView.x, xView.y = display.contentWidth*0.75, display.contentHeight*0.27

	-- 볼륨 조절 --

	local vol = math.floor(audio.getVolume( { channel=1 } ) * 10)

	local showVol = display.newText(optionGruop, vol, display.contentWidth*0.5, display.contentHeight*0.67)
	showVol:setFillColor(0)
	showVol.size = 130

	local down = display.newImage(optionGruop, "Content/Image/Start/옵션창 볼륨하락.png")
	down.x, down.y = display.contentWidth*0.37, display.contentHeight*0.67

	local up = display.newImage(optionGruop, "Content/Image/Start/옵션창 볼륨상승.png")
	up.x, up.y = display.contentWidth*0.63, display.contentHeight*0.67

	local bgmOn = audio.isChannelPlaying(1)

	local bgmCheck

	if(bgmOn) then
		bgmCheck = display.newImage(optionGruop, "Content/Image/Start/옵션창 음악ON.png")
	else
		bgmCheck = display.newImage(optionGruop, "Content/Image/Start/옵션창 음악OFF.png")
	end

	bgmCheck.x, bgmCheck.y = display.contentWidth*0.68, display.contentHeight*0.47

	sceneGroup:insert(optionGruop)

	local function volDown( event )
		if(vol > 1) then
			vol = vol - 1
			showVol.text = vol
			audio.setVolume(vol*0.1, {channel = 1})
			print(audio.getVolume( { channel=1 } ))
		end
	end

	local function volUp( event )
		if(vol < 10) then
			vol = vol + 1
			showVol.text = vol
			audio.setVolume(vol*0.1, {channel = 1})
		end
	end

	down:addEventListener("tap", volDown)
	up:addEventListener("tap", volUp)

	local function mute( event )
		if(bgmOn) then
			audio.pause(1)
			bgmOn = false
			bgmCheck.fill = {
				type = "image",
				filename = "Content/Image/Start/옵션창 음악OFF.png"
			}
		else
			audio.resume()
			bgmOn = true
			bgmCheck.fill = {
				type = "image",
				filename = "Content/Image/Start/옵션창 음악ON.png"
			}

		end
	end

	bgmCheck:addEventListener("tap", mute)

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