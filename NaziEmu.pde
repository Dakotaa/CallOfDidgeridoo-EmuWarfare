class NaziEmu extends Emu {
  boolean attacking, attackinDone;
  PImage runPhotos[] = new PImage[34];
  PImage runPhotosF[] = new PImage[34];
  PImage attackPhotos[] = new PImage[34];
  PImage attackPhotosF[] = new PImage[34];

  NaziEmu(float x, float y, float size) {
    super(x, y, size);  
    for (int i = 1; i < runPhotos.length; i++) {
      runPhotos[i] = naziEmuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < runPhotosF.length; i++) {
      runPhotosF[i] = naziEmuRunFlip[i].copy();
      runPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < attackPhotos.length; i++) {
      attackPhotos[i] = naziEmuAttack[i].copy();
      attackPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < attackPhotosF.length; i++) {
      attackPhotosF[i] = naziEmuAttackFlip[i].copy();
      attackPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }
  }

  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) { 
      attacking = true;
      if (frameCount%(int(random(125, 175))) == 0) { 
        truck.reduceHP(0.05);
      } else {
        attacking = false;
      }
    }
  }

  void update() {
    super.update();

    if (attacking) {
      if (frameNum > attackPhotos.length - 1) {
        frameNum = 1;
      }
      if (xVelocity() > 0) {
        image(attackPhotosF[frameNum], myX, myY);
      } else {
        image(attackPhotos[frameNum], myX, myY);
      }
    }
    if(frameNum > runPhotos.length - 1) {
      frameNum = 1;
    }

    if (xVelocity() > 0) {
      image(runPhotosF[frameNum], myX, myY);
    } else {
      image(runPhotos[frameNum], myX, myY);
    }
  }
}
