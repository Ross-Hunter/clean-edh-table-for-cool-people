function onload()
    registerObjectGUIDs()
    createDrawButtons()
    createScryButtons()
    createDredgeButtons()
    createUntapButtons()
end

function registerObjectGUIDs()
  redDeckZone = getObjectFromGUID('409503')
  yellowDeckZone = getObjectFromGUID('2365d0')
  whiteDeckZone = getObjectFromGUID("166036")
  greenDeckZone = getObjectFromGUID("c04462")
  purpleDeckZone = getObjectFromGUID('033b34')
  blueDeckZone = getObjectFromGUID('60bfe2')

  whiteGraveyard = getObjectFromGUID('68549d')
  yellowGraveyard = getObjectFromGUID('07dd80')
  redGraveyard = getObjectFromGUID('6a7dbe')
  blueGraveyard = getObjectFromGUID('ec35d8')
  purpleGraveyard = getObjectFromGUID('8b439a')
  greenGraveyard = getObjectFromGUID('debc40')

  redDrawButton = getObjectFromGUID('eb4315')
  yellowDrawButton = getObjectFromGUID('249a89')
  whiteDrawButton = getObjectFromGUID('2e4a70')
  greenDrawButton = getObjectFromGUID('57194f')
  purpleDrawButton = getObjectFromGUID('177e38')
  blueDrawButton = getObjectFromGUID('67c730')

  redScryButton = getObjectFromGUID('6fa145')
  blueScryButton = getObjectFromGUID('8ec660')
  whiteScryButton = getObjectFromGUID('ef4330')
  purpleScryButton = getObjectFromGUID('772581')
  yellowScryButton = getObjectFromGUID('c5f9f8')
  greenScryButton = getObjectFromGUID('b80694')

  whiteDredgeButton = getObjectFromGUID('de35fe')
  yellowDredgeButton = getObjectFromGUID('8e980d')
  redDredgeButton = getObjectFromGUID('b5ea78')
  blueDredgeButton = getObjectFromGUID('61ede0')
  purpleDredgeButton = getObjectFromGUID('ec0de6')
  greenDredgeButton = getObjectFromGUID('a12036')

  whitePlaymat = getObjectFromGUID('8b3401')
  yellowPlaymat = getObjectFromGUID('c20e3f')
  redPlaymat = getObjectFromGUID('7cffe1')
  bluePlaymat = getObjectFromGUID('b63e9c')
  purplePlaymat = getObjectFromGUID('129eaa')
  greenPlaymat = getObjectFromGUID('56cd9d')

  whiteUntapButton = getObjectFromGUID('2e4eb9')
  yellowUntapButton = getObjectFromGUID('4b7845')
  redUntapButton = getObjectFromGUID('e398aa')
  blueUntapButton = getObjectFromGUID('4f9c73')
  purpleUntapButton = getObjectFromGUID('3c3112')
  greenUntapButton = getObjectFromGUID('e87e90')
end

function createDrawButtons()
  redDrawButton = createButtonTTS(redDrawButton, 'Draw', 'redDraw', 'Draw')
  yellowDrawButton = createButtonTTS(yellowDrawButton, 'Draw', 'yellowDraw', 'Draw')
  whiteDrawButton = createButtonTTS(whiteDrawButton, 'Draw', 'whiteDraw', 'Draw')
  greenDrawButton = createButtonTTS(greenDrawButton, 'Draw', 'greenDraw', 'Draw')
  purpleDrawButton = createButtonTTS(purpleDrawButton, 'Draw', 'purpleDraw', 'Draw')
  blueDrawButton = createButtonTTS(blueDrawButton, 'Draw', 'blueDraw', 'Draw')
end

function createScryButtons()
  redScryButton = createButtonTTS(redScryButton, "Scry", "redScry", 'Scry')
  blueScryButton = createButtonTTS(blueScryButton, "Scry", "blueScry", 'Scry')
  whiteScryButton = createButtonTTS(whiteScryButton, "Scry", "whiteScry", 'Scry')
  purpleScryButton = createButtonTTS(purpleScryButton, "Scry", "purpleScry", 'Scry')
  yellowScryButton = createButtonTTS(yellowScryButton, "Scry", "yellowScry", 'Scry')
  greenScryButton = createButtonTTS(greenScryButton, "Scry", "greenScry", 'Scry')
end

function createDredgeButtons()
  whiteDredgeButton = createButtonTTS(whiteDredgeButton, "Dredge", "whiteDredge", 'Dredge')
  yellowDredgeButton = createButtonTTS(yellowDredgeButton, "Dredge", "yellowDredge", 'Dredge')
  redDredgeButton = createButtonTTS(redDredgeButton, "Dredge", "redDredge", 'Dredge')
  blueDredgeButton = createButtonTTS(blueDredgeButton, "Dredge", "blueDredge", 'Dredge')
  purpleDredgeButton = createButtonTTS(purpleDredgeButton, "Dredge", "purpleDredge", 'Dredge')
  greenDredgeButton = createButtonTTS(greenDredgeButton, "Dredge", "greenDredge", 'Dredge')
