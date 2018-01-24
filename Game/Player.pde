public class Player {

  // FIELDS:
  public PVector pos, vel; // movement variables
  public PVector dim; // size of character
  public float health; // health of character
  public float damp; // dampening factor
  public float acc = 6; // character acceleration
  public boolean jumping; // checks for jumping state
  public PVector upForce = new PVector(0, -acc * 24); // upwards acceleration force
  public PVector leftForce = new PVector(-acc, 0); // left acceleration force
  public PVector rightForce = new PVector(acc, 0); // right acceleration force
  private PImage spriteSheet; // sprite sheet with all images of player
  private PImage [][] movement; // array cycles through sprite sheet images
  private boolean inMotion; // checks to see if character is in motion
  private int currentDirection; // current direction player is facing
  private float currentFrame; // current frame in sprite animation
  public Block block = null; // block which is intially set to null
  final int POS_UP = 0, POS_LEFT = 1, POS_DOWN = 2, POS_RIGHT = 3; // labels for position
  final int SPRITE_SIZE = 128; // size of sprite squares (divisions of sheet)
  public float progress;
  public String playerCol = "RED";
  
  // CONSTRUCTOR:
  Player(PVector pos) {
    this.pos = pos;
    init();
  }

  // METHODS:
  void init() {
    vel = new PVector();
    dim = new PVector(46, 128); // character legs width
    damp = 0.8;
    inMotion = false;
    currentDirection = 1;
    currentFrame = 0;
    jumping = false;
    progress = 0;
    setupSprites();
    health = 4; // initial health
  }

  // sets up sprite images
  void setupSprites() {
    movement = new PImage[4][9];
    spriteSheet = loadImage("Images/" + playerCol + "_SPRITE.png");
    for (int i = 0; i < 9; i++) {
      movement[POS_UP][i] = spriteSheet.get
        (0 + SPRITE_SIZE * i, 0, SPRITE_SIZE, SPRITE_SIZE);

      movement[POS_LEFT][i] = spriteSheet.get
        (0 + SPRITE_SIZE * i, SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE);

      movement[POS_DOWN][i] = spriteSheet.get
        (0 + SPRITE_SIZE * i, SPRITE_SIZE * 2, SPRITE_SIZE, SPRITE_SIZE);

      movement[POS_RIGHT][i] = spriteSheet.get
        (0 + SPRITE_SIZE * i, SPRITE_SIZE * 3, SPRITE_SIZE, SPRITE_SIZE);
    }
  }

  // renders player and sprite images
  void render() {
    if (load == true) {
      setupSprites();
    }


    imageMode(CENTER);
    if (inMotion) {
      image(movement[currentDirection][1 + int(currentFrame)], pos.x, pos.y);
    } else {
      image(movement[currentDirection][0], pos.x, pos.y);
    }
  }

  // moves player by updating velocity by acceleration
  void move(PVector acc) {
    vel.add(acc);
    inMotion = true;
  }

  // updates player's position
  void update() {
    vel.mult(damp);
    pos.add(vel);
    boundaries();
    currentFrame = ((currentFrame + 0.3) % 8); // makes sure frame doesn't loop past 9

    if (right || left || up || down) {
      inMotion = true;
    } else {
      inMotion = false;
    }
    if (vel.x == 0 && vel.y == 0)
    {
      inMotion = false;
    } else if (vel.y <= -1) {
      currentDirection = POS_UP;
    } else if (vel.x <= -1) {
      currentDirection = POS_LEFT;
    } else if (vel.x >= 1) {
      currentDirection = POS_RIGHT;
    } else if (vel.y >= 1) {
      currentDirection = POS_DOWN;
    }
    render();
    keyControl();

    // controls result of player falling down out of window
    if (pos.y >= height + 100) {
      gameState = GAME_OVER;
    }
  }

  void jump(PVector upAcc) {
    move(upAcc);
    jumping = true;
  }

  void landOn(Block b) {
    jumping = false;
    block = b;
    pos.y = b.pos.y - dim.y / 2 - b.dim.y / 2;
    vel.y = 0;
  }

  void fall() { // bumps with block from underneath
    vel.y *= -1;
  }

  void keyControl() {
    // Player Keyboard Controls:

    if (up && !ninja.jumping) {
      ninja.jump(upForce); // jump only when landed
      jumpSound.rewind();
      jumpSound.play();
    }

    if (left) {
      ninja.move(leftForce);
      progress -= 0.55;
    }

    if (down) currentDirection = POS_DOWN;

    if (right) {
      ninja.move(rightForce);
      progress += 0.55;
    }
  }

  void boundaries() {
    if (pos.x < -SCREEN_MIN) {
      pos.x = -SCREEN_MIN;
    }
  }
} // class end