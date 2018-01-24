public class Checkpoint extends Block {

  // FIELDS:
  Checkpoint(PVector pos) {
    super(pos);
    dim = new PVector(74, 125);
  }

  // METHODS:
  public void render() {
    // door for level completion
    image(world.bg.door, pos.x, pos.y);
  }
} // class end