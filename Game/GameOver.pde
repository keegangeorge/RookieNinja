// GAME STATE = 5
public class GameOver {
  // FIELDS:
  PImage bg;

  // CONSTRUCTOR:
  GameOver() {
    bg = loadImage("Images/failGame.png");
  }

  // METHODS:
  public void render() {
    cp5.getController("Restart").show();
    whistle.play();
    points = 0; 
    imageMode(CORNER);
    image(bg, 0, 0);
    imageMode(CENTER);
  }
} // class end