public class Spikes extends Block {
  // FIELDS:
  PImage image;

  // CONSTRUCTOR:
  Spikes(PVector pos) {
    super(pos);
    dim = new PVector(609, 127);
    image = loadImage("Images/spikes.png");
  }

  // METHODS:
  public void render() {
    image(image, pos.x, pos.y);

  }
} // class end