end

function createUntapButtons()
  whiteUntapButton = createButtonTTS(whiteUntapButton, "Untap", "untapWhite", "")
  yellowUntapButton = createButtonTTS(yellowUntapButton, "Untap", "untapYellow", "")
  redUntapButton = createButtonTTS(redUntapButton, "Untap", "untapRed", "")
  blueUntapButton = createButtonTTS(blueUntapButton, "Untap", "untapBlue", "")
  purpleUntapButton = createButtonTTS(purpleUntapButton, "Untap", "untapPurple", "")
  greenUntapButton = createButtonTTS(greenUntapButton, "Untap", "untapGreen", "")
end

-- Untaps
function untapWhite()
  untap(whitePlaymat)
end

function untapYellow()
  untap(yelloPlaymat)
end

function untapRed()
  untap(redPlaymat)
end

function untapBlue()
  untap(bluePlaymat)
end

function untapPurple()
  untap(purplePlaymat)
end

function untapBlue()
  untap(bluePlaymat)
end

function untapGreen()
  untap(greenPlaymat)
end

function untap(zone)
  local ry = zone.getRotation()
  local rr = nil
  for k,v in pairs(zone.getObjects()) do
    if v.tag == 'Card' or v.tag == 'Deck' then
      rr = v.getRotation()
      v.setRotationSmooth({x=rr.x,y=ry.y,z=rr.z})
    end
  end
end

-- Draws
function redDraw()
  redDeck.deal(1, "Red")
end

function yellowDraw()
  yellowDeck.deal(1, "Yellow")
end

function greenDraw()
  greenDeck.deal(1, "Green")
end

function blueDraw()
  blueDeck.deal(1, "Blue")
end

function purpleDraw()
  purpleDeck.deal(1, "Purple")
end

function whiteDraw()
  whiteDeck.deal(1, "White")
end

-- Scrys
function redScry()
  scry(redDeck, Player["Red"])
end

function whiteScry()
  scry(whiteDeck, Player["White"])
end

function purpleScry()
  scry(purpleDeck, Player["Purple"])
end

function yellowScry()
  scry(yellowDeck, Player["Yellow"])
end

function blueScry()
  scry(blueDeck, Player["Blue"])
end

function greenScry()
  scry(greenDeck, Player["Green"])
end

-- Move a card from the top of the deck to the scry zone
function scry(deck, player)
  local firstCardPresent, firstCard = pcall(deck.takeObject, {index=0})
  if firstCardPresent then
    local scryZone = player.getHandTransform(2).position
    firstCard.setPosition(scryZone)
    firstCard.flip()
  else
    print('You got no deck')
  end
end

-- Dredges
function whiteDredge()
  dredge(whiteDeck, whiteGraveyard)
end

function yellowDredge()
  dredge(yellowDeck, yellowGraveyard)
end

function redDredge()
  dredge(redDeck, redGraveyard)
end

function blueDredge()
  dredge(blueDeck, blueGraveyard)
end

function purpleDredge()
  dredge(purpleDeck, purpleGraveyard)
end

function greenDredge()
  dredge(greenDeck, greenGraveyard)
end

-- Moves a card from the top of the deck to the given graveyard
function dredge(deck, graveyard)
  local firstCardPresent, firstCard = pcall(deck.takeObject, {index=0})
  if firstCardPresent then
    firstCard.flip()
    pos_target = graveyard.getPosition()
    pos = {
        x = pos_target.x,
        y = pos_target.y + 3,
        z = pos_target.z,
    }
    firstCard.setPositionSmooth(pos)
  else
    print('You got no deck')
  end
end

-- Creates a button with given funcionality
function createButtonTTS(button, name, clickFunction, label)
  button.setName(functionality)
  button.lock()
  return button.createButton({
    click_function = clickFunction, -- string (required),
    label          = label, -- string,
    width          = 600, -- int,
    height         = 600, -- int,
    position       = {0,0.1,0},
    font_size      = 250, -- int,
    color          = {255,255,255,0}, -- Color,w
    font_color     = {255,255,255,255} -- Color,
  })
end

-- Registers decks when dropped on the deck zones
function onObjectEnterScriptingZone(currentZone, object)
  if currentZone == redDeckZone then
      if object.tag == "Deck" then
        redDeck = object
        object.setName("Red Deck")
      end
  end

  if currentZone == yellowDeckZone then
      if object.tag == "Deck" then
        yellowDeck = object
        object.setName("Yellow Deck")
      end
  end

  if currentZone == whiteDeckZone then
      if object.tag == "Deck" then
        whiteDeck = object
        object.setName("White Deck")
      end
  end

  if currentZone == greenDeckZone then
      if object.tag == "Deck" then
        object.setName("Green Deck")
        greenDeck = object
      end
  end

  if currentZone == purpleDeckZone then
      if object.tag == "Deck" then
        object.setName("Purple Deck")
        purpleDeck = object
      end
  end

  if currentZone == blueDeckZone then
      if object.tag == "Deck" then
        object.setName("Blue Deck")
        blueDeck = object
      end
  end
end
