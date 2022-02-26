-----------------------------------------------------------------------------------------
--
-- end.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--local score = composer.getVariable( "score" )
	local score = 12000

	--배경
	local background

	if(score >= 10000) then
		background = display.newImage("Content/Image/Ending/성공.png", display.contentWidth/2, display.contentHeight/2)
	else
		background = display.newImage("Content/Image/Ending/실패.png", display.contentWidth/2, display.contentHeight/2)
	end

	sceneGroup:insert(background)

	-- 점수판 --
	local money = display.newImage("Content/Image/Ending/엔딩 점수판.png", display.contentWidth/2, display.contentHeight*0.68)

	sceneGroup:insert(money)

	local showScore = display.newText(score, display.contentWidth*0.5, display.contentHeight*0.69)
	showScore:setFillColor(0)
	showScore.size = 65

	sceneGroup:insert(showScore)

	--재시작
	local retry = display.newImage("Content/Image/Ending/엔딩 재시작.png" , display.contentWidth*0.433, display.contentHeight*0.867)
	retry.width = 369
	retry.height = 144

	sceneGroup:insert(retry)

	--홈버튼
	local homeBtn = display.newImage("Content/Image/Ending/엔딩 홈.png" , display.contentWidth*0.644, display.contentHeight*0.867)
	homeBtn.width = 144
	homeBtn.height = 144

	sceneGroup:insert(homeBtn)

	--씬 이동
	local function re(event)
		composer.gotoScene("game")
	end
	retry:addEventListener("tap", re)
	
	local function home(event)
		print("홈")
		composer.gotoScene("start")
	end
	homeBtn:addEventListener("tap", home)


	--[[
	
	--배경
	local background = display.newRect( display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	--성공 또는 실패
	--local score = composer.getVariable( "score" )
	score = 0

	if(score >= 10000) then
		local win = display.newImage("Content/Image/Ending/성공.png", display.contentWidth/2, display.contentHeight/2)
		win.width = display.contentWidth
		win.height = display.contentHeight
		local money = display.newImage("Content/Image/Ending/엔딩 점수판.png", display.contentWidth/2, display.contentHeight*0.68)
		money.width = 400
		money.height = 100

		sceneGroup:insert(win)
		sceneGroup:insert(money)
	else
		local fail = display.newImage("Content/Image/Ending/엔딩화면 예시.png" , display.contentWidth/2, display.contentHeight/2)
		fail.width = display.contentWidth
		fail.height = display.contentHeight

		sceneGroup:insert(fail)
	end

	local showScore = display.newText(score, display.contentWidth*0.5, display.contentHeight*0.69)
	showScore:setFillColor(0)
	showScore.size = 65

	sceneGroup:insert(showScore)

	--재시작버튼
	local retry = display.newImage("Content/Image/Ending/엔딩 재시작.png" , display.contentWidth*0.433, display.contentHeight*0.867)
	retry.width = 369
	retry.height = 144

	sceneGroup:insert(retry)

	--엔딩홈버튼
	local home = display.newImage("Content/Image/Ending/엔딩 홈.png" , display.contentWidth*0.644, display.contentHeight*0.867)
	home.width = 144
	home.height = 144

	sceneGroup:insert(home)

	
	--씬 이동
	local function re(event)
		composer.gotoScene("game")
	end
	retry:addEventListener("tap", re)
	
	local function hom(event)
		composer.gotoScene("start")
	end
	retry:addEventListener("tap", hom)

	
	-- create some text
	local title = display.newText( "Second View", display.contentCenterX, 125, native.systemFont, 32 )
	title:setFillColor( 0 )	-- black

	local newTextParams = { text = "Loaded by the second tab's\n\"onPress\" listener\nspecified in the 'tabButtons' table", 
							x = display.contentCenterX + 10, 
							y = title.y + 215, 
							width = 310, 
							height = 310, 
							font = native.systemFont, 
							fontSize = 14, 
							align = "center" }
	local summary = display.newText( newTextParams )
	summary:setFillColor( 0 ) -- black
	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( summary )


	]]--


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
