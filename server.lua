local safeDoor = createObject(2634, 2144.18, 1626.99719, 994.27, 180, 0, 0)
local keyPad = createObject(2922, 2142.18, 1626.82, 994.27, 0, 0, 180)
setElementInterior(safeDoor, 1)
setElementInterior(keyPad, 1)
local randomNum = 0

local minNum = 10000 			--THE MINIMUM RANDOM KEYNUMBER
local maxNum = 1000000			--THE MAXIMUM RANDOM KEYNUMBER

local takeMoney = 1000			--How much money u want to take from player
local takeHealth = 5			--How much hp u want to take from player

local prizeMin = 1000			--Minimum random prize
local prizeMax = 10000			--Maximum random prize

function setRandomNumber()
	randomNum = math.random(minNum,maxNum)
end

addEventHandler ( "onResourceStart", root, setRandomNumber )

function checkNumber(player, number, attempts)
	if(number < randomNum) then
		callClientFunction(player, "checkReturn", -1)
		if(math.fmod (attempts, 3) == 0) then
			setPlayerMoney(player, getPlayerMoney(player) - takeMoney)
			setElementHealth(player, getElementHealth(player) - takeHealth)
		end
		if(math.fmod (attempts, 10) == 0) then
			setElementPosition(player,2192.66968, 1677.10083, 12.36719)
			setElementInterior(player, 0)
		end
	elseif(number > randomNum) then
		callClientFunction(player, "checkReturn", 1)
		if(math.fmod (attempts, 3) == 0) then
			setPlayerMoney(player, getPlayerMoney(player) - takeMoney)
			setElementHealth(player, getElementHealth(player) - takeHealth)
		end
		if(math.fmod (attempts, 10)) then
			setElementPosition(player,2192.66968, 1677.10083, 12.36719)
			setElementInterior(player, 0)
			attempts = 0
		end
	elseif number == randomNum then
		callClientFunction(player, "checkReturn", 0)
	end
end

function moveDoor(player)
	local origX, origY, origZ = getElementPosition ( safeDoor )
	local newZ = origZ - 3.1
	moveObject ( safeDoor, 5000, origX, origY, newZ )
	outputChatBox("#77b5fe[Bank-Security]: #5a19ff" .. getPlayerName(player).. "#77b5fe succesfully cracked the bank vault code!",root, _, _, _, true)
	setTimer(function()
		moveObject ( safeDoor, 5000, origX, origY, origZ )
		callClientFunction(player, "resetMarker")
		setRandomNumber()
	end, 1000*60, 1)
end

function givePrize(player)
	local randomprize = math.random(prizeMin, prizeMax)
	setPlayerMoney(player, getPlayerMoney(player) + randomprize)
	outputChatBox("#77b5fe[Bank-Security]: You've got #7e9648$" .. randomprize ,player, _, _, _, true)
end

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onClientCallsServerFunction", true)
addEventHandler("onClientCallsServerFunction", resourceRoot , callServerFunction)

function callClientFunction(client, funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    triggerClientEvent(client, "onServerCallsClientFunction", resourceRoot, funcname, unpack(arg or {}))
end

function showKeyCode ( playerSource, commandName )
	if isObjectInACLGroup ( "user." .. getAccountName ( getPlayerAccount ( playerSource ) ), aclGetGroup ( "Admin" )) then 
		outputChatBox("#4488cc[Bank-Security-Admin]: The key is: #39ff14" .. randomNum, playerSource, 255, 255, 255, true)
	end
end

addCommandHandler ( "keycode", showKeyCode )