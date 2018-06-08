class Bush {
  int myX, myY;
  PImage myImage;
  float sizeFactor;
  Bush (int x, int y) {
    myX = x;
    myY = y;
    myImage = bushImages[int(random(0, 3))].copy();
    sizeFactor = random(0.2, 0.4);
    myImage.resize(int(myImage.width * sizeFactor), int(myImage.height * sizeFactor));
  }

  void update() {
    image(myImage, myX, myY);
  }
}