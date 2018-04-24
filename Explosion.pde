class Explosion {
  float myX, myY, myRadius;
  int frameNum = 0;
  boolean completed;
  PImage myExplosion[] = new PImage[64];
  Explosion(float x, float y, float radius) {
    myX = x;
    myY = y;
    myRadius = radius;
    for (int i = 1; i < myExplosion.length; i++) {
      myExplosion[i] = explosionAnimation[i].copy();
      myExplosion[i].resize((int) (myRadius * 3), (int) (myRadius * 3));
    }
  }

  void setX(float x) {
    myX = x;
  }

  void setY(float y) {
    myY = y;
  }

  boolean isComplete() {
    return completed;  
  }

  void update () {
    if (!completed) {
      frameNum++;
      image(myExplosion[frameNum], myX, myY);
      if (frameNum >= 63) {
        completed = true;
      }
    }
  }
}
