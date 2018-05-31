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
    for (int i = 0; i < circles.length; i++) {
      for (Emu e : emus) {
        if (e.getX() > circles[i].x - size/2 && e.getX() < circles[i].x + size/2 && e.getY() > circles[i].y - size/2 && e.getY() < circles[i].y + size/2) {
          if (frameCount%40 == 0) {
            e.reduceHP(5, false);
          }
        }
      }
      fill(252, 205, 33, alpha);
      ellipse(circles[i].x, circles[i].y, size, size);
      circles[i].x += random(-1, 1);
      circles[i].y += random(-1, 1);
    }
    alpha -= 0.4;

    if (alpha <= 0) {
      completed = true;
    }
  }
}