// BUTTONS:

// INITIALIZES ALL BUTTONS FOR GAME:
public void initializeButtons() {
  cp5 = new ControlP5(this);

  play = cp5.addButton("Play Game", 0, width / 2 - 160, height - 300, 300, 80); // adds button
  play.getCaptionLabel().setFont(subFont); // sets label font style
  play.setColorLabel(color(white)); // sets label color
  play.setColorBackground(color(darkGray)); // sets button background color
  play.setColorActive(color(pinkRed)); // sets button color when active
  play.setColorForeground(color(pinkRed)); // sets button foreground color

  instructions = cp5.addButton("Instructions", 0, width / 2 - 160, height - 200, 300, 80);// adds button
  instructions.getCaptionLabel().setFont(subFont); // sets label font style
  instructions.setColorLabel(color(white)); // sets button background color
  instructions.setColorBackground(color(darkGray)); // sets button background color
  instructions.setColorActive(color(pinkRed)); // sets button color when active
  instructions.setColorForeground(color(pinkRed)); // sets button foreground color

  start = cp5.addButton("Start Game", 0, width / 2 + 320, height - 100, 300, 80);// adds button
  start.getCaptionLabel().setFont(subFont); // sets label font style
  start.setColorLabel(color(white)); // sets button background color
  start.setColorBackground(color(darkGray)); // sets button background color
  start.setColorActive(color(pinkRed)); // sets button color when active
  start.setColorForeground(color(pinkRed)); // sets button foreground color

  back = cp5.addButton("Back", 0, width / 2 - 620, height - 100, 300, 80);// adds button
  back.getCaptionLabel().setFont(subFont); // sets label font style
  back.setColorLabel(color(white)); // sets button background color
  back.setColorBackground(color(darkGray)); // sets button background color
  back.setColorActive(color(pinkRed)); // sets button color when active
  back.setColorForeground(color(pinkRed)); // sets button foreground color


  restart = cp5.addButton("Restart", 0, width / 2 + 50, height - 200, 300, 80); // adds button
  restart.getCaptionLabel().setFont(subFont); // sets label font style
  restart.setColorLabel(color(white)); // sets label color
  restart.setColorBackground(color(25)); // sets button background color
  restart.setColorActive(color(pinkRed)); // sets button color when active
  restart.setColorForeground(color(pinkRed)); // sets button foreground color

  restart = cp5.addButton("Menu", 0, width / 2 - 350, height - 200, 300, 80); // adds button
  restart.getCaptionLabel().setFont(subFont); // sets label font style
  restart.setColorLabel(color(white)); // sets label color
  restart.setColorBackground(color(25)); // sets button background color
  restart.setColorActive(color(pinkRed)); // sets button color when active
  restart.setColorForeground(color(pinkRed)); // sets button foreground color

  levelSelect = cp5.addButton("Select Level", 0, width / 2 - 160, height - 100, 300, 80); // adds button
  levelSelect.getCaptionLabel().setFont(subFont); // sets label font style
  levelSelect.setColorLabel(color(white)); // sets label color
  levelSelect.setColorBackground(color(darkGray)); // sets button background color
  levelSelect.setColorActive(color(pinkRed)); // sets button color when active
  levelSelect.setColorForeground(color(pinkRed)); // sets button foreground color

  levelSelect = cp5.addButton("Level 1", 0, width / 2 - 500, height - 400, 200, 100); // adds button
  levelSelect.getCaptionLabel().setFont(subFont); // sets label font style
  levelSelect.setColorLabel(color(white)); // sets label color
  levelSelect.setColorBackground(color(darkGray)); // sets button background color
  levelSelect.setColorActive(color(pinkRed)); // sets button color when active
  levelSelect.setColorForeground(color(pinkRed)); // sets button foreground color

  levelSelect = cp5.addButton("Level 2", 0, width / 2 - 100, height - 400, 200, 100); // adds button
  levelSelect.getCaptionLabel().setFont(subFont); // sets label font style
  levelSelect.setColorLabel(color(white)); // sets label color
  levelSelect.setColorBackground(color(darkGray)); // sets button background color
  levelSelect.setColorActive(color(pinkRed)); // sets button color when active
  levelSelect.setColorForeground(color(pinkRed)); // sets button foreground color

  levelSelect = cp5.addButton("Level 3", 0, width / 2 + 300, height - 400, 200, 100); // adds button
  levelSelect.getCaptionLabel().setFont(subFont); // sets label font style
  levelSelect.setColorLabel(color(white)); // sets label color
  levelSelect.setColorBackground(color(darkGray)); // sets button background color
  levelSelect.setColorActive(color(pinkRed)); // sets button color when active
  levelSelect.setColorForeground(color(pinkRed)); // sets button foreground color

  volumeControl = cp5.addKnob("Volume", -100, 100, 0, 1200, 43, 60);
  volumeControl.getCaptionLabel().setFont(knobFont);
  volumeControl.getValueLabel().setFont(knobFont);
  volumeControl.setColorLabel(color(darkGray));
  volumeControl.setColorBackground(color(white));
  volumeControl.setColorActive(color(pinkRed));
  volumeControl.setColorForeground(color(pinkRed));

  pause = cp5.addButton("Pause", -100, 50, 45, 75, 50); // adds button
  pause.getCaptionLabel().setFont(pauseFont);
  pause.setColorBackground(color(pinkRed)); // sets button background color
  pause.setColorActive(color(pinkRed)); // sets button color when active
  pause.setColorForeground(color(darkGray)); // sets button foreground color
}


