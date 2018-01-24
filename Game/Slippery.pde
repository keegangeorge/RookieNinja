public class Slippery extends Block {

  // CONSTRUCTOR:
  Slippery(PVector pos, PVector dim) {
    super(pos, dim);
  }

  // METHODS:
  public void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(blue);
    rect(-dim.x / 2, -dim.y / 2, dim.x, dim.y);
    popMatrix();

  }

} // class end