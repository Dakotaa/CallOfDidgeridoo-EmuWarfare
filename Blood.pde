class Blood {
  float myX, myY, myFade;
  int rotate;
  PImage myImage;
  boolean faded;
  Blood(float x, float y) {
    myX = x  + random(-40, 40);
    myY = y  + random(-40, 40);
    myFade = 255;
    myImage = blood[(int) random(4)].copy();
    rotate = ((int) random(1, 8)) * 45;
  }

  boolean toRemove() {
    return faded;
  }

  void update() {
    if (myFade > 0) {
      myFade-=2;
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