// CONTROLS BUTTON ACTION:
void controlEvent(ControlEvent theEvent) {
  if (theEvent.controller().getName() == "Volume") {
    menu.setGain(theEvent.getController().getValue());
    inGame.setGain(theEvent.getController().getValue());
    jumpSound.setGain(theEvent.getController().getValue());
    checkpointSound.setGain(theEvent.getController().getValue());
    coinSound.setGain(theEvent.getController().getValue());
  }

  if (theEvent.controller().getName() == "Play Game") {
    gameState = COSTUME;
    buttonClick2.rewind();
    buttonClick2.play();
  }

  if (theEvent.controller().getName() == "Instructions") {
    gameState = INSTRUCTIONS;
    buttonClick.rewind();
    buttonClick.play();
  }

  if (theEvent.controller().getName() == "Start Game") {
    gameState = LEVEL1;
    buttonClick2.rewind();
    buttonClick2.play();
    playAgain();
  }

  if (theEvent.controller().getName() == "Back") {
    gameState = INTRO;
    buttonClick.rewind();
    buttonClick.play();
  }

  if (theEvent.controller().getName() == "Menu") {
    gameState = INTRO;
    buttonClick.rewind();
    buttonClick.play();
  }

  if (theEvent.controller().getName() == "Restart") {
    buttonClick2.rewind();
    buttonClick2.play();
    ninja.health = 4;
    playAgain();
  }

  if (theEvent.controller().getName() == "Pause") {
    if (playStatus == true) {
      world.pauseGame();
    } else if (playStatus == false) {
      loop();
      playStatus = true;
    }
  }

  if (theEvent.controller().getName() == "Select Level") {
    gameState = LEVEL_SELECTOR;
    buttonClick2.rewind();
    buttonClick2.play();
  }

  if (theEvent.controller().getName() == "Level 1") {
    level1Running = true;
    level2Running = false;
    level3Running = false;
    buttonClick2.rewind();
    buttonClick2.play();
    playAgain();
  }

  if (theEvent.controller().getName() == "Level 2") {
    level1Running = false;
    level2Running = true;
    level3Running = false;
    buttonClick2.rewind();
    buttonClick2.play();
    playAgain();
  }

  if (theEvent.controller().getName() == "Level 3") {
    level1Running = false;
    level2Running = false;
    level3Running = true;
    buttonClick2.rewind();
    buttonClick2.play();
    playAgain();
  }
}

