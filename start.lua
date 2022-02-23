-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- 배경 --
	local background = display.newImageRect("Content/Image/Start/스타트 화면 배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	sceneGroup:insert(background)

	-- 브금 --
	local soundFile = audio.loadSound("Content/Sound/BGM/If I Had a Chicken - Kevin MacLeod.mp3")
	audio.play(soundFile, {
		channel = 1,
		loops = -1})
	
	--audio.pause(1)

	-- 볼륨 조절 --
	local volGroup = display.newGroup()

	local vol = 4
	local showVol = display.newText(volGroup, vol, display.contentWidth*0.1, display.contentHeight*0.2)
	showVol:setFillColor(0)
	showVol.size = 50

	local l = "<"
	local showL = display.newText(volGroup, l, display.contentWidth*0.05, display.contentHeight*0.2)
	showL:setFillColor(0)
	showL.size = 50

	local r = ">"
	local showR = display.newText(volGroup, r, display.contentWidth*0.15, display.contentHeight*0.2)
	showR:setFillColor(0)
	showR.size = 50

	audio.setVolume(vol*0.1, {channel = 1})

	local function volDown( event )
		if(vol > 0) then
			vol = vol - 1
			showVol.text = vol
			audio.setVolume(vol*0.1, {channel = 1})
		end
	end

	local function volUp( event )
		if(vol < 10) then
			vol = vol + 1
			showVol.text = vol
			audio.setVolume(vol*0.1, {channel = 1})
		end
	end

	showL:addEventListener("tap", volDown)
	showR:addEventListener("tap", volUp)

	local bgmCheck = display.newImage(volGroup, "Content/Image/MainGame/fish.png")
	bgmCheck.x, bgmCheck.y = display.contentWidth*0.2, display.contentHeight*0.2
	bgmCheck.on = true
	bgmCheck.channel = 1

	local function mute( event )
		if(bgmCheck.on) then
			audio.pause(1)
			bgmCheck.on = false
			bgmCheck.fill = {
				type = "image",
				filename = "Content/Image/MainGame/cat.png"
			}
		else
			audio.resume()
			bgmCheck.on = true
			bgmCheck.fill = {
				type = "image",
				filename = "Content/Image/MainGame/fish.png"
			}

		end
		
	end

	bgmCheck:addEventListener("tap", mute)

	sceneGroup:insert(volGroup)


	--local score = 0
	--local showScore = display.newText(volGroup, score, display.contentWidth*0.2, display.contentHeight*0.2)
	--showScore:setFillColor(0)
	--showScore.size = 100

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