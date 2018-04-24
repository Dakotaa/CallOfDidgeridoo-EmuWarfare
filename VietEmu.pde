class VietEmu extends Emu {
  PImage runPhotos[] = new PImage[24];
  PImage runPhotosF[] = new PImage[24];
  int frameNum = (int) random(1, 23);
  VietEmu(float x, float y, float size) {
    super(x, y, size);  
    for (int i = 1; i < vietEmuRun.length; i++) {
      runPhotos[i] = vietEmuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < vietEmuRunFlip.length; i++) {
      runPhotosF[i] = vietEmuRunFlip[i].copy();
      runPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }
  }

  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) { 
      if (frameCount%(int(random(125, 175))) == 0) { 
        truck.reduceHP(0.02);
      }
    }
  }
}
