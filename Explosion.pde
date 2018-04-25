class Explosion {
  float myX, myY, myRadius;
  int frameNum = 1;
  boolean completed;
  PImage myExplosion[] = new PImage[25];
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
      for (Emu e : emus) {
        if (e.getX() > myX - myRadius && e.getX() < myX + myRadius && e.getY() > myY - myRadius && e.getY() < myY + myRadius) {
          e.reduceHP(500);
        }
      }

      if (frameCount%2 == 0) {
        frameNum++;
        if (frameNum >= myExplosion.length - 1) {
          completed = true;
        }
      }
      
      image(myExplosion[frameNum], myX, myY);
      
    }
  }
}
