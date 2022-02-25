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

	-- *** 도구 소환 *** --

	--달고나판 소환 --
	--local plate = display.newImage("Content/Image/MainGame/달고나판.png")
	--plate.x, plate.y = display.contentWidth * 0.665, display.contentHeight * 0.63

	--sceneGroup: insert(plate)

	local plates = display.newGroup()

	local plate1 = display.newImage(plates, "Content/Image/MainGame/달고나판1.png")
	plate1.x, plate1.y = display.contentWidth * 0.555, display.contentHeight * 0.63

	local plate2 = display.newImage(plates, "Content/Image/MainGame/달고나판2.png")
	plate2.x, plate2.y = display.contentWidth * 0.776, display.contentHeight * 0.63

	sceneGroup:insert(plates)

	-- 매대 소환--
	local out = display.newImage("Content/Image/MainGame/매대.png")
	out.x, out.y = display.contentWidth*0.95, display.contentHeight*0.5

	sceneGroup:insert(out)

	-- 국자 --
	local ladle1 = display.newImage("Content/Image/MainGame/국자.png")
	ladle1.ladleX, ladle1.ladleY = display.contentWidth*0.085, display.contentHeight*0.6
	ladle1.x, ladle1.y = ladle1.ladleX, ladle1.ladleY
	
	--local ladle1Fill = true -- 국자가 채워진 상태인지 아닌지 구분
	--local ladle1Soda = false



	ladle1.sugar = true -- 국자가 채워진 상태인지 아닌지 구분
	ladle1.soda = false





	local ladle2 = display.newImage("Content/Image/MainGame/국자.png")
	ladle2.ladleX, ladle2.ladleY = display.contentWidth*0.29, display.contentHeight*0.6
	ladle2.x, ladle2.y = ladle2.ladleX, ladle2.ladleY
	
	--local ladle2Fill = true -- 국자가 채워진 상태인지 아닌지 구분
	--local ladle2Soda = false

	ladle2.sugar = true
	ladle2.soda = false

	sceneGroup:insert(ladle1)
	sceneGroup:insert(ladle2)



	-- 소다 소환 --
	local soda = display.newImage("Content/Image/MainGame/소다.png")
	soda.x, soda.y = display.contentWidth * 0.282, display.contentHeight * 0.2

	sceneGroup: insert(soda)

	-- 젓가락 통 소환 --
	local chapsticks = display.newImage("Content/Image/MainGame/젓가락통.png", display.contentWidth * 0.45, display.contentHeight * 0.15)

	sceneGroup: insert(chapsticks)

	-- 설탕 --
	local sugar = display.newImage("Content/Image/MainGame/설탕.png")
	sugar.x, sugar.y = display.contentWidth*0.11, display.contentHeight*0.16
	sugarX, sugarY = sugar.x, sugar.y

	sceneGroup:insert(sugar)

	-- 달고나 소환 --
	--[[
	local dalgona = display.newImage("Content/Image/MainGame/달고나 덩어리.png")
	dalgonaX, dalgonaY = display.contentWidth * 0.558, display.contentHeight * 0.615
	dalgona.x, dalgona.y = dalgonaX, dalgonaY

	dalgona.alpha = 0

	dalgona.press = false
	dalgona.hard = false

	sceneGroup: insert(dalgona) ]]--

	local dalgona1 = display.newImage("Content/Image/MainGame/달고나 덩어리.png")
	dalgona1.dalgonaX, dalgona1.dalgonaY = display.contentWidth * 0.558, display.contentHeight * 0.615
	dalgona1.x, dalgona1.y = dalgona1.dalgonaX, dalgona1.dalgonaY

	dalgona1.alpha = 0

	dalgona1.press = false
	dalgona1.hard = false

	sceneGroup: insert(dalgona1)

	local dalgona2 = display.newImage("Content/Image/MainGame/달고나 덩어리.png")
	dalgona2.dalgonaX, dalgona2.dalgonaY = display.contentWidth * 0.77, display.contentHeight * 0.615
	dalgona2.x, dalgona2.y = dalgona2.dalgonaX, dalgona2.dalgonaY

	dalgona2.alpha = 0

	dalgona2.press = false
	dalgona2.hard = false

	sceneGroup: insert(dalgona2)



	-- 젓가락 소환 --
	local chapstick = display.newImage("Content/Image/MainGame/젓가락.png")
	chapstickX, chapstickY = display.contentWidth * 0.5, display.contentHeight * 0.165
	chapstick.x, chapstick.y = chapstickX, chapstickY

	local chapstickSoda = false --젓가락에 소다가 찍혔는지 판정하는 파라미터

	sceneGroup: insert(chapstick)
	chapstick:toBack()

	-- 누름판 소환 --
	local pressBoard = display.newImage("Content/Image/MainGame/누름판.png")
	pressBoardX, pressBoardyY = display.contentWidth*0.61, display.contentHeight*0.16
	pressBoard.x, pressBoard.y = pressBoardX, pressBoardyY

	sceneGroup:insert(pressBoard)

	-- 모양틀 소환 --
	local shapeFrame = display.newImage("Content/Image/MainGame/모양틀.png")
	shapeFrameX, shapeFrameY = display.contentWidth*0.78, display.contentHeight*0.17
	shapeFrame.x, shapeFrame.y = shapeFrameX, shapeFrameY

	sceneGroup:insert(shapeFrame)



	-- *** 동작 *** --






	-- 설탕붓기 --
	local function catchFillSugar( event )
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
				if event.target.x < ladle1.x + 200 and event.target.x > ladle1.x - 200
						and event.target.y < ladle1.y + 200 and event.target.y > ladle1.y - 200 then

					--시간 설정--
					local limit = 4

					ladle1.fill = { 
						type = "image",
						filename = "Content/Image/MainGame/국자 설탕.png"
					}

					local function timeAttack( event )
						limit = limit -1

						-- 설탕 덜 녹음--
						if(limit == 2) then
							ladle1.fill = {
								type="image",
								filename="Content/Image/MainGame/국자 덜녹음.png"
						    }
						end

						--설탕 녹음 -- 
						if(limit == 0) then
							ladle1.fill = {
								type="image",
								filename="Content/Image/MainGame/국자 설탕녹음.png"
							}
						end

					end
					timer.performWithDelay( 1000, timeAttack, 0 )
					ladle1.fill = { 
						type = "image",
						filename = "Content/Image/MainGame/국자 설탕.png"
					}

					-- 설탕 원위치 --
					event.target.x = sugarX
					event.target.y = sugarY

					--ladle1Fill = true -- 국자가 채워져 있는지 --
					ladle1.sugar = true

					

				elseif event.target.x < ladle2.x + 200 and event.target.x > ladle2.x - 200
						and event.target.y < ladle2.y + 200 and event.target.y > ladle2.y - 200 then

					--시간 설정--
					local limit = 4

					ladle2.fill = { 
						type = "image",
						filename = "Content/Image/MainGame/국자 설탕.png"
					}

					local function timeAttack( event )
						limit = limit -1

						-- 설탕 덜 녹음--
						if(limit == 2) then
							ladle2.fill = {
								type="image",
								filename="Content/Image/MainGame/국자 덜녹음.png"
						    }
						end

						--설탕 녹음 -- 
						if(limit == 0) then
							ladle2.fill = {
								type="image",
								filename="Content/Image/MainGame/국자 설탕녹음.png"
							}
						end
					end
					timer.performWithDelay( 1000, timeAttack, 0 )

					-- 설탕 원위치 --
					event.target.x = sugarX
					event.target.y = sugarY

					--ladle2Fill = true -- 국자가 채워져 있는지 --
					ladle2.sugar = true


				else
					event.target.x = sugarX
					event.target.y = sugarY
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus(nil)
			event.target.isFocus = false

		end
	end

	sugar:addEventListener("touch", catchFillSugar)



	--젓가락에 소다가 없을 때 실행되는, 소다 찍기 함수
	local function pickSoda(event)
		if chapstickSoda == false then
			if(event.phase == "began") then
				print("PickSoda start")
				display.getCurrentStage():setFocus( event.target )

				event.target.isFocus = true
				chapstick: toFront()

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					if event.target.x < soda.x + 150 and event.target.x > soda.x - 150
						and event.target.y < soda.y + 150 and event.target.y > soda.y - 150 then
						--소다에 젓가락을 넣으면 소다가 묻음
					 	chapstickSoda = true

						print("Soda is ready")

						chapstick.fill = {
							type = "image",
							filename = "Content/Image/MainGame/젓가락 소다.png"
						}
					else
						--다른 곳에 젓가락을 놓으면 원래 자리로
						event.target.x = chapstickX
						event.target.y = chapstickY
						chapstick:toBack()

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

	local sodaTime = 3
	local function meltSoda(event)
		if(sodaTime >= 0) then
			sodaTime = sodaTime - 1

			if(sodaTime == 2) then
				ladle1.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 달고나.png"
				}

			elseif(sodaTime == 0) then
				ladle1.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 달고나.png"
				}
			end
		end
	end

	--젓가락에 소다가 묻었을 때만 실행되는 소다 투입 함수
	local function putSoda(event)
		if chapstickSoda == true then
			if(event.phase == "began") then
				print("PutSoda start")
				display.getCurrentStage():setFocus( event.target )
				event.target.isFocus = true

			elseif(event.phase == "moved") then
				if(event.target.isFocus) then
					event.target.x = event.xStart + event.xDelta
					event.target.y = event.yStart + event.yDelta
				end

			elseif (event.phase == "ended" or event.phase == "cancelled") then
				if(event.target.isFocus) then
					--국자1
					if event.target.x < ladle1.x + 300 and event.target.x > ladle1.x - 300
							and event.target.y < ladle1.y + 300 and event.target.y > ladle1.y - 300  and ladle1.sugar == true then
					 	chapstickSoda = false
					 	ladle1.soda = true

						print("Put soda")

						-- 시간제한 시작 --
						sodaTime = 3
						timer.performWithDelay( 1000, meltSoda, 0 , "sodaTimer")

						--소다 투입 후 젓가락 자리로
						event.target.x = chapstickX
						event.target.y = chapstickY

						chapstick:toBack()
						chapstick.fill = {
							type = "image",
							filename = "Content/Image/MainGame/젓가락.png"
						}
					--국자2
					elseif event.target.x < ladle2.x + 300 and event.target.x > ladle2.x - 300
						and event.target.y < ladle2.y + 300 and event.target.y > ladle2.y - 300  and ladle2.sugar == true then
					 	chapstickSoda = false
					 	ladle2.soda = true

						print("Put soda")

						-- 시간제한 시작 --
						sodaTime = 3
						timer.performWithDelay( 1000, meltSoda, 0 , "sodaTimer")

						--소다 투입 후 젓가락 자리로
						event.target.x = chapstickX
						event.target.y = chapstickY

						chapstick:toBack()
						chapstick.fill = {
							type = "image",
							filename = "Content/Image/MainGame/젓가락.png"
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

	-- 국자의 달고나를 판에 올리는 함수 --
	local function settingD(event)
		if event.target.soda == true then
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
					--판 위에 올렸을 때 왼쪽 판 위로 올라감.
					--판정 범위 수정하여 왼쪽 판, 오른쪽 판 달고나 put 분리
					if event.target.x < plate1.x + 100 and event.target.x > plate1.x - 100
						and event.target.y < plate1.y + 100 and event.target.y > plate1.y - 100 then
						event.target.soda = false
						dalgona1.alpha = 1
						event.target.sugar = false
						timer.pause("sodaTimer")
						print("달고나 놓기")

						dalgona1.x, dalgona1.y = dalgona1.dalgonaX, dalgona1.dalgonaY

						dalgona1.fill = {
							type = "image",
							filename = "Content/Image/MainGame/달고나 덩어리.png"
						}

						event.target.fill = {
							type = "image",
							filename = "Content/Image/MainGame/국자.png"
						}
						--이후 코드 보고 수정

						event.target.x = event.target.ladleX
						event.target.y = event.target.ladleY
					elseif event.target.x < plate2.x + 100 and event.target.x > plate2.x - 100
						and event.target.y < plate2.y + 100 and event.target.y > plate2.y - 100 then
						event.target.soda = false
						dalgona2.alpha = 1
						event.target.sugar = false

						print("달고나 놓기2")

						dalgona2.x, dalgona2.y = dalgona2.dalgonaX, dalgona2.dalgonaY

						dalgona2.fill = {
							type = "image",
							filename = "Content/Image/MainGame/달고나 덩어리.png"
						}

						event.target.fill = {
							type = "image",
							filename = "Content/Image/MainGame/국자.png"
						}
						--이후 코드 보고 수정

						event.target.x = event.target.ladleX
						event.target.y = event.target.ladleY
					end
					--국자 원위치
					event.target.x = event.target.ladleX
					event.target.y = event.target.ladleY

					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end

				event.target.x = event.target.ladleX
				event.target.y = event.target.ladleY

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
					event.target.x = ladle1X
					event.target.y = ladle1Y
					print("false: 덜 만듦")

					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
				end

				event.target.x = event.target.ladleX
				event.target.y = event.target.ladleY
				
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end
	end

	ladle1: addEventListener("touch", settingD)
	ladle2: addEventListener("touch", settingD)


	--ladle2 함수 분리
	--ladle2: addEventListener("touch", settingD)





	--[[
	local pauseBtn = display.newImage("Content/Image/MainGame/fish.png")
	pauseBtn.x, pauseBtn.y = display.contentWidth*0.1, display.contentHeight*0.9



	local function pause( event )
		composer.gotoScene("game")
	end

	pauseBtn:addEventListener("tap", pause)

	-- 브금 --
	local soundFile = audio.loadSound("Content/Sound/BGM/Do Do Do - Silent Partner.mp3")
	audio.play(soundFile, {
		channel = 1,
		loops = -1})
	--audio.setVolume(0.5, {channel = 2})
	audio.pause(1)
	]]--


	-- 국자 소환 --
	--local ladle = display.newImage("Content/Image/MainGame/국자.png")
	--ladle.x, ladle.y = display.contentWidth*0.5, display.contentHeight*0.5


	-- 누르기 --

	-- 누르기 전 달고나 소환 --
	--local dalgona = display.newImage("Content/Image/MainGame/달고나 덩어리.png", 150, 150)
	--dalgona.x, dalgona.y = display.contentWidth*0.56, display.contentHeight*0.6
	
	

	-- 누르고 다서 모양틀 전까지 시간 제한 --
	local shapeLimit1 = 3
	local showShapeLimit1 = display.newText(shapeLimit1, display.contentWidth*0.3, display.contentHeight*0.3)
	showShapeLimit1:setFillColor(0)
	showShapeLimit1.size = 100

	local shapeLimit2 = 3
	local showShapeLimit2 = display.newText(shapeLimit1, display.contentWidth*0.7, display.contentHeight*0.3)
	showShapeLimit2:setFillColor(0)
	showShapeLimit2.size = 100


	local function shapeTimeAttack1( event )
		if(shapeLimit1 >= 0) then
			shapeLimit1 = shapeLimit1 - 1
			showShapeLimit1.text = shapeLimit1

			if(shapeLimit1 == 0) then
				-- 시간 경과하면 단단해진 달고나로 --
				dalgona1.hard = true
				dalgona1.fill = {
					type = "image",
					filename = "Content/Image/MainGame/달고나 너무 굳은.png"
				}
			end
		end
	end

	local function shapeTimeAttack2( event )
		if(shapeLimit2 >= 0) then
			shapeLimit2 = shapeLimit2 - 1
			showShapeLimit2.text = shapeLimit2

			if(shapeLimit2 == 0) then
				-- 시간 경과하면 단단해진 달고나로 --
				dalgona2.hard = true
				dalgona2.fill = {
					type = "image",
					filename = "Content/Image/MainGame/달고나 너무 굳은.png"
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
				if event.target.x < dalgona1.x + 100 and event.target.x > dalgona1.x - 100
						and event.target.y < dalgona1.y + 100 and event.target.y > dalgona1.y - 100 then

					-- 달고나 눌러진 이미지로 변경 --
					dalgona1.press = true
					dalgona1.fill = {
						type="image",
						filename="Content/Image/MainGame/달고나 누름.png"
					}

					-- 시간제한 시작 --
					shapeLimit1 = 3
					timer.performWithDelay( 1000, shapeTimeAttack1, 0 , "shapeTimer1")

					-- 누름판 원위치 --
					event.target.x = pressBoardX
					event.target.y = pressBoardyY
				elseif event.target.x < dalgona2.x + 100 and event.target.x > dalgona2.x - 100
						and event.target.y < dalgona2.y + 100 and event.target.y > dalgona2.y - 100 then

					-- 달고나 눌러진 이미지로 변경 --
					dalgona2.press = true
					dalgona2.fill = {
						type="image",
						filename="Content/Image/MainGame/달고나 누름.png"
					}

					-- 시간제한 시작 --
					shapeLimit2 = 3
					timer.performWithDelay( 1000, shapeTimeAttack2, 0 , "shapeTimer2")

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

	sceneGroup:insert(showShapeLimit1)


	-- 모양틀 --


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
				if event.target.x < dalgona1.x + 100 and event.target.x > dalgona1.x - 100
						and event.target.y < dalgona1.y + 100 and event.target.y > dalgona1.y - 100 then

					-- 타이머 중지 --
					timer.pause("shapeTimer1")

					if(dalgona1.press) then -- 누르기 했음 --
						if(dalgona1.hard) then
							 -- 누르고 시간이 지나 굳은 달고나에 모양틀 --
							dalgona1.fill = {
								type="image",
								filename="Content/Image/MainGame/달고나 깨짐.png"
							}

						else
							-- 달고나 눌러진 이미지로 변경 --
						dalgona1.fill = {
							type="image",
							filename="Content/Image/MainGame/달고나 완성.png"
						}

						end
					else -- 누르기 안함 --
						-- 누르기 전에 모양틀을 눌러 엉망이 된 모습 --
						dalgona1.fill = {
							type="image",
							filename="Content/Image/MainGame/달고나덩어리 모양틀.png"
							}
					end

					-- 누름판 원위치 --
					event.target.x = shapeFrameX
					event.target.y = shapeFrameY
				elseif event.target.x < dalgona2.x + 100 and event.target.x > dalgona2.x - 100
						and event.target.y < dalgona2.y + 100 and event.target.y > dalgona2.y - 100 then

					-- 타이머 중지 --
					timer.pause("shapeTimer2")

					if(dalgona2.press) then -- 누르기 했음 --
						if(dalgona2.hard) then
							 -- 누르고 시간이 지나 굳은 달고나에 모양틀 --
							dalgona2.fill = {
								type="image",
								filename="Content/Image/MainGame/달고나 깨짐.png"
							}

						else
							-- 달고나 눌러진 이미지로 변경 --
						dalgona2.fill = {
							type="image",
							filename="Content/Image/MainGame/달고나 완성.png"
						}

						end
					else -- 누르기 안함 --
						-- 누르기 전에 모양틀을 눌러 엉망이 된 모습 --
						dalgona2.fill = {
							type="image",
							filename="Content/Image/MainGame/달고나덩어리 모양틀.png"
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


	local function sale( event )
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
					--composer.gotoScene("end")
				end
			else
				event.target.x=event.xStart
				event.target.y=event.yStart
			end
		end
	end
	dalgona1:addEventListener("touch",sale)
	
	--달고나2제출 후 엔딩씬
	local function sale2( event )
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
					composer.gotoScene("end")
				end
			else
				event.target.x=event.xStart
				event.target.y=event.yStart
			end
		end
	end
	dalgona2:addEventListener("touch",sale2)


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
