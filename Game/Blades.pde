public class Blades extends Block {
  // FIELDS:
  float angle;

  // CONSTRUCTOR:
  Blades(PVector pos) {
    super(pos);
    dim = new PVector(150, 150);
    angle = 0;
  }
  
  // METHODS:
  public void render() {
    angle += 5;
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(angle));
    image(world.bg.blade, 0, 0);
    popMatrix();
  }

} // class end