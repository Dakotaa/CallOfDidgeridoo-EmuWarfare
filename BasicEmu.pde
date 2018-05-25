class BasicEmu extends Emu {
  PImage runPhotos[] = new PImage[34];
  PImage runPhotosF[] = new PImage[34];
  BasicEmu(float x, float y, float size) {
    super(x, y, size);
    for (int i = 1; i < runPhotos.length; i++) {
      runPhotos[i] = emuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < runPhotosF.length; i++) {
      runPhotosF[i] = emuRunFlip[i].copy();
      runPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
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
  }
}