class Gas {
  PVector myPosition;
  PVector[] circles = new PVector[4];
  float alpha = 255;
  boolean completed = false;
  Gas (float x, float y) {
    myPosition = new PVector(x, y);
    for (int i = 0; i < circles.length; i++) {
      circles[i] = new PVector();
      circles[i].set((myPosition.x + random(-100, 100)), myPosition.y + random(-100, 100));
    }
  }

  boolean isComplete() {
    return completed;  
  }

  void update() {
    for (int i = 0; i < circles.length; i++) {
      fill(252, 205, 33, alpha);
      ellipse(circles[i].x, circles[i].y, 250, 250);
      circles[i].x += random(-1, 1);
      circles[i].y += random(-1, 1);
    }
    alpha -= 0.4;
    
    if (alpha <= 0) {
        completed = true;
    }
  }
}
