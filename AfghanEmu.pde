// For documentation, see Emu class.
class AfghanEmu extends Emu {
  PImage runPhotos[] = new PImage[11];
  PImage runPhotosF[] = new PImage[11];
  AfghanEmu(float x, float y, float size) {
    super(x, y, size);  
    for (int i = 1; i < runPhotos.length; i++) {
      runPhotos[i] = afghanEmuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < runPhotosF.length; i++) {
      runPhotosF[i] = afghanEmuRunFlip[i].copy();
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

    if (myHP <= 0) {
      explosions.add(new Explosion(myX, myY, 100));
    }
  }

  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) {

     //afghanExplode.add(new AfghanExplode(myX, myY, 100));
      explosions.add(new Explosion(myX, myY, 100));
    }
  }
}
