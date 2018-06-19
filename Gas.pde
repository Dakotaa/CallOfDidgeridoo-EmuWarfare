// gas grenade
class Gas {
  PVector myPosition;
  PVector[] circles = new PVector[3];
  float alpha = 255;
  boolean completed = false;
  int maxSize;
  int size = 1;
  Gas (float x, float y, int max) {
    myPosition = new PVector(x, y);
    maxSize = max;
    for (int i = 0; i < circles.length; i++) {
      circles[i] = new PVector();
      circles[i].set((myPosition.x + random(-50, 50)), myPosition.y + random(-50, 50));
    }
  }

  boolean isComplete() {
    return completed;
  }

  void update() {
    if (size <= maxSize) {
      size++;
    }
    
    // loops through the gas circles and checks for emus inside, if so, damages them with no bleeding
    for (int i = 0; i < circles.length; i++) {
      for (Emu e : emus) {
        if (e.getX() > circles[i].x - size/2 && e.getX() < circles[i].x + size/2 && e.getY() > circles[i].y - size/2 && e.getY() < circles[i].y + size/2) {
          if (frameCount%40 == 0) {
            e.reduceHP(5, false);
          }
        }
      }
      
      // draws the gas circles
      fill(252, 205, 33, alpha);
      ellipse(circles[i].x, circles[i].y, size, size);
      
      // moves circles slightly to give them a more gaseous effect
      circles[i].x += random(-1, 1);
      circles[i].y += random(-1, 1);
    }
    
    // reduces alpha, making gas more transparent
    alpha -= 0.4;

    // when gas has dissipated, sets completed flag so the gas object will be removed on the next frame.
    if (alpha <= 0) {
      completed = true;
    }
  }
}
