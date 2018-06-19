class BossEmu extends Emu {
  boolean smashing;
  boolean reeing = false;
  PImage runPhotos[] = new PImage[34];
  PImage runPhotosF[] = new PImage[34];
  PImage smashPhotos[] = new PImage[30];
  PImage smashPhotosF[] = new PImage[30];
  PImage emuReePhotos[] = new PImage[121];
  int frameNum2 = 1;
  float myTheta;
  int frame, shots, fastFrames = 0;
  boolean spitting, rapidSpitting, fast, reed;
  BossEmu(float x, float y, float size) {
    super(x, y, size);
    myHP = 4000;
    maxHP = myHP;
    mySize = size;
    speedModifier = 1;
    
    // sets removeOnKill to false so the Boss does not disappear before reeing.
    removeOnKill = false;

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
      emuReePhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }
  }

  // regular spit attack. Will shoot any amount of spits, as defined by low and high angles.
  void spitAttack(int low, int high) {
    for (int i = low; i < high; i++) {
      projectiles.add(new Spit(new PVector(myX, myY), 11, i, truck.getX(), truck.getY()));
    }
  }

  // overwridden attack function, does more damage than a regular emu.
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


    // when killed, the boss will play the ree sound and start ree animation.
    if (myHP <= 0) {
      if (!reed) {
        ree.rewind();
        ree.play();
        reed = true;
      }
      // frameNum2 to animate reeing
      frameNum2 ++;
      reeing = true;
    }
    
    // once the animation has played (120 frames), kills the boss
    if (frameNum2 > emuReePhotos.length - 1) {
      frameNum2 = 120;
      dead = true;
      
    }
    if (frameNum > runPhotos.length - 1) {
      frameNum = 1;
    }
    
    // animates attack and movement when not reeing
    if (smashing && reeing == false) {
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
      } else {
        spitting = false;
        rapidSpitting = false;
        fast = false;
        moving = false;
        movingUp = false;
        image(emuReePhotos[frameNum2], myX - 50, myY);
      }
    }

    // sets the boss to always track the truck
    track = true;
  
    // frameNum to animate movement.
    if (frameCount%2 == 0) {
      frameNum++;
    }

    // starts spit attack every 240 frames (4 seconds, ideally)
    if (frameCount%240 == 0) {
      spitting = true;
      spit.play();
      spit.rewind();
    }

    // increases boss' speed for a moment every 360 frames (6 seconds)
    if (frameCount%360 == 0) {
      fast = true;
    }

    // if doing a rapid spitting attack, creates a new spit projectile every 5 frames (0.08 seconds), increasing the shots variable
    if (rapidSpitting) {
      if (frameCount%5 == 0) {
        projectiles.add(new Spit(new PVector(myX, myY), 11, 0, truck.getX(), truck.getY()));
        shots++;
      }

      // if 7 spits have been shot, disables rapid spitting and resets shots for next attack
      if (shots == 7) {
        rapidSpitting = false;
        shots = 0;
      }
    }

    // when fast mode is enabled, triples the boss' speed for 60 frames (1 second). After 60 frames, fast mode is disabled again and the speed is set back to normal.
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
    
    // frame is used to time the spit attack correctly according to the sound effect (effect takes roughly 110 frames to get to the "spitting" sound)
    if (spitting) {
      frame++;
  
      // decides which spit attack to use based on boss' HP
      if (frame >= 110) {
        if (myHP > 2500) {    // does normal, one spit attack when over 2500 HP
          spitAttack(0, 1);
        } else if (myHP > 1000) {    // does a 3-spit attack when below 2500 and over 1000
          spitAttack(-2, 2);
        } else if (myHP < 1000) {    // does rapid 7-shot spit when under 1000 (final stage)
          rapidSpitting = true;
        }
        frame = 0;        // sets frame back to 0 and spitting to false to reset and end attack.
        spitting = false;
      }
    }
  }
}
