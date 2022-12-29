--guigettext .. addednum

local DOTMATRI = guiCreateFont( "DOTMATRI.TTF", 20 )

local keyMarker = createMarker ( 2142.21216, 1626.74673, 993.6881, "corona", 0.5, 255, 255, 0, 0 )
setElementInterior(keyMarker, 1)

local moneyMarkers = {}

local keyWindow = {}
local keyNumbers
local attemptsLabel
local lastnumLabel

local canwrite = true

local lastNumber = 0
local attempts = 0

function resetMarker()
	keyMarker = createMarker ( 2142.21216, 1626.74673, 993.6881, "corona", 0.5, 255, 255, 0, 0 )
	setElementInterior(keyMarker, 1)
end

function MarkerHit ( hitPlayer, matchingDimension )
	if(hitPlayer == localPlayer) then
		if(source == keyMarker) then
			if(isElement(keyWindow[hitPlayer]) == false) then
				canwrite = true
				keyWindow[hitPlayer] = guiCreateWindow ( 0.4, 0.33, 0.2, 0.4, "Bank Security - Keypad", true )
				guiCreateLabel(0.3,0.05,0.4,0.2,"Enter the correct password",true, keyWindow[hitPlayer])
				guiCreateStaticImage(0.125,0.1,0.75,0.15, "lcd.png", true, keyWindow[hitPlayer])
				keyNumbers = guiCreateLabel(0.125,0.14,0.75,0.15, "", true, keyWindow[hitPlayer])
				guiSetFont ( keyNumbers, DOTMATRI )
				guiLabelSetHorizontalAlign(keyNumbers,"center")
				guiLabelSetColor (keyNumbers, 200, 200, 200)
				showCursor(true)
				
				button1 = guiCreateButton( 0.25, 0.3, 0.1, 0.1, "1", true, keyWindow[hitPlayer])
				button2 = guiCreateButton( 0.45, 0.3, 0.1, 0.1, "2", true, keyWindow[hitPlayer])
				button3 = guiCreateButton( 0.65, 0.3, 0.1, 0.1, "3", true, keyWindow[hitPlayer])
				
				button4 = guiCreateButton( 0.25, 0.45, 0.1, 0.1, "4", true, keyWindow[hitPlayer])
				button5 = guiCreateButton( 0.45, 0.45, 0.1, 0.1, "5", true, keyWindow[hitPlayer])
				button6 = guiCreateButton( 0.65, 0.45, 0.1, 0.1, "6", true, keyWindow[hitPlayer])
				
				button7 = guiCreateButton( 0.25, 0.6, 0.1, 0.1, "7", true, keyWindow[hitPlayer])
				button8 = guiCreateButton( 0.45, 0.6, 0.1, 0.1, "8", true, keyWindow[hitPlayer])
				button9 = guiCreateButton( 0.65, 0.6, 0.1, 0.1, "9", true, keyWindow[hitPlayer])
				
				buttonClear = guiCreateButton( 0.25, 0.75, 0.1, 0.1, "Clear", true, keyWindow[hitPlayer])
				button0 = guiCreateButton( 0.45, 0.75, 0.1, 0.1, "0", true, keyWindow[hitPlayer])
				buttonOK = guiCreateButton( 0.65, 0.75, 0.1, 0.1, "OK", true, keyWindow[hitPlayer])
				
				buttonX = guiCreateButton( 0.93, 0.93, 0.05, 0.05, "X", true, keyWindow[hitPlayer])
				addEventHandler ( "onClientGUIClick", button1, buttonClick )
				addEventHandler ( "onClientGUIClick", button2, buttonClick )
				addEventHandler ( "onClientGUIClick", button3, buttonClick )
				addEventHandler ( "onClientGUIClick", button4, buttonClick )
				addEventHandler ( "onClientGUIClick", button5, buttonClick )
				addEventHandler ( "onClientGUIClick", button6, buttonClick )
				addEventHandler ( "onClientGUIClick", button7, buttonClick )
				addEventHandler ( "onClientGUIClick", button8, buttonClick )
				addEventHandler ( "onClientGUIClick", button9, buttonClick )
				addEventHandler ( "onClientGUIClick", button0, buttonClick )
				addEventHandler ( "onClientGUIClick", buttonClear, buttonClick )
				addEventHandler ( "onClientGUIClick", buttonOK, buttonClick )
				addEventHandler ( "onClientGUIClick", buttonX, buttonClick )
				attemptsLabel = guiCreateLabel(0.1,0.89,0.8,0.2,"Attempts: " .. attempts, true, keyWindow[hitPlayer])
				lastnumLabel = guiCreateLabel(0.1,0.95,0.8,0.2,"Last number: " .. lastNumber, true, keyWindow[hitPlayer])
			end
		end
		for k, v in ipairs(moneyMarkers) do 
			if source == v then
				callServerFunction("givePrize", hitPlayer)
				destroyElement(v)
				playSound("money.mp3")
			end
		end 
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

