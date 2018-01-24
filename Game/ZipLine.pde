public class ZipLine extends Spikes {
  
  // CONSTRUCTOR:
  ZipLine(PVector pos) {
    super(pos);
    dim = new PVector (10, 90);
  }

  // METHODS:
  public void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(black);
    rect(-dim.x / 2, -dim.y / 2, dim.x, dim.y);
    popMatrix();
  }
}