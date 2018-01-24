/*

 Assignment 4: "Rookie Ninja"
 Created by: Keegan George
 Student #: 301310019
 Lab #: E103
 */

// IMPORT LIBRARIES:
import ddf.minim.*; // audio library
import controlP5.*; // button library

// GAME STATES:
public int gameState; // sets game state
public final int INTRO = 0; // intro screen game state
public final int INSTRUCTIONS = 1; // instructions screen game state
public final int COSTUME = 2; // constume screen game state
public final int LEVEL1 = 3; // level 1 game state
public final int LEVEL2 = 4; // level 2 game state
public final int LEVEL3 = 5; // level 3 game state
public final int GAME_OVER = 6; // failed screen game state
public final int WINNER = 7; // winner screen game state
public final int LEVEL_SELECTOR = 8;

// LEVEL BOUNDARIES:
public final float SCREEN_MIN = 900; // level 1 player screen min
public final float SCREEN_MAX = -2600; // level 1 player screen max

// GLOBAL IMAGES:
public PImage icon; // application icon
public PImage coin; // coin image
public PImage heart; // health symbol
public PImage star; // stars at winner screen


// GLOBAL FONTS:
public PFont subFont; // button font
public PFont knobFont; // knob font 
public PFont pauseFont; // pause/play button font

// GLOBAL OBJECTS:
public IntroScreen intro; // intro screen
public Instructions tutorial; // instruction screen
public WardrobeSelect costume; // costume screen
public Player ninja; // ninja player
public GameWorld world; // game world
public GameOver fail; // gameover screen
public SelectLevel levelSelector; // level selector screen
public Block movingBlock; // moving block in level 1
public Block scalingBlock; // scaling block in level 1

// GLOBAL BOOLEANS:
public boolean left, right, up, down; // key coding
public boolean levelStart; // controls position setting for new level
public boolean load = true; // controls loading of sprite sheet
public boolean level1Running = false, // tracks the status
  level2Running = false, // of what level is
  level3Running = false; // currently being played
public boolean playStatus = true; // toggles pausing / playing of game
public boolean highJumpDisplay = false; // toggles the displaying of high jump icon
public boolean speedUpDisplay = false; // toggles the displaying of speed up icon

// ARRAY LISTS:
public ArrayList <Block> blocks = new ArrayList <Block>(); // game tiles
public ArrayList <Coin> coins = new ArrayList <Coin>(); // game tokens
public ArrayList <Coin> powerUps = new ArrayList <Coin>(); // game powerups

// GLOBAL VECTORS
public PVector gravForce = new PVector(0, 9.81); // gravity force

// GLOBAL COLORS:
public color white = color(255);
public color black = color(0);
public color red = color(255, 0, 0);
public color blue = color(0, 0, 255);
public color green = color(0, 255, 0);
public color yellow = color(255, 255, 0);
public color lightBlue = color(179, 228, 222);
public color pinkRed = color(242, 49, 62);
public color darkGray = color(62);

// AUDIO:
Minim minim; // minim object
AudioPlayer jumpSound; // jumping sound effect
AudioPlayer inGame; // level background music
AudioPlayer checkpointSound; // level complete sound effect
AudioPlayer menu; // menu background music
AudioPlayer coinSound; // coin grabbing sound effect
AudioPlayer whistle; // game over sound effect
AudioPlayer buttonClick, buttonClick2; // button press sound effect
AudioPlayer highJumpSound, speedUpSound; // sound effects when perks are acquired
AudioPlayer winSound; // sound effect when game won

// GUI:
ControlP5 cp5; // control P5 object
Button play; // intro screen play button > opens costume screen
Button start; // costume screen start button > opens level 1
Button instructions; // intro screen instructions button > opens instruction screen
Button credits; // intro screen credits button > opens credits screen
Button back; // costume screen back button > returns to intro screen
Button restart; // play game again once game over
Button levelSelect; // select Level screen
Knob volumeControl; // increase / decrease volume
Button pause; // toggles game pausing


// BLOCKS:
public final PVector BLOCK_SIZE = new PVector(350, 53); // regular block size
public float blockSpeed; // speed of moving block
public float scaleSpeed; // scaling speed of scaling block

// GLOBAL FLOATS:
public float numPerks = random(1, 5); // number of powerUps
public float points = 0; // points gained based on coins
public float numStars; // number of stars on winner screen (based on points)

// SETUP METHOD:
public void setup() {

  // FRAME SETTINGS:
  size(1280, 720);
  frameRate(30); // locks frame rate at a max of 30
  smooth();
  //surface.setResizable(true); // enables ability to resize screen
  surface.setTitle("Rookie Ninja"); // sets program title bar title
  icon = loadImage("Images/ICON.png"); // loads icon image
  coin = loadImage("Images/coin.png"); // coin image
  heart = loadImage("Images/health.png"); // health icon
  star = loadImage("Images/star.png"); // stars in winner screen based on points
  subFont = loadFont("Fonts/Vinsdojo-36.vlw"); // sub font (used in most buttons)
  knobFont = loadFont("Fonts/10Product.vlw"); // volume knob font
  pauseFont = loadFont("Fonts/15.vlw"); // pause/play toggle font
  surface.setIcon(icon); // sets icon image for program
  initializeObjects(); // initializes objects
  initializeSounds(); // initializes sounds
  initializeButtons(); // initializes button objects
  levelOneCoins(); // initializes tokens in level1
  specialBlocks(); // initializes spe cial blocks
  levelOneBlocks(); // creates tiles for level 1
  gameState = INTRO; // sets current game state
  levelStart = false; // sets checkpoint start to false initially
  ninja.jumping = true; // sets initial jump state
  blockSpeed = 8; // sets moving block speed
  scaleSpeed = -30; // sets scaling block speed
}

