public class Hud {
  
  // FIELDS:
  private float ticker;
  private float timerSize;
  private float tickerDecrement;
  private color timerCol;
  private PVector pos;
  private PVector hudDim;
  private PFont hudFont;
  private HighJump jump;
  private SpeedUp fast;

  // CONSTRUCTOR:
  Hud() {
    ticker = 360;
    timerSize = 80;
    pos = new PVector(width / 2, 70);
    hudDim = new PVector(650, 70);
    timerCol = color(242, 49, 62);
    hudFont = loadFont("Fonts/HUDFONT.vlw");
    jump = new HighJump(new PVector(0, 0));
    fast = new SpeedUp(new PVector(0, 0));
    tickerDecrement = 0.25;
  }

  // METHODS:
  public void render() {
    pushMatrix();
    noStroke();
    fill(timerCol, 200);
    translate(pos.x, pos.y);
    rect(-hudDim.x / 2, -hudDim.y / 2, hudDim.x, hudDim.y, 50);
    popMatrix();

    pushMatrix();
    translate(pos.x, pos.y);
    fill(timerCol);
    stroke(white);
    strokeWeight(5);
    ellipse(0, 0, timerSize + 20, timerSize + 20);
    noStroke();
    fill(white);
    ellipse(0, 0, timerSize + 5, timerSize + 5);
    fill(timerCol);
    noStroke();
    arc(0, 0, timerSize, timerSize, radians(0), radians(ticker));
    popMatrix();

    pushMatrix();
    fill(white);
    translate(pos.x + 267, pos.y + 12);
    textSize(48);
    textFont(hudFont);
    scale(0.7);
    image(coin, -23, -19);
    text(int(points), 22, -5);
    //text(int(ninja.progress) + "%", 0, 0);
    popMatrix();


    // PERKS DISPLAY:
    textFont(hudFont);
    textSize(22);
    text("PERKS: ", 355, 78);
    if (highJumpDisplay == true) {
      pushMatrix();
      scale(0.7);
      image(jump.symbol, 688, 98);
      popMatrix();
    }

    if (speedUpDisplay == true) {
      pushMatrix();
      scale(0.7);
      image(fast.symbol, 758, 98);
      popMatrix();
    }


    // HEALTH:
    float gap = 718;
    for (int i = 0; i < ninja.health; i++) {
     image(heart, 38*i + gap, 71);
    }
  }

  // UPDATES COUNTDOWN CLOCK:
  public void update() {
    ticker -= tickerDecrement;
    render();
    if (ticker <= 0) {
      gameState = GAME_OVER;
    }
  }
}