function buttonClick ()
	if canwrite == false then return end
	if(guiLabelGetTextExtent(keyNumbers) <= 250) then
        if source == button0 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "0")
			playSound("key1.mp3")
		end
		if source == button1 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "1")
			playSound("key1.mp3")
		end
		if source == button2 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "2")
			playSound("key1.mp3")
		end
		if source == button3 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "3")
			playSound("key1.mp3")
		end
		if source == button4 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "4")
			playSound("key1.mp3")
		end
		if source == button5 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "5")
			playSound("key1.mp3")
		end
		if source == button6 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "6")
			playSound("key1.mp3")
		end
		if source == button7 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "7")
			playSound("key1.mp3")
		end
		if source == button8 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "8")
			playSound("key1.mp3")
		end
		if source == button9 then
			guiSetText(keyNumbers, guiGetText(keyNumbers) .. "9")
			playSound("key1.mp3")
		end
		
		if source == buttonClear then
			guiSetText(keyNumbers, "")
			playSound("key1.mp3")
		end
		
		if source == buttonOK then
			if(guiGetText(keyNumbers) ~= "" and tonumber(guiGetText(keyNumbers))) then
				lastNumber = guiGetText(keyNumbers)
				attempts = attempts + 1
				callServerFunction("checkNumber", localPlayer, guiGetText(keyNumbers), attempts)
				guiSetText(attemptsLabel, "Attempts: " .. attempts)
				guiSetText(lastnumLabel, "Last number: " .. lastNumber)
			else
				guiLabelSetColor (keyNumbers, 200, 0, 0)
				guiSetText(keyNumbers, "EMPTY!")
				playSound("keyerr.mp3")
				canwrite = false
				setTimer(function()
					guiLabelSetColor (keyNumbers, 200, 200, 200)
					guiSetText(keyNumbers, "")
					canwrite = true
				end, 1000, 1)
			end
		end
		
		if source == buttonX then
			showCursor(false)
			destroyElement(keyWindow[localPlayer])
			playSound("key1.mp3")
		end
	else
		guiLabelSetColor (keyNumbers, 200, 0, 0)
		guiSetText(keyNumbers, "TOO LONG!")
		canwrite = false
		playSound("keyerr.mp3")
		setTimer(function()
			guiLabelSetColor (keyNumbers, 200, 200, 200)
			guiSetText(keyNumbers, "")
			canwrite = true
		end, 1000, 1)
	end
end

function checkReturn(number)
	if(number == -1) then
			guiLabelSetColor (keyNumbers, 200, 0, 0)
			guiSetText(keyNumbers, "HIGHER!")
			playSound("keyerr.mp3")
			canwrite = false
			setTimer(function()
				guiLabelSetColor (keyNumbers, 200, 200, 200)
				guiSetText(keyNumbers, "")
				canwrite = true
			end, 1000, 1)
		elseif(number == 1) then
			guiLabelSetColor (keyNumbers, 200, 0, 0)
			guiSetText(keyNumbers, "LOWER!")
			playSound("keyerr.mp3")
			canwrite = false
			setTimer(function()
				guiLabelSetColor (keyNumbers, 200, 200, 200)
				guiSetText(keyNumbers, "")
				canwrite = true
			end, 1000, 1)
		elseif(number == 0) then
			guiLabelSetColor (keyNumbers, 0, 200, 0)
			guiSetText(keyNumbers, "CORRECT!")
			playSound("keyok.mp3")
			canwrite = false
			setTimer(function()
				guiLabelSetColor (keyNumbers, 200, 200, 200)
				guiSetText(keyNumbers, "")
				showCursor(false)
				canwrite = true
				destroyElement(keyWindow[localPlayer])
				callServerFunction("moveDoor", localPlayer)
				playSound("opening.mp3")
				destroyElement(keyMarker)
				moneyMarkers[8] = createMarker(2141.21777, 1629.35486, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				moneyMarkers[1] = createMarker(2141.21606, 1633.51892, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				moneyMarkers[2] = createMarker(2141.20386, 1637.25635, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				moneyMarkers[3] = createMarker(2141.21118, 1641.21887, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				moneyMarkers[4] = createMarker(2147.16089, 1629.35486, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				moneyMarkers[5] = createMarker(2147.16089, 1633.51892, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				moneyMarkers[6] = createMarker(2147.16089, 1637.25635, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				moneyMarkers[7] = createMarker(2147.16089, 1641.21887, 993.57611, "corona", 0.5, 255, 255, 0, 170 )
				setElementInterior(moneyMarkers[8], 1)
				setElementInterior(moneyMarkers[1], 1)
				setElementInterior(moneyMarkers[2], 1)
				setElementInterior(moneyMarkers[3], 1)
				setElementInterior(moneyMarkers[4], 1)
				setElementInterior(moneyMarkers[5], 1)
				setElementInterior(moneyMarkers[6], 1)
				setElementInterior(moneyMarkers[7], 1)
				outputChatBox("#77b5fe[Bank-Security]: #e07a5fYou have 1 minute to clear the vault!",_,_,_,true)
		end, 1000, 1)
	end
end

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key,value in next, arg do
            if (type(value)=="number") then arg[key] = tostring(value) end
        end
    end
    triggerServerEvent("onClientCallsServerFunction",resourceRoot,funcname,unpack(arg))
end

function callClientFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key,value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onServerCallsClientFunction",true)
addEventHandler("onServerCallsClientFunction",resourceRoot,callClientFunction)