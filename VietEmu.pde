class VietEmu extends Emu {
  PImage runPhotos[] = new PImage[24];
  PImage runPhotosF[] = new PImage[24];
  
  VietEmu(float x, float y, float size) {
    super(x, y, size);  
    //copy and resize of images
    for (int i = 1; i < runPhotos.length; i++) {
      runPhotos[i] = vietEmuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < runPhotosF.length; i++) {
      runPhotosF[i] = vietEmuRunFlip[i].copy();
      runPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }
  }

  //if they are within a certain area of the truck the may do 0.02 damage to the overall health
  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) { 
      if (frameCount%(int(random(125, 175))) == 0) { 
        truck.reduceHP(0.02);
      }
    }
  }

  void update() {
    super.update();
    //resets the frameNum when running through images
    if (frameNum > runPhotos.length - 1) {
      frameNum = 1;
    }
    //makes the emus opaque
    tint(255, 150);
    //running animations in both directions
    if (xVelocity() > 0) {
      image(runPhotosF[frameNum], myX, myY);
    } else {
      image(runPhotos[frameNum], myX, myY);
    }
    noTint();
  }
}