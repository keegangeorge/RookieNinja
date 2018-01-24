public class WardrobeSelect {
  
  // FIELDS:
  PImage bg, preview;
  float  diam;
  PVector pos;
  int indexX, indexY;
  int spriteSize;

  // CONSTRUCTOR:
  WardrobeSelect() {
    bg = loadImage("Images/costumebg.png");
    diam = 80;
    pos = new PVector(165, 328);
    preview = loadImage("Images/PlayerColors.png");
    indexX = 0;
    indexY = 0;   
    spriteSize = 400;
  }

  // METHODS:
  public void render() {
    imageMode(CORNER);
    background(white);
    image(bg, 0, 0);
    stroke(white);
    strokeWeight(5);
    fill(red);
    ellipse(pos.x, pos.y, diam, diam);
    fill(255, 214, 3);
    ellipse(pos.x + 120, pos.y, diam, diam);
    fill(#49FA3A);
    ellipse(pos.x + 250, pos.y, diam, diam);
    fill(blue);
    ellipse(pos.x, pos.y + 150, diam, diam);
    fill(#F0187D);
    ellipse(pos.x + 120, pos.y + 150, diam, diam);
    fill(#830DD8);
    ellipse(pos.x + 250, pos.y + 150, diam, diam);
    image(preview.get(indexX, indexY, spriteSize, spriteSize), 689, 209);
    if (dist(mouseX, mouseY, pos.x, pos.y) < diam / 2 || 
      dist(mouseX, mouseY, pos.x + 120, pos.y) < diam / 2 ||
      dist(mouseX, mouseY, pos.x + 250, pos.y) < diam / 2 ||
      dist(mouseX, mouseY, pos.x, pos.y + 150) < diam / 2 ||
      dist(mouseX, mouseY, pos.x + 120, pos.y + 150) < diam / 2 ||
      dist(mouseX, mouseY, pos.x + 250, pos.y + 150) < diam / 2) {
      cursor(HAND);
    } else cursor(ARROW);

    if (mousePressed) {
      if (dist(mouseX, mouseY, pos.x, pos.y) < diam / 2) {
        indexX = 0;
        indexY = 0;
        ninja.playerCol = "RED";
        buttonClick.rewind();
        buttonClick.play();
      }

      if (dist(mouseX, mouseY, pos.x + 120, pos.y) < diam / 2) {
        indexX = 400;
        indexY = 0;
        ninja.playerCol = "YELLOW";
        buttonClick.rewind();
        buttonClick.play();
      }

      if (dist(mouseX, mouseY, pos.x + 250, pos.y) < diam / 2) {
        indexX = 800;
        indexY = 0;
        ninja.playerCol = "GREEN";
        buttonClick.rewind();
        buttonClick.play();
      }

      if (dist(mouseX, mouseY, pos.x, pos.y + 150) < diam / 2) {
        indexX = 0;
        indexY = 400;
        ninja.playerCol = "BLUE";
        buttonClick.rewind();
        buttonClick.play();
      }

      if (dist(mouseX, mouseY, pos.x + 120, pos.y + 150) < diam / 2) {
        indexX = 400;
        indexY = 400;
        ninja.playerCol = "PINK";
        buttonClick.rewind();
        buttonClick.play();
      }

      if (dist(mouseX, mouseY, pos.x + 250, pos.y + 150) < diam / 2) {
        indexX = 800;
        indexY = 400;
        ninja.playerCol = "PURPLE";
        buttonClick.rewind();
        buttonClick.play();
      }
    }

    imageMode(CENTER);
  } // render method end
} // class end