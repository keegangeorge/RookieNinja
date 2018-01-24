// GAME STATE = 1
public class Instructions extends IntroScreen {
  
  // CONSTRUCTOR:  
  Instructions() {
    bg = loadImage("Images/instructions.png");  
  }

  // METHODS:
  public void render() {
    imageMode(CORNER);
    image(bg, 0, 0);
    imageMode(CENTER);
    cp5.getController("Level 1").hide();
  }
} // class end