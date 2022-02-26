-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

v = "@@@"

function scene:resumeGame()
    --code to resume game
end

function scene:create( event )
	local sceneGroup = self.view

	-- 배경 --
	local background = display.newImageRect("Content/Image/Start/시작화면 배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	sceneGroup:insert(background)

	-- 시작버튼 --
	local startBtn = display.newImage("Content/Image/Start/시작화면 시작버튼.png")
	startBtn:translate(960, 950)

	sceneGroup:insert(startBtn)

	-- 도움말버튼 --
	local helpBtn = display.newImage("Content/Image/Start/시작화면 도움말.png")
	helpBtn:translate(300, 983)

	sceneGroup:insert(helpBtn)

	-- 브금 --
	local soundFile = audio.loadSound("Content/Sound/BGM/If I Had a Chicken - Kevin MacLeod.mp3")
	local vol = 4
	audio.play(soundFile, {
		channel = 1,
		loops = -1})
	audio.setVolume(vol*0.1, {channel = 1})

	-- 옵션 --
	local function openOption( event )
		local options = {
		    isModal = true,
		    effect = "fade",
		    time = 400,
		    params = {}
		}

		composer.showOverlay("option", options)
	
	end

	local optionBtn = display.newImage("Content/Image/Start/시작화면 옵션.png")
	optionBtn.x, optionBtn.y = display.contentWidth*0.055, display.contentHeight*0.91
	optionBtn.destination = "optionBtn"

	optionBtn:addEventListener("tap", openOption)

	sceneGroup:insert(optionBtn)

	-- 도움말 --
	local function openHelp( event )
		local options = {
		    isModal = true,
		    effect = "fade",
		    time = 400,
		    params = {
		        sampleVar = "my sample variable"
		    }
		}

		composer.showOverlay("help", options)
	end

	helpBtn:addEventListener("tap", openHelp)

	-- 시작하기 --
	local function start( event )
		--composer.setVariable("vol", vol)
		--composer.setVariable("bgmOn", bgmOn)


		composer.gotoScene("game")
	end

	startBtn:addEventListener("tap", start)

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

		audio.pause(1)

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