// initializes all class object
public void initializeObjects() {
  intro = new IntroScreen();
  costume = new WardrobeSelect();
  tutorial = new Instructions();
  fail = new GameOver();
  world = new GameWorld();
  ninja = new Player(new PVector(-900, 420));
  minim = new Minim(this);
  levelSelector = new SelectLevel();
  initializePowerUps();
}

// initializes power ups
public void initializePowerUps() {
  for (int i = 0; i < numPerks; i++) {
    powerUps.add(new SpeedUp(new PVector(random(3500), random(200, 600)))); // adds speed perk
    powerUps.add(new HighJump(new PVector(random(3500), random(200, 600))));// adds high jump perk
  }
}


// loads all sounds
public void initializeSounds() {
  jumpSound = minim.loadFile("Audio/jump.wav"); // played when jumping
  inGame = minim.loadFile("Audio/InGameAudio.mp3"); // played during game play
  menu = minim.loadFile("Audio/dojoMusic.mp3"); // played during menu screens
  checkpointSound = minim.loadFile("Audio/gong.wav"); // played when level completed
  coinSound = minim.loadFile("Audio/coin.wav"); // played when coin grabbed
  whistle = minim.loadFile("Audio/NinjaSoundEffect.wav"); // played when game over
  buttonClick = minim.loadFile("Audio/ButtonClick.wav"); // played when button is pressed
  buttonClick2 = minim.loadFile("Audio/ButtonClick2.wav"); // played when button is pressed (style 2)
  highJumpSound = minim.loadFile("Audio/highJump.wav"); // played when high jump perk is collided with
  speedUpSound = minim.loadFile("Audio/speedUp.wav"); // played when speed up perk is collided with
  winSound = minim.loadFile("Audio/youwin.mp3"); // played when full game is won
}


// DRAW METHOD (loops at max 30 FPS):
public void draw() {
  surface.setTitle("Rookie Ninja" + "  (FPS: " + int(frameRate) + ")");
  if (gameState == LEVEL1) {
    background(lightBlue);
  } else if (gameState == LEVEL2) {
    background(246, 178, 193);
  } else if (gameState == LEVEL3) {
    background(24, 78, 118);
  } else {
    background(lightBlue);
  }

  systemPrintln();   // calls print statements
  buttonDisplayer(); // controls when to display buttons
  audioController(); // controls audio play time
  controlPoints();   // controls stars per points

  // Cycles through game states based on situation:
  switch(gameState) {
  case INTRO:
    load = false;
    intro.render();
    break;
  case INSTRUCTIONS:
    load = false;
    tutorial.render();
    break;
  case COSTUME:
    load = true;
    costume.render();
    break;
  case LEVEL1:
    world.levelOne();
    break;
  case LEVEL2:
    load = false;
    world.levelTwo();
    break;
  case LEVEL3:
    load = false;
    world.levelThree();
    break;
  case GAME_OVER:
    ninja.health--;
    if (ninja.health <= 0) {
      fail.render();
    } else {
      playAgain();
    }
    break;
  case WINNER:
    world.win();
    break;
  case LEVEL_SELECTOR:
    levelSelector.render();
    break;
  default:
    intro.render();
  }
}


// controls when to play audio
public void audioController() {
  if (gameState == INTRO   || gameState == INSTRUCTIONS ||
    gameState == COSTUME || gameState == LEVEL_SELECTOR) {
    menu.play();
  } else {
    menu.pause();
  }

  if (gameState == LEVEL1 || 
    gameState == LEVEL2 || 
    gameState == LEVEL3) {
    inGame.play();
    whistle.pause();
    whistle.rewind();
  } else {
    inGame.pause();
  }
}

// prints game details to system
public void systemPrintln() {
  //PRINT STATEMENTS:
  println("GAME STATE: " + gameState);
  println("NINJA @ X: " + ninja.pos.x);
  println("NINJA @ Y: " + ninja.pos.y);
  println("# OF COINS " + coins.size());
  println("HEALTH " + ninja.health);
  if (level1Running) {
    println("LEVEL = 1");
  } else if (level2Running) {
    println("LEVEL = 2");
  } else if (level3Running) {
    println("LEVEL = 3");
  } else {
    println("LEVEL = N/A");
  }
}

// controls how many points give you certain stars at end
public void controlPoints() {
  if (points <= 0) {
    numStars = 0;
  } else if (points >= 0 && points < 36) {
    numStars = 1;
  } else if (points >= 36 && points < 60) {
    numStars = 2;
  } else {
    numStars = 3;
  }  
}