// GAME STATE = 0
public class IntroScreen {
  // FIELDS:
  PImage bg;
  
  // CONSTRUCTOR:
  IntroScreen() {
   bg = requestImage("Images/introbg.png"); 
  }

  // METHODS:
  void render() {
    imageMode(CORNER);
    cp5.getController("Start Game").hide();
    cp5.getController("Back").hide();
    cp5.getController("Restart").hide();
    cp5.getController("Level 1").hide();
    background(255);
    image(bg, 0, 0);
    imageMode(CENTER);
  }
}