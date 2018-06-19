 // For documentation, see Emu class.
class BuffEmu extends Emu {
  boolean smashing;
  PImage runPhotos[] = new PImage[38];
  PImage runPhotosF[] = new PImage[38];
  PImage smashPhotos[] = new PImage[30];
  PImage smashPhotosF[] = new PImage[30];
  BuffEmu(float x, float y, float size) {
    super(x, y, size);  
    for (int i = 1; i < runPhotos.length; i++) {
      runPhotos[i] = buffEmuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < runPhotosF.length; i++) {
      runPhotosF[i] = buffEmuRunFlip[i].copy();
      runPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < smashPhotos.length; i++) {
      smashPhotos[i] = buffEmuSmash[i].copy();
      smashPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < smashPhotosF.length; i++) {
      smashPhotosF[i] = buffEmuSmashFlip[i].copy();
      smashPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }
  }

  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) {
      smashing = true;
      if (frameCount%(int(random(125, 175))) == 0) { 
        truck.reduceHP(0.05);
      }
    } else {
      smashing = false;
    }
  }

  void update() {
    super.update();

    if (smashing) {
      if (frameNum > smashPhotos.length - 1) {
        frameNum = 1;
      }
      if (xVelocity() > 0) {
        image(smashPhotosF[frameNum], myX, myY);
      } else {
        image(smashPhotos[frameNum], myX, myY);
      }
    } else {
      if (frameNum > runPhotos.length - 1) {
        frameNum = 1;
      }

      if (xVelocity() > 0) {
        image(runPhotosF[frameNum], myX, myY);
      } else {
        image(runPhotos[frameNum], myX, myY);
      }
    }
  }
}
