// decor - gets a position, size, rotation, and image
class Decor {
  int myX, myY, theta;
  float maxSizeFactor, sizeFactor;
  boolean rotate;
  PImage myImage;
  Decor (int x, int y, float size, boolean r, PImage image) {
    myX = x;
    myY = y;
    rotate = r;
    
    // chooses a random image from the passed array
    myImage = image.copy();
    sizeFactor = size;
    
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
