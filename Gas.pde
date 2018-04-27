class Gas {
  float numCircles;
  PVector myPosition;
  PVector[] circles = new PVector[5];
  Gas (float x, float y, float ncircles) {
     myPosition = new PVector(x, y);
     numCircles = ncircles;
     for (int i = 0; i < 5; i++) {
       circles[i] = new PVector();
       circles[i].set((myPosition.x + random(-50, 50)), myPosition.y + random(-50, 50));
       
     }
  }
  
  void update() {
     for (int i = 0; i < 5; i++) {
       fill(252, 205, 33, 100);
       ellipse(circles[i].x, circles[i].y, 150, 150);
     }
  }
  
  
}
