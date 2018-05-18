class SuicideEmu extends Emu {
  PImage runPhotos[] = new PImage[38];
  PImage runPhotosF[] = new PImage[38];
  PImage smashPhotos[] = new PImage[30];
  PImage smashPhotosF[] = new PImage[30];
  SuicideEmu(float x, float y, float size) {
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
      explosions.add(new Explosion(myX, myY, 100));
    }
  }

  void update() {
    super.update();
    if (frameNum > runPhotos.length - 1) {
      frameNum = 1;
    }

    if (xVelocity() > 0) {
      image(runPhotosF[frameNum], myX, myY);
    } else {
      image(runPhotos[frameNum], myX, myY);
    }

    if (myHP <= 0) {
      explosions.add(new Explosion(myX, myY, 70));
    }
  }
}