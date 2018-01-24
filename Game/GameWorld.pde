public class GameWorld {
  
  // FIELDS:
  public Hud headsUp; // heads up display
  public Background bg; // backgrounds
  public Checkpoint level1End, level2End, level3End; // level end checkpoints
  public float cameraX; // 2D Camera
  public float loadTime;  // load time to change costume (stops sprite image loading after timer ends)
  public Blades blade1, blade2, 
         blade3, blade4, blade5, // blades (obstacle)
         blade6, blade7;
  public ArrayList <Blades> movingBlades = new ArrayList<Blades>();
  public Spikes spike1, spike2, spike3; // spikes (obstacle)
  public Slippery slippery1, slippery2, slippery3; // slippery section on tile (slows down movement)
  public float spike2Vel, spike3Vel; // moving spike's velocity
  public ZipLine zipLine; // zipline to move downwards
  public float zipSpeed; // zipline's speed
  public boolean zipping, zipDone; // booleans check if zipping and if done zipping
  public PImage hanger; // zipline hanger image
  public float bladeSpeedL3; 
  public PVector bladeBoundary = new PVector(random(width), random(height));
  public Block disappearingBlock;
  public float disappearingBlockTimer;
  private boolean blockAlive, landed;
  private float blade7Speed;
  private PImage winner;

  // CONSTRUCTOR:
  GameWorld() {
    headsUp = new Hud(); // initializes heads up display
    bg = new Background(); // initializes background
    winner = loadImage("Images/Winner.png");
    loadTime = 3; // 3 frame load time for sprite images to load
    initializeLevel1(); // initializes objects for level 1
    initializeLevel2(); // initializes objects for level 2
    initializeLevel3(); // initializes objects for level 3
  }


  // Initializes Level 1 Specific Objects:
  public void initializeLevel1() {
    // Checkpoint:
    level1End = new Checkpoint(new PVector(3835, height - 540)); // initializes level 1 checkpoint
  }

  // Initializes Level 2 Specific Objects:
  public void initializeLevel2() {
    // Checkpoint:
    level2End = new Checkpoint(new PVector(3835, 680)); // initialzes level 2 checkpoint

    // Obstacles:
    blade1 = new Blades(new PVector(500, 755)); // first blade in level 2
    spike1 = new Spikes(new PVector(1500, 737 - 127 / 2)); // first spike in level 2
    spike2 = new Spikes(new PVector(2759, 650)); // second spike in level 2 (moving spike)
    blade2 = new Blades(new PVector(1590, height - 220)); // second blade in level 2
    blade3 = new Blades(new PVector(1000, height - 520)); // third blade in level 2
    blade4 = new Blades(new PVector(3300, 540)); // forth blade in level 2
    slippery1 = new Slippery (new PVector(2500, 620), new PVector(BLOCK_SIZE.x, 10)); // slippery section in level 2
    spike2Vel = 4; // velocity of moving spike in level 2 (spike 2)
  }

  // Initializes Level 3 Specific Objects:
  public void initializeLevel3() {
    // Checkpoint:
    level3End = new Checkpoint(new PVector(3835, 730)); // initializes level 3 checkpoint

    // Obstacles:
    spike3 = new Spikes(new PVector(1800, 700)); // first spike in level 3
    blade5 = new Blades(new PVector(-381, 150)); // fifth blade in level 3
    blade6 = new Blades(new PVector(-630, 650)); // sixth blade in level 3
    blade7 = new Blades(new PVector(2500, 0)); // level 3 blade
    slippery2 = new Slippery (new PVector(1800, 370), new PVector(BLOCK_SIZE.x, 10)); // slippery section in level 3
    slippery3 = new Slippery (new PVector(2910, 670), new PVector(BLOCK_SIZE.x, 10)); // slippery section 2 in level 3
    bladeSpeedL3 = random(2, 10);
    spike3Vel = 10;

    // Zip-line:
    zipLine = new ZipLine(new PVector(-600, 200)); // zipline in level 3
    zipSpeed = 0; // zipline's initial speed
    zipping = false; // zipping initial status
    zipDone = false; // done zipping initial status
    hanger = requestImage("Images/zipline.png"); // load hanger image for zipline

    // Special Blocks:
    disappearingBlock = new Block(new PVector(1300, 550), new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y));
    disappearingBlockTimer = 60;
    blockAlive = false;
    landed = false;
    blade7Speed = 10;
  }


  ///////////////////////////////////////
  ///////// LEVEL 1: GAME MODE///////////
  ///////////////////////////////////////
  public void levelOne() {
    // sets level status to be level 1:
    level1Running = true;
    level2Running = false;
    level3Running = false;

    // sets player's initial position on level start:
    if (levelStart == true) {
      ninja.pos.x = -900;
      ninja.pos.y = 420;
      levelStart = false;
      ninja.jumping = true;
    }

    // decrements load time to stop loading sprite images:
    loadTime--;
    if (loadTime <= 0) {
      load = false;
      loadTime = 3;
    }

    cameraX = -ninja.pos.x + width / 2; // camera's initial position
    cameraBoundaries(); // calls method to set camera's boundaries
    bg.renderClouds(); // renders moving clouds
    headsUp.update(); // renders and updates HUD
    pushMatrix();
    translate(cameraX, height / 2 - 410); // pans the camera to player horizontal movement
    level1End.render(); // renders level end checkpoint door
    bg.scenery(); // renders background
    ninja.update(); // renders & updates character position
    gravity(); // calls gravity method
    blockDetection(); // calls method to see if block is landed on
    translatingBlock(); // calls the method to render and update the moving block
    sizingBlock(); // calls the method to render and update the scaling block
    specialBlockDetection(); // calls method to see if special blocks are landed on

    // renders coins for level 1:
    for (int i = 0; i < coins.size(); i++) {
      coins.get(i).render();
    }

    // checks and removes coins collided with player:
    for (int i = 0; i < coins.size(); i++) {
      Coin c = coins.get(i);
      c.hit(); // checks collision with player and removes coin from array list
    }

    // renders power ups and checks for collisions with them:
    for (int i = 0; i < powerUps.size(); i++) {
      Coin moreSpeed = powerUps.get(i);
      moreSpeed.render();
      moreSpeed.hit();
    }

    // renders block tiles:
    for (int i = 0; i < blocks.size(); i++) {
      blocks.get(i).render();
    }
    popMatrix();

    // finishes level 1 and commences level 2:
    if (level1End.bump(ninja)) {
      gameState = LEVEL2;
      checkpointSound.play();
      levelStart = true;
      coins = new ArrayList <Coin>();
      levelTwoCoins();
      powerUps = new ArrayList <Coin>();
      initializePowerUps();
    }
  }




  ///////////////////////////////////////
  ///////// LEVEL 2: GAME MODE///////////
  ///////////////////////////////////////

  public void levelTwo() {
    // sets level status to be level 2:
    level2Running = true;
    level1Running = false;
    level3Running = false;
    movingBlock = null;
    scalingBlock = null;


    // sets player's initial position on level start:
    if (levelStart == true) {
      ninja.pos.x = -900;
      ninja.pos.y = 420;
      levelStart = false;
      ninja.jumping = true;
      blocks = new ArrayList <Block>();
      levelTwoBlocks();
      headsUp.ticker = 380;
    }

    cameraX = -ninja.pos.x + width / 2; // camera's initial position
    cameraBoundaries(); // calls method to check camera's boundaries
    pushMatrix();
    translate(cameraX, height / 2 - 410); // pans the camera to player movement
    image(bg.building, -700, 500);
    ninja.update(); // renders and updates player
    gravity(); // adds gravitational force to level
    blockDetection(); // detects collisions with blocks

    // OBSTACLES IN ORDER TO APPEARANCE:
    blade1.render(); // renders blade 1
    spike1.render(); // renders spike 1
    spike2.render(); // renders spike 2
    blade2.render(); // renders blade 2
    blade3.render(); // renders blade 3
    blade4.render(); // renders blade 4
    slippery1.render(); // renders slippery section
    obstacleHit(); // checks to see collisions with obstacles
    movingSpikes(); // dynamically moves spikes
    level2End.render(); // renders level end checkpoint door

    // renders level 2 coins:
    for (int i = 0; i < coins.size(); i++) {
      coins.get(i).render();
    }

    // checks for collisions with coins
    for (int i = 0; i < coins.size(); i++) {
      Coin c = coins.get(i);
      c.hit(); // removes coins on collision from array list
    }

    // renders block tiles
    for (int i = 0; i < blocks.size(); i++) {
      blocks.get(i).render();
    }

    // renders power ups
    for (int i = 0; i < powerUps.size(); i++) {
      Coin moreSpeed = powerUps.get(i);
      moreSpeed.render();
      moreSpeed.hit();
    }
    popMatrix();
    headsUp.update(); // calls method to render and update HUD



    // finishes level 2 and commences level 3:
    if (level2End.bump(ninja)) {
      gameState = LEVEL3;
      checkpointSound.rewind();
      checkpointSound.play();
      coins = new ArrayList <Coin>();
      levelThreeCoins();
      levelStart = true;
      powerUps = new ArrayList <Coin>();
      initializePowerUps();
    }
  }




  ///////////////////////////////////////
  ///////// LEVEL 3: GAME MODE///////////
  ///////////////////////////////////////

  public void levelThree() {
    // sets game status to level 3:
    level3Running = true;
    level1Running = false;
    level2Running = false;

    disappearingBlockTimer--;

    if (disappearingBlockTimer <= -60) {
      disappearingBlockTimer = 60;
    }

    // sets player's initial position:
    if (levelStart == true) {
      ninja.pos.x = -823;
      ninja.pos.y = 200;
      levelStart = false;
      ninja.jumping = true;
      blocks = new ArrayList <Block>();
      levelThreeBlocks();
      headsUp.ticker = 380;
      for (int i = 0; i < 2; i++) {
        movingBlades.add(new Blades(new PVector(random(700, 800), random(-150, 250)))); // adds movingblades
      }
    }

    cameraX = -ninja.pos.x + width / 2; // sets camera's initial position
    cameraBoundaries(); // calls method to check camera's boundaries
    pushMatrix();
    translate(cameraX, height / 2 - 410); // pans the camera to player movement
    ninja.update(); // renders and updates player
    gravity(); // adds gravitational forces to level
    blockDetection(); // checks collision with block tiles
    specialBlockDetection(); // checks collision with special blocks
    zipLine.render(); // renders zipline
    controlZipLine(); // updates zipline
    blade5.render(); // renders blade
    blade6.render(); // renders blade
    blade7.render(); // renders blade
    slippery2.render(); // renders slippery section
    slippery3.render();
    obstacleHit(); // checks to see collisions with obstacles
    level3End.render(); // renders level end checkpoint door
    movingSpikes();
    spike3.render();
    blade7.pos.y += blade7Speed;

    if (blade7.pos.y >= height) {
      blade7Speed *= -1;
    }

    if (blade7.pos.y <= -10) {
      blade7Speed *= -1;
    }

    // renders coins for level 3:
    for (int i = 0; i < coins.size(); i++) {
      coins.get(i).render();
    }

    // checks for collision with coins:
    for (int i = 0; i < coins.size(); i++) {
      Coin c = coins.get(i);
      c.hit(); // removes coins on collision from array list
    }

    // renders block tiles
    for (int i = 0; i < blocks.size(); i++) {
      blocks.get(i).render();
    }

    // renders power ups
    for (int i = 0; i < powerUps.size(); i++) {
      Coin moreSpeed = powerUps.get(i);
      moreSpeed.render();
      moreSpeed.hit();
    }

    // renders moving blades
    for (int i = 0; i < movingBlades.size(); i++) {
      Blades level3Blades = movingBlades.get(i);
      level3Blades.render();
      if (level3Blades.bump(ninja)) {
        gameState = GAME_OVER;
      }
      level3Blades.pos.x += bladeSpeedL3;
      level3Blades.pos.y += bladeSpeedL3;
      if (level3Blades.pos.x >= bladeBoundary.x) {
        bladeSpeedL3 *= -1;
      }
      if (level3Blades.pos.y >= bladeBoundary.y) {
        bladeSpeedL3 *= -1;
      }
    }

    // draws zipline hanger image
    image(hanger, -482, 388);

    if (disappearingBlockTimer > 0) {
      disappearingBlock.render();  
      blockAlive = true;
    } else if (disappearingBlockTimer <= 0) {
      blockAlive = false;
    }

    popMatrix();
    headsUp.update(); // renders and updates HUD

    // WIN GAME ON LAST CHECKPOINT
    if (level3End.bump(ninja)) {
      gameState = WINNER;
      checkpointSound.play();
    }
  }

  //adds gravity to game
  public void gravity() {
    if (ninja.block != null) {
      if (!ninja.block.isOn(ninja)) {
        ninja.jumping = true;
      }
    }
  }

  // detects collisions with blocks
  public void blockDetection() {
    if (ninja.jumping) {
      ninja.move(gravForce); // gravity pulls ninja on jump
      // loops to see if block is landed on
      for (int i = 0; i < blocks.size(); i++) {
        Block b = blocks.get(i);
        if (b.bump(ninja)) {
          if (ninja.vel.y > 0) {   // if hit from above
            ninja.landOn(b);       // then land on block
          } else {                 // if hit from underneath
            ninja.fall();          // bounce off
          }
        }
      }
    }
  }

  // detects collisions with dynamic blocks (moving / scaling):
  public void specialBlockDetection() {
    // moving block in level 1
    if (gameState == LEVEL1 && level1Running) {
      if (movingBlock.bump(ninja)) {
        if (ninja.vel.y > 0) {
          ninja.landOn(movingBlock);
        } else {
          ninja.fall();
        }
      }

      // scaling block in level 1
      if (scalingBlock.bump(ninja)) {
        if (ninja.vel.y > 0) {
          ninja.landOn(scalingBlock);
        } else {
          ninja.fall();
        }
      }
    }

    if (gameState == LEVEL3 && level3Running) {
      if (disappearingBlock.bump(ninja)) {
        if (ninja.vel.y > 0) {
          if (disappearingBlockTimer > 0) {
            ninja.landOn(disappearingBlock);
            landed = true;
          }
        } else {
          ninja.fall();
          landed = false;
        }
      }

      if (blockAlive == false && landed == true) {
        ninja.jump(new PVector(0, 5));
        landed = false;
      }
    }
  }

  // renders and updates moving block:
  public void translatingBlock() {
    movingBlock.render(); // renders moving block
    movingBlock.pos.x += blockSpeed; // updates block position

    // sets block position boundaries:
    if (movingBlock.pos.x >= 2400) {
      blockSpeed *= -1;
    }

    if (movingBlock.pos.x <= 1650) {
      blockSpeed *= -1;
    }
  }

  // renders and updates scaling block:
  public void sizingBlock() {
    scalingBlock.render(); // renders scaling block
    scalingBlock.dim.x += scaleSpeed; // updates block position

    // sets block scale dimension boundaries:
    if (scalingBlock.dim.x >= 1000) {
      scaleSpeed *= -1;
    }

    if (scalingBlock.dim.x <= ninja.dim.x) {
      scaleSpeed *= -1;
    }
  }

  // creates boundaries for camera panning:
  public void cameraBoundaries() {
    if (cameraX > SCREEN_MIN) {
      cameraX = SCREEN_MIN;
    }

    if (cameraX < SCREEN_MAX) {
      cameraX = SCREEN_MAX;
    }
  }

  // checks for collisions with obstacles
  public void obstacleHit() {
    // checks collisions with blades and sets game over:
    if (level2Running) {
      if (blade1.bump(ninja) || blade2.bump(ninja) 
        || blade3.bump(ninja) || blade4.bump(ninja)) {
        gameState = GAME_OVER;
      }
    }

    if (level3Running) {
      if (blade5.bump(ninja) || blade6.bump(ninja) || spike3.bump(ninja) || blade7.bump(ninja)) {
        gameState = GAME_OVER;
      }
    }

    // checks collisions with spikes and sets game over:
    if (spike1.bump(ninja) && level2Running || spike2.bump(ninja) && level2Running) {
      gameState = GAME_OVER;
    }

    // checks collisions with slippery sections and changes forces:
    if (slippery1.bump(ninja) && level2Running) {
      ninja.acc = 1;
      ninja.rightForce = new PVector(0.5, 0);
      ninja.leftForce = new PVector(-0.5, 0);
    } else {
      ninja.rightForce = new PVector(6, 0);
      ninja.leftForce = new PVector(-6, 0);
    }

    if (slippery2.bump(ninja) && level3Running || slippery3.bump(ninja) && level3Running) {
      ninja.acc = 0.5;
      ninja.rightForce = new PVector(0.5, 0);
      ninja.leftForce = new PVector(-0.5, 0);
    } else {
      ninja.rightForce = new PVector(6, 0);
      ninja.leftForce = new PVector(-6, 0);
    }
  }

  // update moving spikes:
  public void movingSpikes() {
    spike2.pos.y += spike2Vel; // updates spike position
    spike3.pos.y += spike3Vel;

    // checks for spike position update boundaries:
    if (spike2.pos.y >= 800) {
      spike2Vel *= -1;
    }

    if (spike2.pos.y <= 600.5) {
      spike2Vel *= -1;
    }

    if (spike3.pos.y >= 800) {
      spike3Vel *= -1;
    } 

    if (spike3.pos.y <= 300) {
      spike3Vel *= -1;
    }
  }

  // updates zip line:
  public void controlZipLine() {
    zipLine.pos.x += zipSpeed; // updates zipline x position
    zipLine.pos.y += zipSpeed * 0.8; // updates zipline y position

    // checks for collision with player and zipline:
    if (zipLine.bump(ninja)) {
      zipSpeed = 6;
      zipping = true;

      // if player collides on zipline
      // then make the player stay with the movement
      // of the zipline
      if (zipping) {
        ninja.pos.x = zipLine.pos.x;
        ninja.pos.y = zipLine.pos.y + (ninja.dim.y / 2 - 4);
      }
    }

    // if zipline reached end, drop player:
    if (zipLine.pos.x >= -127) {
      zipping = false;
      zipSpeed = 0;
      // sets player position after zipline travel:
      if (zipDone == false) {
        ninja.pos.x = -127;
        ninja.pos.y = 675;
      }
      ninja.upForce = new PVector(0, -80); // upwards acceleration force
      ninja.jump(ninja.upForce); // forces player off of zipline

      zipDone = true;
      if (zipDone == true) {
        zipSpeed = -6;
        ninja.pos.y = zipLine.pos.y;
        ninja.upForce = new PVector(0, -144); // upwards acceleration force
      }
    }
    // allows the zipline to stay within screen boundaries
    if (zipLine.pos.x <= -610) {
      if (zipping == false) {
        zipSpeed = 0;
      }
      zipDone = false;
    }
  }


  // renders pause game screen
  private void pauseGame() {
    fill(pinkRed, 200);
    rect(0, 0, width, height);
    textFont(world.headsUp.hudFont);
    fill(white);
    text("GAME PAUSED", width / 2 - 100, height / 2);
    textFont(pauseFont);
    fill(white);
    text("Click to Resume", width / 2 - 30, height / 2 + 50);
    playStatus = false;
    noLoop();
  }

  // renders winning screen
  public void win() {
    imageMode(CORNER);
    image(winner, 0, 0);
    winSound.play();
    float distance = 201;
    for (int i = 0; i < numStars; i++) {
      image(star, distance*i + 656, 200);
    }
    textFont(headsUp.hudFont);
    text(int(points), 963, 456);
    imageMode(CENTER);
  }
} // class end