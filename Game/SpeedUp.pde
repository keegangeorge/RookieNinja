public class SpeedUp extends Coin {
  
  // FIELDS:
  public Timer timer;
  public PImage symbol;

  // CONSTRUCTOR:
  SpeedUp(PVector pos) {
    super(pos);
    dim = new PVector(60, 60);
    timer = new Timer();
    symbol = loadImage("Images/SpeedUp.png");
  }

  // METHODS:
  public void render() {
    image(symbol, pos.x, pos.y);

    if (timer.elapsedMillis() > 3000) {
      ninja.leftForce = new PVector(-6, 0); // left acceleration force
      ninja.rightForce = new PVector(6, 0); // right acceleration force
      speedUpDisplay = false;

      timer.reset();
    }
  }

  public void hit() {
    if (abs(ninja.pos.x - pos.x) < ninja.dim.x / 2 + dim.x / 2 &&
      abs(ninja.pos.y - pos.y) < ninja.dim.y / 2 + dim.y / 2) {
      timer.reset();
      powerUps.remove(this);
      ninja.leftForce = new PVector(-10, 0); // left acceleration force
      ninja.rightForce = new PVector(10, 0); // right acceleration force
      speedUpDisplay = true;
      speedUpSound.play(); 
      speedUpSound.rewind();
    }
  }
} // class end