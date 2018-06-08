class AfghanExplode {
  float myX, myY, myRadius;
  int frameNum = 1;
  PImage explodePhotos[] = new PImage[24];
  boolean completed;
  AfghanExplode(float x, float y, float radius) {
    myX = x;
    myY = y;
    myRadius = radius;


    for (int i = 1; i < explodePhotos.length; i++) {
      explodePhotos[i] = afghanEmuExplode[i].copy();
      explodePhotos[i].resize((int) (radius*100), (int) (radius*100));
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
    if (frameCount%2 == 0) {
      frameNum++;
      if (frameNum >= explodePhotos.length - 1) {
        completed = true;
      }
    }

    image(explodePhotos[frameNum], myX, myY);
  }
}