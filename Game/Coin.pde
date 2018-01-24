public class Coin extends Block {

  // CONSTRUCTOR:
  Coin(PVector pos) {
    super(pos);
    dim = new PVector(60, 60);
  }

  // METHODS:
  public void render() {
    image(coin, pos.x, pos.y);
  }

  public void hit() {
    if (abs(ninja.pos.x - pos.x) < ninja.dim.x / 2 + dim.x / 2 &&
      abs(ninja.pos.y - pos.y) < ninja.dim.y / 2 + dim.y / 2) {
      coins.remove(this);
      points += 1;
      coinSound.play();
      coinSound.rewind();
    }
  }
} // class end