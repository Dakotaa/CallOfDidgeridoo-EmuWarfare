class Blood {
  float myX, myY, myFade;
  PImage myImage;
  boolean faded;
  Blood(float x, float y) {
    myX = x  + random(-50, 50);
    myY = y  + random(-50, 50);
    myFade = 255;
    myImage = blood[(int) random(4)].copy();
  }

  boolean toRemove() {
    return faded;
  }

  void update() {
    if (myFade > 0) {
      myFade-=1;
    } else {
      faded = true;
    }
    tint(255, myFade);
    image(myImage, myX, myY);
    noTint();
  }
}
