public class Block {
  
  // FIELDS:
  PVector pos, dim;
  PImage tile;

  // CONSTRUCTORS:
  Block(PVector pos, PVector dim) {
    this.pos = pos;
    this.dim = dim;
    tile = requestImage("Images/tile.png");
  }

  Block(PVector pos) {
    this.pos = pos;
  }

  // METHODS:
  public void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    image(tile, 0, 0, dim.x, dim.y);
    popMatrix();
  }

  public boolean isOn(Player p) {
    // checks if character stays on block
    if (abs(p.pos.x - pos.x) < p.dim.x / 2 + dim.x / 2) {
      return true;
    }
    return false;
  } 

  public boolean bump(Player p) {
    if (abs(p.pos.x - pos.x) < p.dim.x / 2 + dim.x / 2 &&
      abs(p.pos.y - pos.y) < p.dim.y / 2 + dim.y / 2) {
      return true;
    }
    return false;
  }
} // class end