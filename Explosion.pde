class Explosion {
  float myX, myY, myRadius;
  int frameNum = 1;
  boolean completed;
  PImage myExplosion[] = new PImage[25];
  Explosion(float x, float y, float radius) {
    myX = x;
    myY = y;
    myRadius = radius;
    
    // loads explosion sprites and resizes them according to the radius
    for (int i = 1; i < myExplosion.length; i++) {
      myExplosion[i] = explosionAnimation[i].copy();
      myExplosion[i].resize((int) (myRadius * 3), (int) (myRadius * 3));
    }
    explosionSound.rewind();
    explosionSound.play();
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
      // damages (likely kills) all emus in the explosion radius
      for (Emu e : emus) {
        if (e.getX() > myX - myRadius && e.getX() < myX + myRadius && e.getY() > myY - myRadius && e.getY() < myY + myRadius) {
          // exploded boolean to make sure the emu takes damage from the explosion only once instead of every frame of the explosion
          if (!e.getExploded()) {
            e.setExploded(true);
            e.reduceHP(500);
          }
        }
      }
    
      // damages truck if near the explosion
      if (truck.getX() > myX - myRadius && truck.getX() < myX + myRadius && truck.getY() > myY - myRadius && truck.getY() < myY + myRadius) {
        truck.reduceHP(0.001);
      }
    
      // animates explosion
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
