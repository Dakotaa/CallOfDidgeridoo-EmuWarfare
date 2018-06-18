class BossEmu extends Emu {
  boolean smashing, reeing;
  PImage runPhotos[] = new PImage[34];
  PImage runPhotosF[] = new PImage[34];
  PImage smashPhotos[] = new PImage[30];
  PImage smashPhotosF[] = new PImage[30];
  PImage emuReePhotos[] = new PImage[121];
  float myTheta;
  int frame, shots, fastFrames = 0;
  boolean spitting, rapidSpitting, fast;
  BossEmu(float x, float y, float size) {
    super(x, y, size);
    myHP = 5000;
    maxHP = myHP;
    mySize = size;
    speedModifier = 1;

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
    for (int i = 1; i < smashPhotosF.length; i++) {
      smashPhotosF[i] = buffEmuSmashFlip[i].copy();
      smashPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }
    for (int i = 1; i < emuReePhotos.length; i++) {
      emuReePhotos[i] = emuRee[i].copy();
      emuReePhotos[i].resize((int) (mySize*450), (int) (mySize*456));
    }
  }

  // Regular spit attack. Will shoot any amount of spits, as defined by low and high angles.
  void spitAttack(int low, int high) {
    for (int i = low; i < high; i++) {
      projectiles.add(new Spit(new PVector(myX, myY), 10, i, truck.getX(), truck.getY()));
    }
  }

  // Overwridden attack function, does more damage than a regular emu.
  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) {
      smashing = true;
      if (frameCount%(int(random(125, 175))) == 0) { 
        truck.reduceHP(0.03);
      }
    } else {
      smashing = false;
    }
  }

  void update() {
    super.update();
    reeing = false;

    if (frameNum > runPhotos.length - 1) {
      frameNum = 1;
    }
    if (smashing) {
      if (frameNum > smashPhotos.length - 1) {
        frameNum = 1;
      }
      if (xVelocity() > 0 && reeing == false) {
        image(smashPhotosF[frameNum], myX, myY);
      } else if (xVelocity() < 0 && reeing == false) {
        image(smashPhotos[frameNum], myX, myY);
      }
    } else {
      if (xVelocity() > 0 && reeing == false) {
        image(runPhotosF[frameNum], myX, myY);
      } else if (xVelocity() < 0 && reeing == false) {
        image(runPhotos[frameNum], myX, myY);
      } else if (myHP <= 0) {
        reeing = true;
        if (reeing) {
          image(emuReePhotos[frameNum], myX, myY);
          ree.rewind();
          ree.play();
        }
      }
    }

    track = true;

    //if (myHP <= 0) {
    //  reeing = true;
    //  if (reeing) {
    //    image(emuReePhotos[frameNum], myX, myY);
    //    ree.rewind();
    //    ree.play();
    //  }
    //}

    fill(157, 100, 67);

    if (frameCount%2 == 0) {
      frameNum++;
    }

    fill(0);

    if (frameCount%240 == 0) {
      spitting = true;
      spit.play();
      spit.rewind();
    }

    if (frameCount%360 == 0) {
      fast = true;
    }

    if (rapidSpitting) {
      if (frameCount%5 == 0) {
        projectiles.add(new Spit(new PVector(myX, myY), 10, 0, truck.getX(), truck.getY()));
        shots++;
      }

      if (shots == 7) {
        rapidSpitting = false;
        shots = 0;
      }
    }

    if (fast) {
      speedModifier = 3.0;
      fastFrames++;
      if (fastFrames > 60) {
        fast = false;
        fastFrames = 0;
      }
    } else {
      speedModifier = 1.0;
    }

    if (spitting) {
      frame++;

      if (frame >= 110) {
        if (myHP > 3000) {
          spitAttack(0, 1);
        } else if (myHP > 2000) {
          spitAttack(-2, 2);
        } else if (myHP < 2000) {
          rapidSpitting = true;
        }
        frame = 0;
        spitting = false;
      }
    }
  }
}