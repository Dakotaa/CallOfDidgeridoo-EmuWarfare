class Decor {
  int myX, myY, theta;
  float sizeFactor;
  boolean rotate;
  PImage myImage;
  Decor (int x, int y, boolean r, PImage[] images) {
    myX = x;
    myY = y;
    rotate = r;

    myImage = bushImages[int(random(0, images.length))].copy();
    sizeFactor = random(0.2, 0.4);
    
    myImage.resize(int(myImage.width * sizeFactor), int(myImage.height * sizeFactor));
    if (rotate) {
      theta = 45 * int(random(0, 8));
    }
  }

  void update() {  
    pushMatrix();
    translate(myX, myY);
    rotate(theta);
    image(myImage, 0, 0);
    popMatrix();
  }
}