// CONTROLS WHAT HAPPENS WHEN YOU RESTART:
// RE-INITIALIZES OBJECTS ON PLAY AGAN:
public void playAgain() {
  if (level1Running) {
    world.headsUp.ticker = 360;
    level1Running = true;
    level2Running = false;
    level3Running = false;
    world.levelOne();
    gameState = LEVEL1;
    levelStart = true;
    coins = new ArrayList <Coin>();
    levelOneCoins();
    if (levelStart == true) {
      ninja.pos.x = -900;
      ninja.pos.y = 420;
      levelStart = false;
      ninja.jumping = true;
    }
    powerUps = new ArrayList <Coin>();
    initializePowerUps();
  } else if (level2Running) {
    world.headsUp.ticker = 370;
    level1Running = false;
    level2Running = true;
    level3Running = false;
    world.levelTwo();
    gameState = LEVEL2;
    levelStart = true;
    coins = new ArrayList <Coin>();
    levelTwoCoins();
    if (levelStart == true) {
      ninja.pos.x = -900;
      ninja.pos.y = 420;
      levelStart = false;
      ninja.jumping = true;
      blocks = new ArrayList <Block>();
      levelTwoBlocks();
    }
    powerUps = new ArrayList <Coin>();
    initializePowerUps();
  } else if (level3Running) {
    level1Running = false;
    level2Running = false;
    level3Running = true;
    world.levelThree();
    gameState = LEVEL3;
    levelStart = true;
    coins = new ArrayList <Coin>();
    levelThreeCoins();
    if (levelStart == true) {
      world.headsUp.ticker = 380;
      ninja.pos.x = -823;
      ninja.pos.y = 200;
      levelStart = false;
      ninja.jumping = true;
      blocks = new ArrayList <Block>();
      levelThreeBlocks();
    }
    powerUps = new ArrayList <Coin>();
    initializePowerUps();
    world.movingBlades = new ArrayList<Blades>();
    for (int i = 0; i < 2; i++) {
      world.movingBlades.add(new Blades(new PVector(random(700, 800), random(-150, 250)))); // adds movingblades
    }
  }
}

// DISPLAYS BUTTONS PER SITUATIONS:
public void buttonDisplayer() {
  if (gameState == LEVEL_SELECTOR) {
    cp5.getController("Level 1").show();
    cp5.getController("Level 2").show();
    cp5.getController("Level 3").show();
  } else {
    cp5.getController("Level 1").hide();
    cp5.getController("Level 2").hide();
    cp5.getController("Level 3").hide();
  }

  if (gameState == INTRO) {
    cp5.getController("Play Game").show();
    cp5.getController("Instructions").show();
    cp5.getController("Select Level").show();
  } else {
    cp5.getController("Play Game").hide();
    cp5.getController("Instructions").hide();
    cp5.getController("Select Level").hide();
  }

  if (gameState == COSTUME) {
    cp5.getController("Start Game").show();
  } else {
    cp5.getController("Start Game").hide();
  }

  if (gameState == GAME_OVER) {
    cp5.getController("Restart").show();
    cp5.getController("Menu").show();
  } else {
    cp5.getController("Restart").hide();
    cp5.getController("Menu").hide();
  }

  if (gameState == COSTUME || gameState == LEVEL_SELECTOR || gameState == INSTRUCTIONS) {
    cp5.getController("Back").show();
  } else {
    cp5.getController("Back").hide();
  }

  if (gameState == LEVEL1 || gameState == LEVEL2 || gameState == LEVEL3) {
    cp5.getController("Volume").show();
    cp5.getController("Pause").show();
  } else {
    cp5.getController("Volume").hide();
    cp5.getController("Pause").hide();
  }
}