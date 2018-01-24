public class HighJump extends SpeedUp {

  // CONSTRUCTOR:
  HighJump(PVector pos) {
    super(pos);
    dim = new PVector(60, 60);
    symbol = loadImage("Images/HighJump.png");
  }
  
  // METHODS:
  public void render() {
    image(symbol, pos.x, pos.y);
    if (timer.elapsedMillis() > 3000) {
      ninja.upForce = new PVector(0, -6 * 24);
      timer.reset();
      highJumpDisplay = false;
    }
  }

  public void hit() {
    if (abs(ninja.pos.x - pos.x) < ninja.dim.x / 2 + dim.x / 2 &&
      abs(ninja.pos.y - pos.y) < ninja.dim.y / 2 + dim.y / 2) {
      timer.reset();
      powerUps.remove(this);
      ninja.upForce = new PVector(0, -6 * 50);
      highJumpDisplay = true;
      highJumpSound.play(); 
      highJumpSound.rewind();
    }
  }
} // class end