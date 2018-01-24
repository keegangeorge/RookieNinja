public class Background {

  // FIELDS:
  private PImage cloud;
  private PImage assets;
  private PVector cloudPos;
  private PVector mountainPos;
  private PImage perception;
  private color mountainCol;
  private color grassColor;
  private PImage arch, tree, building;
  public  PImage door, blade;
  

  // CONSTRUCTOR:
  Background() {
    cloudPos = new PVector(100, 100);
    mountainCol = color(121, 165, 178);
    grassColor = color(111, 227, 80);
    mountainPos = new PVector(-601, 100);
    initImages();
    grabAssets();
  }

  // INITIALIZES ALL IMAGES:
  public void initImages() {
    cloud = loadImage("Images/cloud.png");
    assets = loadImage("Images/assets.png");
  }

  // CUTS PORTAINS FROM ASSET SHEET AND ASSIGNS IT TO SPECFIC VARIABLES:
  private void grabAssets() {
    perception = assets.get(0, 210, 2560, 244);
    arch = assets.get(1929, 770, 358, 230);
    tree = assets.get(0, 0, 262, 161);
    door = assets.get(0, 876, 74, 125);
    blade = assets.get(2411, 851, 150, 150);
    building = assets.get(255, 455, 321, 549);
  }

  // RENDERS MOVING CLOUDS:
  private void renderClouds() {
    imageMode(CENTER);
    image(cloud, cloudPos.x, cloudPos.y);
    pushMatrix();
    scale(-1, 1);
    image(cloud, -(cloudPos.x + 800), cloudPos.y);
    popMatrix();
    cloudPos.x += 1;

    if (cloudPos.x >= width) {
      cloudPos.x = 0;
    }
  }

  // SCENERY IN LEVEL 1:
  private void scenery() {
    fill(mountainCol);
    // Draws 2 mountains shapes
    pushMatrix();
    translate(mountainPos.x, mountainPos.y);
    // first mountain:
    triangle(180, 582, 711, 155, 1280, 580);
    fill(155, 187, 195);
    // second mountain:
    triangle(1097, 580, 1595, 44, 2089, 577);
    fill(white);
    // first mountain snow:
    beginShape();
    vertex(600, 244);
    vertex(712, 154);
    vertex(867, 270);
    vertex(703, 243);
    vertex(661, 323);
    endShape();
    // second mountain snow:
    beginShape();
    vertex(1438, 211);
    vertex(1595, 45);
    vertex(1688, 143);
    vertex(1602, 254);
    vertex(1504, 201);
    endShape();
    popMatrix();
    // Asset Images:
    imageMode(CORNER);
    // Mountainous Shadow:
    image(perception, 1333, 502);
    image(perception, -939, 500);
    // Arch near beginning:
    image(arch, -595, 500);
    // First Tree:
    image(tree, 585, 570);
    pushMatrix();
    scale(0.8);
    // Second Tree:
    image(tree, 1901, 678);
    popMatrix();
    imageMode(CENTER);
    pushMatrix();
    translate(-618, 743);
    fill(grassColor);
    // First Patch of Grass:
    arc(0, 0, 642, 116, radians(175), radians(366));
    // Second Patch of Grass:
    arc(1011, 0, 751, 108, radians(175), radians(366));
    // Third Patch of Grass:
    arc(2146, 3, 1099, 187, radians(175), radians(366));
    popMatrix();
  }
} // class end