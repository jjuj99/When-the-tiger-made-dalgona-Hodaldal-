-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:resumeGame(vol)
    --code to resume game

    timer.resume("gameLimit")
	timer.resume("sugarTimer1")
	timer.resume("sugarTimer2")
	timer.resume("sodaTimer1")
	timer.resume("sodaTimer2")
	timer.resume("shapeTimer1")
	timer.resume("shapeTimer2")

end

function scene:create( event )
	local sceneGroup = self.view

	-- 배경 --
	local background = display.newImageRect("Content/Image/MainGame/게임 플레이 예시.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	sceneGroup:insert(background)

	-- 타이머 --
	local timerView = display.newImage("Content/Image/MainGame/시간.png")
	timerView.x, timerView.y = display.contentWidth*0.595, display.contentHeight*0.93

	sceneGroup:insert(timerView)

	-- 점수판 --
	local scoreView = display.newImage("Content/Image/MainGame/돈.png")
	scoreView.x, scoreView.y = display.contentWidth*0.83, display.contentHeight*0.93

	sceneGroup:insert(scoreView)

	-- 브금 --
	local soundFile = audio.loadSound("Content/Sound/BGM/Do Do Do - Silent Partner.mp3")

	local vol = math.floor(audio.getVolume( { channel=1 } ) * 10)
	local bgmOn = audio.isChannelPlaying(1)

	composer.setVariable("bgm", bgmOn)

	if (bgmOn) then
		audio.play(soundFile, {
		channel = 2,
		loops = -1})
		audio.setVolume(vol*0.1, {channel = 2})
	end

	--점수
	local score = 0
	local showScore = display.newText(score, display.contentWidth*0.85, display.contentHeight*0.93)
	showScore:setFillColor(0)
	showScore.size = 80

	sceneGroup:insert(showScore)

	-- 전체 타이머 --
	local limit = 200
	local showLimit = display.newText(limit, display.contentWidth*0.6, display.contentHeight*0.93) 
	showLimit:setFillColor(0) 
	showLimit.size = 80

	sceneGroup:insert(showLimit)

	local function timeAttack( event )
		limit = limit - 1
		showLimit.text = limit
		if(limit == 0) then
			composer.setVariable("complete", false)
			composer.setVariable("score", score)
			composer.gotoScene("end")
		end
	end
	timer.performWithDelay( 1000, timeAttack, 0 , "gameLimit")

	-- *** 도구 소환 *** --

	-- 선반 --
	local shelf = display.newImage("Content/Image/MainGame/선반.png")
	shelf.x, shelf.y = display.contentWidth*0.442, display.contentHeight*0.171

	sceneGroup:insert(shelf)

	-- 불 --
	local fire = display.newImage("Content/Image/MainGame/불 합침.png")
	fire.x, fire.y = display.contentWidth*0.225, display.contentHeight*0.655

	sceneGroup:insert(fire)

	-- 달고나 판 --
	local plates = display.newGroup()

	local plate1 = display.newImage(plates, "Content/Image/MainGame/달고나판1.png")
	plate1.x, plate1.y = display.contentWidth * 0.555, display.contentHeight * 0.63

	local plate2 = display.newImage(plates, "Content/Image/MainGame/달고나판2.png")
	plate2.x, plate2.y = display.contentWidth * 0.776, display.contentHeight * 0.63

	sceneGroup:insert(plates)

	-- 매대 소환--
	local out = display.newImage("Content/Image/MainGame/매대.png")
	out.x, out.y = display.contentWidth*0.95, display.contentHeight*0.505

	sceneGroup:insert(out)

	-- 달고나 소환 --
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

	-- 국자 --
	local ladle1 = display.newImage("Content/Image/MainGame/국자.png")
	ladle1.ladleX, ladle1.ladleY = display.contentWidth*0.07, display.contentHeight*0.56
	ladle1.x, ladle1.y = ladle1.ladleX, ladle1.ladleY
	
	ladle1.full = false -- 국자가 채워진 상태인지 아닌지 구분
	ladle1.sugar = true 
	ladle1.soda = false
	ladle1.burn = false
	ladle1.mix = false

	local ladle2 = display.newImage("Content/Image/MainGame/국자.png")
	ladle2.ladleX, ladle2.ladleY = display.contentWidth*0.27, display.contentHeight*0.56
	ladle2.x, ladle2.y = ladle2.ladleX, ladle2.ladleY

	ladle2.full = false
	ladle2.sugar = true
	ladle2.soda = false
	ladle2.burn = false
	ladle2.mix = false

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

	-- 젓가락 소환 --
	local chapstick = display.newImage("Content/Image/MainGame/젓가락.png")
	chapstickX, chapstickY = display.contentWidth * 0.45, display.contentHeight * 0.165
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

	--설탕 녹는+타는 함수--
	local sugarTime1 = 10
	local function meltSugar1(event)
		if(sugarTime1 >= 0) then
			sugarTime1 = sugarTime1 - 1

			if(sugarTime1 == 7) then
				ladle1.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 덜녹음.png"
				}

			elseif(sugarTime1 == 4) then
				ladle1.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 설탕녹음.png"
				}
			elseif(sugarTime1 < 0) then
				ladle1.burn = true
				ladle1.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 설탕 탐.png"
				}
			end
		end
	end

	local sugarTime2 = 10
	local function meltSugar2(event)
		if(sugarTime2 >= 0) then
			sugarTime2 = sugarTime2 - 1

			if(sugarTime2 == 7) then
				ladle2.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 덜녹음.png"
				}

			elseif(sugarTime2 == 4) then
				ladle2.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 설탕녹음.png"
				}
			elseif(sugarTime2 < 0) then
				ladle2.burn = true
				ladle2.fill = {
					type = "image",
					filename = "Content/Image/MainGame/국자 설탕 탐.png"
				}
			end
		end
	end

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

					if ladle1.full == false then
						ladle1.fill = { 
							type = "image",
							filename = "Content/Image/MainGame/국자 설탕.png"
						}

						-- 시간제한 시작 --
						sugarTime1 = 10
						timer.performWithDelay( 1000, meltSugar1, 0	, "sugarTimer1")
					end

					-- 설탕 원위치 --
					event.target.x = sugarX
					event.target.y = sugarY

					ladle1.sugar = true -- 설탕이 채워졌는지 --
					ladle1.full = true

				elseif event.target.x < ladle2.x + 200 and event.target.x > ladle2.x - 200
						and event.target.y < ladle2.y + 200 and event.target.y > ladle2.y - 200 then

					if ladle2.full == false then

						ladle2.fill = { 
							type = "image",
							filename = "Content/Image/MainGame/국자 설탕.png"
						}

						-- 시간제한 시작 --
						sugarTime2 = 10
						timer.performWithDelay( 1000, meltSugar2, 0 , "sugarTimer2")
					end

					-- 설탕 원위치 --
					event.target.x = sugarX
					event.target.y = sugarY

					ladle2.sugar = true
					ladle2.full = true

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

	--소다가 녹는+타는 함수--
	local sodaTime1 = 9
	local function meltSoda1(event)
		if(ladle1.sugar == true and ladle1.burn == false) then
			if(sodaTime1 >= 0) then
				sodaTime1 = sodaTime1 - 1
	
				if(sodaTime1 == 6) then
					ladle1.fill = {
						type = "image",
						filename = "Content/Image/MainGame/국자 소다 녹는중.png"
					}
	
				elseif(sodaTime1 == 3) then
					ladle1.mix = true
					ladle1.fill = {
						type = "image",
						filename = "Content/Image/MainGame/국자 달고나.png"
					}
	
				elseif(sodaTime1 == 0) then
					ladle1.burn = true
					ladle1.fill = {
						type = "image",
						filename = "Content/Image/MainGame/국자 달고나 탐.png"
					}
				end
			end
		end
	end
	local sodaTime2 = 9
	local function meltSoda2(event)
		if(ladle2.sugar == true and ladle2.burn == false) then
			if(sodaTime2 >= 0) then
				sodaTime2 = sodaTime2 - 1
	
				if(sodaTime2 == 6) then
					ladle2.fill = {
						type = "image",
						filename = "Content/Image/MainGame/국자 소다 녹는중.png"
					}
	
				elseif(sodaTime2 == 3) then
					ladle2.mix = true
					ladle2.fill = {
						type = "image",
						filename = "Content/Image/MainGame/국자 달고나.png"
					}
				elseif(sodaTime2 == 0) then
					ladle2.burn = true
					ladle2.fill = {
						type = "image",
						filename = "Content/Image/MainGame/국자 달고나 탐.png"
					}
				end
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
						sodaTime1 = 9
						timer.performWithDelay( 1000, meltSoda1, 0 , "sodaTimer1")

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
						sodaTime2 = 9
						timer.performWithDelay( 1000, meltSoda2, 0 , "sodaTimer2")

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

					if (ladle1.soda == true ) then
						timer.cancel("sugarTimer1")
					end
					if (ladle2.soda == true) then
						timer.cancel("sugarTimer2")
					end

				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end
	end
	
	chapstick: addEventListener("touch", putSoda)

	dalgona1.success = true
	dalgona2.success = true

	-- 국자의 달고나를 판에 올리는 함수 --
	local function settingD(event)
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
				--설탕달고나 설탕O, 소다X, 태우기X
				--설탕탄달고나 설탕O, 소다X, 태우기O
				--소다덜섞달고나 설탕O, 소다O, 태우기X
				--탄달고나 설탕O, 소다O, 태우기O
				--왼쪽 판put
				if event.target.x < plate1.x + 100 and event.target.x > plate1.x - 100
					and event.target.y < plate1.y + 100 and event.target.y > plate1.y - 100 then
					--판에 달고나가 없을 때만 실행
					if (dalgona1.alpha == 0 and event.target.sugar == true) then
						dalgona1.alpha = 1
						if event.target.soda == false then
							if event.target.burn == false then
								dalgona1.fill = {
									type = "image",
									filename = "Content/Image/MainGame/달고나판 설탕만.png"
								}
							else
								dalgona1.fill = {
									type = "image",
									filename = "Content/Image/MainGame/달고나판 설탕 탐.png"--탄 설탕
								}
							end
						elseif event.target.mix == false then
							dalgona1.fill = {
								type = "image",
								filename = "Content/Image/MainGame/달고나판 소다덜섞인.png"
							}
						elseif event.target.burn == true then
							dalgona1.fill = {
								type = "image",
								filename = "Content/Image/MainGame/달고나 덩어리 탐.png"--탄 달고나
							}
						else
							dalgona1.fill = {
								type = "image",
								filename = "Content/Image/MainGame/달고나 덩어리.png"
							}
						end
						
						print("달고나 놓기")


						dalgona1.x, dalgona1.y = dalgona1.dalgonaX, dalgona1.dalgonaY

						event.target.fill = {
							type = "image",
							filename = "Content/Image/MainGame/국자.png"
						}

						if(event.target == ladle1) then
							timer.cancel("sugarTimer1")
							timer.cancel("sodaTimer1")
						elseif(event.target == ladle2) then
							timer.cancel("sugarTimer2")
							timer.cancel("sodaTimer2")
						end
					end

				elseif event.target.x < plate2.x + 100 and event.target.x > plate2.x - 100
					and event.target.y < plate2.y + 100 and event.target.y > plate2.y - 100 then
					--판2에 달고나가 없을 때만 실행
					if dalgona2.alpha == 0 then
						dalgona2.alpha = 1
						if event.target.soda == false then
							if event.target.burn == false then
								dalgona2.fill = {
									type = "image",
									filename = "Content/Image/MainGame/달고나판 설탕만.png"
								}
							else
								dalgona2.fill = {
									type = "image",
									filename = "Content/Image/MainGame/달고나판 설탕 탐.png"--탄 설탕
								}
							end
						elseif event.target.mix == false then
							dalgona2.fill = {
								type = "image",
								filename = "Content/Image/MainGame/달고나판 소다덜섞인.png"
							}
						elseif event.target.burn == true then
							dalgona2.fill = {
								type = "image",
								filename = "Content/Image/MainGame/달고나 덩어리 탐.png"--탄 달고나
							}
						else
							dalgona2.fill = {
								type = "image",
								filename = "Content/Image/MainGame/달고나 덩어리.png"
							}
						end

						print("달고나 놓기2")

						dalgona2.x, dalgona2.y = dalgona2.dalgonaX, dalgona2.dalgonaY

						event.target.fill = {
							type = "image",
							filename = "Content/Image/MainGame/국자.png"
						}

						if(event.target == ladle1) then
							timer.cancel("sugarTimer1")
							timer.cancel("sodaTimer1")
						elseif(event.target == ladle2) then
							timer.cancel("sugarTimer2")
							timer.cancel("sodaTimer2")
						end
					end
				end
				--국자 원위치
				event.target.x = event.target.ladleX
				event.target.y = event.target.ladleY

				event.target.sugar = false
				event.target.melt = false
				event.target.soda = false
				event.target.burn = false
				event.target.mix = false
				event.target.full = false

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end

			event.target.x = event.target.ladleX
			event.target.y = event.target.ladleY

			display.getCurrentStage():setFocus(nil)
			event.target.isFocus = false
		end
	end

	ladle1: addEventListener("touch", settingD)
	ladle2: addEventListener("touch", settingD)

	-- 누르고 다서 모양틀 전까지 시간 제한 --
	local shapeLimit1 = 3
	local shapeLimit2 = 3

	local function shapeTimeAttack1( event )
		if(shapeLimit1 >= 0) then
			shapeLimit1 = shapeLimit1 - 1

			if(shapeLimit1 == 0) then
				-- 시간 경과하면 단단해진 달고나로 --
				dalgona1.success = false
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

			if(shapeLimit2 == 0) then
				-- 시간 경과하면 단단해진 달고나로 --
				dalgona2.success = false
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
						and event.target.y < dalgona1.y + 100 and event.target.y > dalgona1.y - 100 and dalgona1.success then

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
						and event.target.y < dalgona2.y + 100 and event.target.y > dalgona2.y - 100 and dalgona2.success then

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
							dalgona1.success = false
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
						dalgona1.success = false
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
							dalgona2.success = false
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
						dalgona2.success = false
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
	
	--달고나 

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
				if event.target.x<out.x+200 and event.target.x>out.x-200
					and event.target.y<out.y+1000 and event.target.y>out.y-1000 then
							
					event.target.alpha = 0

					event.target.x=event.target.dalgonaX
					event.target.y=event.target.dalgonaY

					if event.target.success then
						score = score + 1000
					end

					event.target.success = true
					event.target.press = false
					event.target.hard = false

					--점수계산
					showScore.text = score
				else
					event.target.x=event.target.dalgonaX
					event.target.y=event.target.dalgonaY
				end
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
		end
	end

	dalgona1:addEventListener("touch",sale)
	dalgona2:addEventListener("touch",sale)

	-- 일시정지 --
	local function openPause( event )

		timer.pause("gameLimit")
		timer.pause("sugarTimer1")
		timer.pause("sugarTimer2")
		timer.pause("sodaTimer1")
		timer.pause("sodaTimer2")
		timer.pause("shapeTimer1")
		timer.pause("shapeTimer2")

		local options = {
		    isModal = true,
		    effect = "fade",
		    time = 400,
		    params = {
		        vol = vol,
				bgm = bgmOn
		    }
		}

		composer.showOverlay("pause", options)
	end
	
	local pauseBtn = display.newImage("Content/Image/MainGame/PauseView/일시중지.png")
	pauseBtn.x, pauseBtn.y = display.contentWidth*0.95, display.contentHeight*0.08

	sceneGroup:insert(pauseBtn)

	pauseBtn:addEventListener("tap", openPause)

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


		audio.pause(2)

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
