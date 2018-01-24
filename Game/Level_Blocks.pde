public void levelOneBlocks() {
  // Blocks for Level One (POS, DIM):

  blocks.add(new Block(new PVector(0 - 750, height + BLOCK_SIZE.y / 2), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(0, height + BLOCK_SIZE.y / 2), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(650, height + BLOCK_SIZE.y / 2), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1200, height - 100), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1400, height - 420), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(2800, height - 450), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(3800, height - 460), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
}

public void levelTwoBlocks() {
  //Blocks for Level Two (POS, DIM):

  blocks.add(new Block(new PVector(-730, 664), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(-100, 600), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(400, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(800, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(950, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1000, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1200, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1400, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1600, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
    
  blocks.add(new Block(new PVector(1800, 750),
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
    
  blocks.add(new Block(new PVector(2500, 650),
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(2900, 500),
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1500, 500), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1000, 200), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
    
  blocks.add(new Block(new PVector(3500, 600),
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
    
  blocks.add(new Block(new PVector(3900, 760),
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
}

public void levelThreeBlocks() {
  // Blocks for Level Three (POS, DIM):
  
  blocks.add(new Block(new PVector(-830, 300), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(0, 755), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
    
  blocks.add(new Block(new PVector(550, 500), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(900, 720), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(1800, 400), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(2300, 300), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(2900, 700), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));

  blocks.add(new Block(new PVector(3500, 750), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y)));
}


// initializes dynamic blocks
public void specialBlocks() {
  movingBlock = new Block(new PVector(1650, height - 250), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y));

  scalingBlock = new Block(new PVector(3350, height - 200), 
    new PVector(BLOCK_SIZE.x, BLOCK_SIZE.y));
}