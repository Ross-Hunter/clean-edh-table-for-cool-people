-- Acknowledgements:
-- Based heavily on Amuzet's Table -> https://steamcommunity.com/sharedfiles/filedetails/?id=1430411207

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
  data["Purple"]["libraryZone"] = getObjectFromGUID("033b34")
  data["Green"]["libraryZone"] = getObjectFromGUID("c04462")

  data["White"]["graveyard"] = getObjectFromGUID("68549d")
  data["Yellow"]["graveyard"] = getObjectFromGUID("07dd80")
  data["Purple"]["graveyard"] = getObjectFromGUID("8b439a")
  data["Green"]["graveyard"] = getObjectFromGUID("debc40")

  data["White"]["playmat"] = getObjectFromGUID("8b3401")
  data["Yellow"]["playmat"] = getObjectFromGUID("c20e3f")
  data["Purple"]["playmat"] = getObjectFromGUID("129eaa")
  data["Green"]["playmat"] = getObjectFromGUID("56cd9d")

  data["White"]["drawButton"] = getObjectFromGUID("2e4a70")
  data["Yellow"]["drawButton"] = getObjectFromGUID("249a89")
  data["Purple"]["drawButton"] = getObjectFromGUID("177e38")
  data["Green"]["drawButton"] = getObjectFromGUID("57194f")

  data["White"]["peekButton"] = getObjectFromGUID("ef4330")
  data["Yellow"]["peekButton"] = getObjectFromGUID("c5f9f8")
  data["Purple"]["peekButton"] = getObjectFromGUID("772581")
  data["Green"]["peekButton"] = getObjectFromGUID("b80694")

  data["White"]["millButton"] = getObjectFromGUID("de35fe")
  data["Yellow"]["millButton"] = getObjectFromGUID("8e980d")
  data["Purple"]["millButton"] = getObjectFromGUID("ec0de6")
  data["Green"]["millButton"] = getObjectFromGUID("a12036")

  data["White"]["untapButton"] = getObjectFromGUID("2e4eb9")
  data["Yellow"]["untapButton"] = getObjectFromGUID("4b7845")
  data["Purple"]["untapButton"] = getObjectFromGUID("3c3112")
  data["Green"]["untapButton"] = getObjectFromGUID("e87e90")
end

-- Adds functionality to player buttons
function buildButtons()
  for _color, playerData in pairs(data) do
    createButton(playerData["drawButton"], "Draw", "playerDraw", "")
    createButton(playerData["peekButton"], "Peek", "playerPeek", "")
    createButton(playerData["millButton"], "Mill", "playerMill", "")
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

-- Move a card from the top of the deck to the scry/peek zone
function playerPeek(button, playerColor)
  if button == data[playerColor]["peekButton"] then
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
function playerMill(button, playerColor)
  if button == data[playerColor]["millButton"] then
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
    click_function = clickFunction,
    label = label,
    width = 600,
    height = 600,
    position = {0, 0.1, 0},
    font_size = 250,
    color = {255, 255, 255, 0},
    font_color = {255, 255, 255, 255}
  }
  )
end

-- TTS Hook
-- Register a deck when dropped on the library zone
-- This is the buggiest part of this code.
-- Things can get wonky and picking up and moving it out and back in the deck zone fixes it
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
    playerPeek(data[playerColor]["peekButton"], playerColor)
  elseif index == 4 then
    playerMill(data[playerColor]["millButton"], playerColor)
  end
end
