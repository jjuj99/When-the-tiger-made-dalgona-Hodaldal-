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

	-- 시작버튼 --
	local startBtn = display.newImage("Content/Image/Start/시작버튼.png")
	startBtn:translate(960, 880)

	sceneGroup:insert(startBtn)

	-- 도움말버튼 --
	local helpBtn = display.newImage("Content/Image/Start/도움말 버튼.png")
	helpBtn:translate(1700, 890)

	sceneGroup:insert(helpBtn)

	-- 스코어 --
	local score = 0 		-- ???스코어의 의미??? --

	-- 시작하기 --
	local function start( event )
		score = score + 1
		if score == 1 then
			composer.gotoScene("game")
		end
	end

	startBtn:addEventListener("tap", start)




















	-- 브금 --
	local soundFile = audio.loadSound("Content/Sound/BGM/If I Had a Chicken - Kevin MacLeod.mp3")
	audio.play(soundFile, {
		channel = 1,
		loops = -1})
	local bgmOn = true

	
	
	audio.pause(1)

	--local optionView = display.newImageRect("Content/Image/MainGame/테이블 배경.png", 700, 500)
	--optionView.x, optionView.y = display.contentWidth*0.5, display.contentHeight*0.5

	local optionBtn = display.newImageRect("Content/Image/MainGame/달고나 덩어리.png", 150, 150)
	optionBtn.x, optionBtn.y = display.contentWidth*0.9, display.contentHeight*0.1

	

	local function option( event )

		local optionView = display.newImageRect("Content/Image/MainGame/테이블 배경.png", 700, 500)
		optionView.x, optionView.y = display.contentWidth*0.5, display.contentHeight*0.5

		sceneGroup:insert(optionView)


			-- 볼륨 조절 --

		local volGroup = display.newGroup()

		local bgmCheck

		if (bgmOn) then
			bgmCheck = display.newImage(volGroup, "Content/Image/MainGame/fish.png")
		else
			bgmCheck = display.newImage(volGroup, "Content/Image/MainGame/cat.png")
		end



		bgmCheck.x, bgmCheck.y = display.contentWidth*0.7, display.contentHeight*0.5
		--bgmCheck.on = true
		bgmCheck.channel = 1
		

		local vol = 4
		local showVol = display.newText(volGroup, vol, display.contentWidth*0.5, display.contentHeight*0.5)
		showVol:setFillColor(0)
		showVol.size = 50

		local l = "<"
		local showL = display.newText(volGroup, l, display.contentWidth*0.45, display.contentHeight*0.5)
		showL:setFillColor(0)
		showL.size = 50

		local r = ">"
		local showR = display.newText(volGroup, r, display.contentWidth*0.55, display.contentHeight*0.5)
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

		

		local function mute( event )
			if(bgmOn) then
				audio.pause(1)
				bgmOn = false
				bgmCheck.fill = {
					type = "image",
					filename = "Content/Image/MainGame/cat.png"
				}
			else
				audio.resume()
				bgmOn = true
				bgmCheck.fill = {
					type = "image",
					filename = "Content/Image/MainGame/fish.png"
				}

			end
			
		end

		bgmCheck:addEventListener("tap", mute)

		sceneGroup:insert(volGroup)





		local function close( event )
			display.remove(optionView)
			optionView = nil

			display.remove(volGroup)
			volGroup = nil
		end

		optionView:addEventListener("tap", close)



		--sceneGroup:insert(optionView)
	end

	sceneGroup:insert(optionBtn)

	optionBtn:addEventListener("tap", option)






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