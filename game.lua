-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- 배경 --
	local background = display.newImageRect("Content/Image/MainGame/게임 플레이 예시.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	sceneGroup:insert(background)

	-- 브금 --
	local soundFile = audio.loadSound("Content/Sound/BGM/Do Do Do - Silent Partner.mp3")
	audio.play(soundFile, {
		channel = 1,
		loops = -1})
	--audio.setVolume(0.5, {channel = 2})
	audio.pause(1)

	-- 국자 소환 --
	--local ladle = display.newImage("Content/Image/MainGame/국자.png")
	--ladle.x, ladle.y = display.contentWidth*0.5, display.contentHeight*0.5


	-- 누르기 --

	-- 누르기 전 달고나 소환 --
	local dalgona = display.newImage("Content/Image/MainGame/fish.png")
	dalgona.x, dalgona.y = display.contentWidth*0.56, display.contentHeight*0.6
	
	dalgona.press = false
	dalgona.hard = false

	sceneGroup:insert(dalgona)

	-- 누름판 소환 --
	local pressBoard = display.newImageRect("Content/Image/MainGame/누름판.png", 200, 200)
	pressBoardX, pressBoardyY = display.contentWidth*0.61, display.contentHeight*0.15
	pressBoard.x, pressBoard.y = pressBoardX, pressBoardyY

	sceneGroup:insert(pressBoard)

	-- 누르고 다서 모양틀 전까지 시간 제한 --
	local shapeLimit = 3
	local showShapeLimit = display.newText(shapeLimit, display.contentWidth*0.3, display.contentHeight*0.3)
	showShapeLimit:setFillColor(0)
	showShapeLimit.size = 100

	local function shapeTimeAttack( event )
		if(shapeLimit >= 0) then
			shapeLimit = shapeLimit - 1
			showShapeLimit.text = shapeLimit

			if(shapeLimit == 0) then
				-- 시간 경과하면 단단해진 달고나로 --
				dalgona.hard = true
				dalgona.fill = {
					type = "image",
					filename = "Content/Image/MainGame/image.jpg"
				}
			end
		end
	end

	-- 누름판으로 눌러준다 -- 
	local function catchPressBoard( event )
		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true

		elseif( event.phase == "moved" ) then
			if( event.target.isFocus ) then
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end

		elseif( event.phase == "ended" or event.phase == "cancelled" ) then
			if(event.target.isFocus) then
				if event.target.x < dalgona.x + 100 and event.target.x > dalgona.x - 100
						and event.target.y < dalgona.y + 100 and event.target.y > dalgona.y - 100 then

					-- 달고나 눌러진 이미지로 변경 --
					dalgona.press = true
					dalgona.fill = {
						type="image",
						filename="Content/Image/MainGame/cat.png"
					}

					-- 시간제한 시작 --
					timer.performWithDelay( 1000, shapeTimeAttack, 0 , "shapeTimer")

					-- 누름판 원위치 --
					event.target.x = pressBoardX
					event.target.y = pressBoardyY
				else
					event.target.x = pressBoardX
					event.target.y = pressBoardyY
				end

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end

			display.getCurrentStage():setFocus(nil)
			event.target.isFocus = false
		end
	end

	pressBoard:addEventListener("touch", catchPressBoard)


	sceneGroup:insert(showShapeLimit)

	-- 모양틀 --

	-- 모양틀 소환 --
	local shapeFrame = display.newImageRect("Content/Image/MainGame/모양틀.png", 200, 200)
	shapeFrameX, shapeFrameY = display.contentWidth*0.8, display.contentHeight*0.15
	shapeFrame.x, shapeFrame.y = shapeFrameX, shapeFrameY

	sceneGroup:insert(shapeFrame)

	-- 모양틀 누르기 --
	local function catchShpeFrame( event )
			if( event.phase == "began" ) then
				display.getCurrentStage():setFocus( event.target )
				event.target.isFocus = true

			elseif( event.phase == "moved" ) then
				if( event.target.isFocus ) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif( event.phase == "ended" or event.phase == "cancelled" ) then
				if(event.target.isFocus) then
					if event.target.x < dalgona.x + 100 and event.target.x > dalgona.x - 100
							and event.target.y < dalgona.y + 100 and event.target.y > dalgona.y - 100 then
						-- 타이머 중지 --
						timer.pause("shapeTimer")

						if(dalgona.press) then -- 누르기 했음 --
							if(dalgona.hard) then
								 -- 누르고 시간이 지나 굳은 달고나 --
								dalgona.fill = {
									type="image",
									filename="Content/Image/MainGame/peach.jpg"
								}

							else
								-- 달고나 눌러진 이미지로 변경 --
							dalgona.fill = {
								type="image",
								filename="Content/Image/MainGame/fruit.jpg"
							}

							end
						else -- 누르기 안함 --
							-- 누르기 전에 모양틀을 눌러 엉망이 된 모습 --
							dalgona.fill = {
								type="image",
								filename="Content/Image/MainGame/모미지.jpg"
							}
						end

						-- 누름판 원위치 --
						event.target.x = shapeFrameX
						event.target.y = shapeFrameY
					else
						event.target.x = shapeFrameX
						event.target.y = shapeFrameY
					end

					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end

		shapeFrame:addEventListener("touch", catchShpeFrame)

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