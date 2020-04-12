-- TTS Hook
-- Main functionality
function onload()
    buildDataStructure()
    registerObjectGUIDs()
    buildButtons()
end

-- Ensure data structure exists
function buildDataStructure()
    data = {
        White = {
          deck = nil
        },
        Yellow = {
          deck = nil
        },
        Red = {
          deck = nil
        },
        Blue = {
          deck = nil
        },
        Purple = {
          deck = nil
        },
        Green = {
          deck = nil
        }
    }
end

-- Get pointers to in-game objects so we can script them
function registerObjectGUIDs()
    data["White"]["libraryZone"] = getObjectFromGUID("166036")
    data["Yellow"]["libraryZone"] = getObjectFromGUID("2365d0")
    data["Red"]["libraryZone"] = getObjectFromGUID("409503")
    data["Blue"]["libraryZone"] = getObjectFromGUID("60bfe2")
    data["Purple"]["libraryZone"] = getObjectFromGUID("033b34")
    data["Green"]["libraryZone"] = getObjectFromGUID("c04462")

    data["White"]["graveyard"] = getObjectFromGUID("68549d")
    data["Yellow"]["graveyard"] = getObjectFromGUID("07dd80")
    data["Red"]["graveyard"] = getObjectFromGUID("6a7dbe")
    data["Blue"]["graveyard"] = getObjectFromGUID("ec35d8")
    data["Purple"]["graveyard"] = getObjectFromGUID("8b439a")
    data["Green"]["graveyard"] = getObjectFromGUID("debc40")

    data["White"]["playmat"] = getObjectFromGUID("8b3401")
    data["Yellow"]["playmat"] = getObjectFromGUID("c20e3f")
    data["Red"]["playmat"] = getObjectFromGUID("7cffe1")
    data["Blue"]["playmat"] = getObjectFromGUID("b63e9c")
    data["Purple"]["playmat"] = getObjectFromGUID("129eaa")
    data["Green"]["playmat"] = getObjectFromGUID("56cd9d")

    data["White"]["drawButton"] = getObjectFromGUID("2e4a70")
    data["Yellow"]["drawButton"] = getObjectFromGUID("249a89")
    data["Red"]["drawButton"] = getObjectFromGUID("eb4315")
    data["Blue"]["drawButton"] = getObjectFromGUID("67c730")
    data["Purple"]["drawButton"] = getObjectFromGUID("177e38")
    data["Green"]["drawButton"] = getObjectFromGUID("57194f")

    data["White"]["scryButton"] = getObjectFromGUID("ef4330")
    data["Yellow"]["scryButton"] = getObjectFromGUID("c5f9f8")
    data["Red"]["scryButton"] = getObjectFromGUID("6fa145")
    data["Blue"]["scryButton"] = getObjectFromGUID("8ec660")
    data["Purple"]["scryButton"] = getObjectFromGUID("772581")
    data["Green"]["scryButton"] = getObjectFromGUID("b80694")

    data["White"]["dredgeButton"] = getObjectFromGUID("de35fe")
    data["Yellow"]["dredgeButton"] = getObjectFromGUID("8e980d")
    data["Red"]["dredgeButton"] = getObjectFromGUID("b5ea78")
    data["Blue"]["dredgeButton"] = getObjectFromGUID("61ede0")
    data["Purple"]["dredgeButton"] = getObjectFromGUID("ec0de6")
    data["Green"]["dredgeButton"] = getObjectFromGUID("a12036")

    data["White"]["untapButton"] = getObjectFromGUID("2e4eb9")
    data["Yellow"]["untapButton"] = getObjectFromGUID("4b7845")
    data["Red"]["untapButton"] = getObjectFromGUID("e398aa")
    data["Blue"]["untapButton"] = getObjectFromGUID("4f9c73")
    data["Purple"]["untapButton"] = getObjectFromGUID("3c3112")
    data["Green"]["untapButton"] = getObjectFromGUID("e87e90")
end

