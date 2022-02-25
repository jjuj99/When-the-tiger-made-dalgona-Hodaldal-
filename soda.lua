-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	local background = display.newImage("플레이화면/게임 플레이 예시.png")
	background.x, background.y = display.contentWidth / 2, display.contentHeight / 2
	background.alpha = 0.7 --(임시)

	--달고나판
	local plate = display.newImage("플레이화면/달고나판.png")
	plate.x, plate.y = display.contentWidth * 0.72, display.contentHeight * 0.47
	--달고나1
	local dalgona1 = display.newImage("플레이화면/달고나 덩어리.png")
	dalgona1X, dalgona1Y = display.contentWidth * 0.56, display.contentHeight * 0.6
	dalgona1.x, dalgona1.y = dalgona1X, dalgona1Y
	dalgona1On = false --달고나1이 올라가 있는지 체크
	dalgona1.alpha = 0
	--달고나2
	local dalgona2 = display.newImage("플레이화면/달고나 덩어리.png")
	dalgona2X, dalgona2Y = display.contentWidth * 0.77, display.contentHeight * 0.6
	dalgona2.x, dalgona2.y = dalgona2X, dalgona2Y
	dalgona2On = false --달고나2가 올라가 있는지 체크
	dalgona2.alpha = 0
	--젓가락 통
	local chapsticks = display.newImage("플레이화면/젓가락통.png", display.contentWidth * 0.45, display.contentHeight * 0.165)
	--젓가락
	local chapstick = display.newImage("플레이화면/젓가락.png")
	chapstickX, chapstickY = display.contentWidth * 0.5, display.contentHeight * 0.165
	chapstick.x, chapstick.y = chapstickX, chapstickY
	chapstick.alpha = 0.5
	local chapstickSoda = false --젓가락에 소다가 찍혔는지 판정하는 파라미터
	--국자1
	local ladle1 = display.newImage("플레이화면/국자 설탕녹음.png")
	ladle1X, ladle1Y = display.contentWidth * 0.1, display.contentHeight * 0.6
	ladle1.x, ladle1.y = ladle1X, ladle1Y
	local ladle1Fill = true --국자1이 차 있는지 체크
	local ladle1Soda = false --국자1에 소다가 들어갔는지 체크
	--국자2
	local ladle2 = display.newImage("플레이화면/국자 설탕녹음.png")
	ladle2X, ladle2Y = display.contentWidth * 0.3, display.contentHeight * 0.6
	ladle2.x, ladle2.y = ladle2X, ladle2Y
	local ladle2Fill = true --국자2가 차 있는지 체크
	local ladle2Soda = false --국자2에 소다가 들어갔는지 체크
	--소다
	local soda = display.newImage("플레이화면/소다.png")
	soda.x, soda.y = display.contentWidth * 0.282, display.contentHeight * 0.2
	
	sceneGroup: insert(background)
	sceneGroup: insert(plate)
	sceneGroup: insert(soda)
	sceneGroup: insert(dalgona1)
	sceneGroup: insert(ladle1)
	sceneGroup: insert(ladle2)
	sceneGroup: insert(chapsticks)
	sceneGroup: insert(chapstick)

	--소다 찍기 함수
	local function pickSoda(event)
		--젓가락에 소다가 없을 때 실행
		if chapstickSoda == false then
			if(event.phase == "began") then
				print("PickSoda start")
				display.getCurrentStage():setFocus( event.target )
				event.target.isFocus = true
				--젓가락 선택시 투명도1(나타나는 걸로 바꿀 수 있을까?)
				chapstick.alpha = 1

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					--소다에 젓가락을 넣을 시
					if event.target.x < soda.x + 150 and event.target.x > soda.x - 150
						and event.target.y < soda.y + 150 and event.target.y > soda.y - 150 then
					--소다가 묻음
					 chapstickSoda = true
						print("Soda is ready")
						chapstick.fill = {
							type = "image",
							filename = "플레이화면/젓가락 소다.png"
						}
					else
						--다른 곳에 젓가락을 놓으면 원래 자리로
						event.target.x = chapstickX
						event.target.y = chapstickY
						chapstick.alpha = 0.5
						print("False location")
					end
					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end
	end
	
	chapstick: addEventListener("touch", pickSoda)

	--국자에 소다 투입 함수
	local function putSoda(event)
		--젓가락에 소다가 묻었을 때만 실행
		if chapstickSoda == true then
			if(event.phase == "began") then
				print("PutSoda1 start")
				display.getCurrentStage():setFocus( event.target )
				event.target. isFocus = true

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					--국자 1에 소다젓가락 넣을 경우, 국자 1이 차 있다면
					if event.target.x < ladle1.x + 200 and event.target.x > ladle1.x - 200
						and event.target.y < ladle1.y + 200 and event.target.y > ladle1.y - 200  and ladle1Fill == true then
					 	--젓가락 소다 X, 국자1 소다 O
						chapstickSoda = false
					 	ladle1Soda = true
						print("Put soda to ladle1")
						--소다 투입 후 젓가락 자리로
						event.target.x = chapstickX
						event.target.y = chapstickY
						chapstick.alpha = 0.5
						chapstick.fill = {
							type = "image",
							filename = "플레이화면/젓가락.png"
						}
						ladle1.fill = {
							type = "image",
							filename = "플레이화면/국자 달고나.png"
						}

					--국자2에 넣을 경우, 국자2가 차 있다면
					elseif event.target.x < ladle2.x + 200 and event.target.x > ladle2.x - 200
						and event.target.y < ladle2.y + 200 and event.target.y > ladle2.y - 200  and ladle2Fill == true then
						--젓가락 소다 X, 국자2 소다 O
						chapstickSoda = false
						ladle2Soda = true
						print("Put soda to ladle2")
						--소다 투입 후 젓가락 자리로
						event.target.x = chapstickX
						event.target.y = chapstickY
						chapstick.alpha = 0.5
						chapstick.fill = {
							type = "image",
							filename = "플레이화면/젓가락.png"
						}
						ladle2.fill = {
							type = "image",
							filename = "플레이화면/국자 달고나.png"
						}
					else
						--소다 투입 실패시 소다에 꽂혀있음
						event.target.x = display.contentWidth * 0.282
						event.target.y = display.contentHeight * 0.15
						print("False location")
					end
					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end
	end
	
	chapstick: addEventListener("touch", putSoda)

	--국자1의 달고나를 판에 올리는 함수
	local function settingL1D(event)
		if ladle1Soda == true then
			if(event.phase == "began") then
				print("settingD start")
				display.getCurrentStage():setFocus( event.target )
				event.target.isFocus = true

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					--판 위에 올렸을 때, 비어있다면, 왼쪽 판 위로 올라감.
					if event.target.x < dalgona1.x + 200 and event.target.x > dalgona1.x - 200
						and event.target.y < dalgona1.y + 200 and event.target.y > dalgona1.y - 200 and dalgona1On == false then
						--국자1 비었음
						ladle1Soda = false
						ladle1Fill = false
						--달고나1 올라감
						dalgona1.alpha = 1
						dalgona1On = true
						print("달고나 놓기")
						ladle1.fill = {
							type = "image",
							filename = "플레이화면/국자.png"
						}
					--판 위에 올렸을 때, 비어있다면, 오른쪽 판 위로 올라감.
					elseif event.target.x < dalgona2.x + 200 and event.target.x > dalgona2.x - 200
						and event.target.y < dalgona2.y + 200 and event.target.y > dalgona2.y - 200 and dalgona2On == false then
						--국자1 비었음
						ladle1Soda = false
						ladle1Fill = false
						--달고나2 올라감
						dalgona2.alpha = 1
						dalgona2On = true
						print("달고나 놓기")
						ladle1.fill = {
							type = "image",
							filename = "플레이화면/국자.png"
						}
					end
					--국자1 원위치
					event.target.x = ladle1X
					event.target.y = ladle1Y

					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		--소다를 안 넣은 국자일때
		else
			if(event.phase == "began") then
				print("settingD start")
				display.getCurrentStage():setFocus( event.target )
				event.target.isFocus = true

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					--원위치(판 말고 다른 곳에 놓음)
					event.target.x = ladle1X
					event.target.y = ladle1Y
					print("false: 덜 만듦")

					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end
	end

	ladle1: addEventListener("touch", settingL1D)

	--국자2의 달고나를 판에 올리는 함수
	local function settingL2D(event)
		if ladle2Soda == true then
			if(event.phase == "began") then
				print("settingD start")
				display.getCurrentStage():setFocus( event.target )
				event.target.isFocus = true

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					--판 위에 올렸을 때, 비어있다면, 왼쪽 판 위로 올라감.
					if event.target.x < dalgona1.x + 200 and event.target.x > dalgona1.x - 200
						and event.target.y < dalgona1.y + 200 and event.target.y > dalgona1.y - 200  and dalgona2On == false then
						--국자2 비었음
						ladle2Soda = false
						ladle2Fill = false
						--달고나1 올라감
						dalgona1.alpha = 1
						dalgona1On = true
						print("달고나 놓기")
						ladle2.fill = {
							type = "image",
							filename = "플레이화면/국자.png"
						}
					--판 위에 올렸을 때, 비어있다면, 오른쪽 판 위로 올라감.
					elseif event.target.x < dalgona2.x + 200 and event.target.x > dalgona2.x - 200
						and event.target.y < dalgona2.y + 200 and event.target.y > dalgona2.y - 200 and dalgona2On == false then
						--국자2 비었음
						ladle2Soda = false
						ladle2Fill = false
						--달고나2 올라감
						dalgona2.alpha = 1
						dalgona2On = true
						print("달고나 놓기")
						ladle2.fill = {
							type = "image",
							filename = "플레이화면/국자.png"
						}
					end
					--국자2 원위치
					event.target.x = ladle2X
					event.target.y = ladle2Y

					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end

		else
			if(event.phase == "began") then
				print("settingD start")
				display.getCurrentStage():setFocus( event.target )
				event.target.isFocus = true

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					--원위치(판 말고 다른 곳에 놓음)
					event.target.x = ladle2X
					event.target.y = ladle2Y
					print("false: 덜 만듦")

					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end
	end

	ladle2: addEventListener("touch", settingL2D)

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