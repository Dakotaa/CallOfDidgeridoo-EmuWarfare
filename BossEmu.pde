class BossEmu extends Emu {
  PImage runPhotos[] = new PImage[34];
  PImage runPhotosF[] = new PImage[34];
  float myTheta;
  //emu object that does not change size(easier for larger amounts of emus, better performance)
  BossEmu(float x, float y, float size) {
    super(x, y, size);
    myHP = 5000;
    maxHP = myHP;
    mySize = size;
    speedModifier = 1;

    for (int i = 1; i < runPhotos.length; i++) {
      runPhotos[i] = emuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < runPhotosF.length; i++) {
      runPhotosF[i] = emuRunFlip[i].copy();
      runPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }
  }

  void spitAttack() {
    projectiles.add(new Spit(new PVector(myX, myY), 15, 90, truck.getX(), truck.getY()));
  }

  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) { 
      attacking = true;
      if (frameCount%(int(random(100, 130))) == 0) { 
        truck.reduceHP(0.08);
        attacking = false;
      }
    } else {
      attacking = false;
    }
  }

  void update() {
    if (frameNum > runPhotos.length - 1) {
      frameNum = 1;
    }

    if (xVelocity() > 0) {
      image(runPhotosF[frameNum], myX, myY);
    } else {
      image(runPhotos[frameNum], myX, myY);
    }

    if (keepEmusOnScreen) {
      constrain(myX, 0, width);
      constrain(myY, 0, height);
    }

    tracking = true;

    if (attacking) {
      moving = false;
    } else {
      moving = true;
    }

    if (!grouping) {
      if (frameCount%(int(random(20, 40))) == 0) {
        myXVel = xVelocity();
        myYVel = yVelocity();
      }
    } else {
      if (frameCount%(int(random(10, 20))) == 0) {
        myXVel = xVelocity();
        myYVel = yVelocity();
      }
    }

    if (moving) {
      myX += myXVel*speedModifier;
      myY += myYVel*speedModifier;
    }

    ArrayList<Bullet> toRemove = new ArrayList();
    for (Bullet b : bullets) {
      if (b.getX() > myX-(myWidth/2) && b.getX() < myX+(myWidth/2) && b.getY() > myY-(myHeight/2) && b.getY() < myY+(myHeight/2)) {
        toRemove.add(b);
        reduceHP(b.getDamage());
      }
    }
    bullets.removeAll(toRemove);

    if (bleeding) {
      if (frameCount%((int) random(180, 500)) == 0) {
        bloods.add(new Blood(myX, myY));
      }
    }

    if (myHP <= 0) {
      dead = true;
    }
    fill(157, 100, 67);
    if (frameCount%2 == 0) {
      frameNum++;
    }


    fill(0);
    attack();
    healthBar();
    rectMode(CENTER);

    if (frameCount%120 == 0) {
      spit.play();
      spit.rewind();
      if (frameCount%120 == 0) {
        spitAttack();
      }
    }
  }
}