-- Adds functionality to player buttons
function buildButtons()
    for _color, playerData in pairs(data) do
        createButton(playerData["drawButton"], "Draw", "playerDraw", "Draw")
        createButton(playerData["scryButton"], "Scry", "playerScry", "Scry")
        createButton(playerData["dredgeButton"], "Dredge", "playerDredge", "Dredge")
        createButton(playerData["untapButton"], "Untap", "playerUntap", "")
    end
end

-- Draw a card from given player's deck
function playerDraw(button, playerColor)
    if button == data[playerColor]["drawButton"] then
        local deck = data[playerColor]["deck"]
        if deck == nil then
          broadcastToColor("You got no deck " .. playerColor .. "!", playerColor)
        else
          deck.deal(1, playerColor)
        end
    else
        broadcastToColor("That's not your button " .. playerColor .. "!", playerColor)
    end
end

-- Move a card from the top of the deck to the scry zone
function playerScry(button, playerColor)
    if button == data[playerColor]["scryButton"] then
        local deck = data[playerColor]["deck"]
        local firstCardPresent, firstCard = pcall(deck.takeObject, {flip = true})
        if firstCardPresent then
            local scryZone = Player[playerColor].getHandTransform(2)
            firstCard.setPosition(scryZone.position)
        else
            broadcastToColor("You got no deck " .. playerColor .. "!", playerColor)
        end
    else
        broadcastToColor("That's not your button " .. playerColor .. "!", playerColor)
    end
end

-- Moves a card from the top of the deck to the graveyard
function playerDredge(button, playerColor)
    if button == data[playerColor]["dredgeButton"] then
        local deck = data[playerColor]["deck"]
        local graveyard = data[playerColor]["graveyard"]
        local firstCardPresent, firstCard = pcall(deck.takeObject, {flip = true})
        if firstCardPresent then
            pos_target = graveyard.getPosition()
            pos = {
                x = pos_target.x,
                y = pos_target.y + 2.5,
                z = pos_target.z
            }
            firstCard.setPositionSmooth(pos)
        else
            broadcastToColor("You got no deck " .. playerColor .. "!", playerColor)
        end
    else
        broadcastToColor("That's not your button " .. playerColor .. "!", playerColor)
    end
end

-- Untap all cards on the player's playmat
function playerUntap(button, playerColor)
    if button == data[playerColor]["untapButton"] then
        local playmat = data[playerColor]["playmat"]
        local ry = playmat.getRotation()
        local rr = nil
        for k, v in pairs(playmat.getObjects()) do
            if v.tag == "Card" or v.tag == "Deck" then
                rr = v.getRotation()
                v.setRotationSmooth({x = rr.x, y = ry.y, z = rr.z})
            end
        end
    else
        broadcastToColor("That's not your button " .. playerColor .. "!", playerColor)
    end
end

-- Creates a button with given funcionality on the object
function createButton(object, name, clickFunction, label)
    object.setName(name)
    object.lock()
    return object.createButton(
        {
            click_function = clickFunction, -- string (required),
            label = label, -- string,
            width = 600, -- int,
            height = 600, -- int,
            position = {0, 0.1, 0},
            font_size = 250, -- int,
            color = {255, 255, 255, 0}, -- Color,w
            font_color = {255, 255, 255, 255} -- Color,
        }
    )
end

-- TTS Hook
-- Register a deck when dropped on the library zone
function onObjectEnterScriptingZone(currentZone, object)
    if object.tag == "Deck" then
        for color, playerData in pairs(data) do
            if currentZone == playerData["libraryZone"] then
                playerData["deck"] = object
                object.setName(color .. " Deck")
            end
        end
    end
end

-- TTS Hook
-- Scripting hotkeys
function onScriptingButtonDown(index, playerColor)
  if index == 1 then
    playerUntap(data[playerColor]["untapButton"], playerColor)
  elseif index == 2 then
    playerDraw(data[playerColor]["drawButton"], playerColor)
  elseif index == 3 then
    playerScry(data[playerColor]["scryButton"], playerColor)
  elseif index == 4 then
    playerDredge(data[playerColor]["dredgeButton"], playerColor)
  end
end
