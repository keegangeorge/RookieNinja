// INTERACTION INPUTS:

// KEY INTERACTIONS:
public void keyPressed() {
  // CHARACTER MOVEMENT:
  if (key == CODED && keyCode == RIGHT || key == 'd' || key == 'D') right = true;
  if (key == CODED && keyCode == LEFT  || key == 'a' || key == 'A') left = true;
  if (key == CODED && keyCode == UP    || key == 'w' || key == 'W') up = true;
  if (key == CODED && keyCode == DOWN  || key == 's' || key == 'S') down = true;
}

public void keyReleased() {
  // CHARACTER MOVEMENT:
  if (key == CODED && keyCode == RIGHT || key == 'd' || key == 'D') right = false;
  if (key == CODED && keyCode == LEFT  || key == 'a' || key == 'A') left = false;
  if (key == CODED && keyCode == UP    || key == 'w' || key == 'W') up = false;
  if (key == CODED && keyCode == DOWN  || key == 's' || key == 'S') down = false;
}