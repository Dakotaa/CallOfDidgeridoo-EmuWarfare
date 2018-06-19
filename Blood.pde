class Blood {
  float myX, myY, myFade;
  int rotate;
  PImage myImage;
  boolean faded;

  // Blood constructor. Gives position a random offset and rotates it by a random 45 degree angle.
  Blood(float x, float y) {
    myX = x  + random(-30, 30);
    myY = y  + random(-30, 30);
    myFade = 255;
    myImage = blood[(int) random(4)].copy();
    rotate = ((int) random(1, 8)) * 45;
  }

  boolean toRemove() {
    return faded;
  }

  void update() {
    if (myFade > 0) {  // Fades blood, removes it when faded.
      myFade-=3;
    } else {
      faded = true;
    }

    pushMatrix();
    translate(myX, myY);
    rotate(rotate);
    tint(255, myFade);
    image(myImage, 0, 0);
    noTint();
    popMatrix();
  }
}
