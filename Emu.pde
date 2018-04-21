class Emu { 
  float myHP, maxHP, myX, myY, mySize, myFade, myXVel, myYVel, speedModifier;
  boolean dead, bleeding, movingUp = false;
  PImage myPhoto, myPhotoF;
  int frameNum = (int) random(1, 33);
  PImage runPhotos[] = new PImage[34];
  PImage runPhotosF[] = new PImage[34];
  Emu (float x, float y, float size) {
    myX = x;
    myY = y;
    myHP = size*250;
    maxHP = myHP;
    mySize = size;
    myFade = 255;
    for (int i = 1; i < runPhotos.length; i++) {
      runPhotos[i] = emuRun[i].copy();
      runPhotos[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    for (int i = 1; i < runPhotosF.length; i++) {
      runPhotosF[i] = emuRunFlip[i].copy();
      runPhotosF[i].resize((int) (mySize*400), (int) (mySize*406));
    }

    /*
    myPhoto = emuPhoto.copy();
     myPhoto.resize((int) (mySize*400), (int) (mySize*406));
     
     myPhotoF = emuPhotoFlipped.copy();
     myPhotoF.resize((int) (mySize*400), (int) (mySize*406));
     */
    speedModifier = 0.2/mySize;
  }

  void reduceHP (float damage) {
    myHP-=damage;
    if (!bleeding) {
      bleeding = true;
    }
  }

  boolean isDead() {
    return dead;
  }

  float getX() {
    return myX;
  }

  float getY() {
    return myY;
  }


  // HEALTH BAR DRAW FUNCTION
  void healthBar() {
    if (myHP != maxHP) {
      if (myHP > (maxHP*0.75)) {
        fill(0, 255, 0);
      } else if (myHP > (maxHP * 0.25)) {
        fill(255, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      rectMode(CORNER);
      rect(myX-(203*mySize), (myY+(203*mySize))+5, (400*mySize)*(myHP/maxHP), 10);
      rectMode(CENTER);
    }
  }



  float toTruckX() {
    float toX = myX - truck.getX();
    toX = (toX/Math.abs(toX))*-random(0.5, 2);
    return toX;
  }

  float toTruckY() {
    float toY = myY - truck.getY();
    toY = (toY/Math.abs(toY))*-random(0.5, 2);
    return toY;
  }

  float bob() {
    float yVel = 0;
    if (frameCount%(int)random(60, 200) == 0) {
      movingUp = !movingUp;
    }

    if (myY >= height || myY <= 0) {
      movingUp = !movingUp;
    }
    if (movingUp) {
      yVel++;
    } else {
      yVel--;
    }
    return yVel;
  }


  float xVelocity() {
    float xVel;
    xVel = toTruckX();
    return xVel;
  }

  float yVelocity() {
    float yVel;
    yVel = toTruckY() + bob();
    return yVel;
  }
  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) { 
      if (frameCount%(int(random(125, 175))) == 0) { 
        truck.reduceHP(0.01);
      }
    }
  }
  void update() {
    if (frameCount%(int(random(20, 40))) == 0) {
      myXVel = xVelocity();
      myYVel = yVelocity();
    }

    myX += myXVel*speedModifier;
    myY += myYVel*speedModifier;

    if (bleeding) {
      if (myFade > 0) {
        myFade-=3;
        tint(255, myFade);
        image(blood, myX, myY);
        noTint();
      } else {
        myFade = 255;
        bleeding = false;
      }
    }
    ArrayList<Bullet> toRemove = new ArrayList();
    for (Bullet b : bullets) {
      if (b.getX() > myX-(200*mySize) && b.getX() < myX+(200*mySize) && b.getY() > myY-(203*mySize) && b.getY() < myY+(203*mySize)) {
        toRemove.add(b);
        reduceHP(5);
      }
    }
    bullets.removeAll(toRemove);
    if (myHP <= 0) {
      dead = true;
    }
    fill(157, 100, 67);
    if (frameCount%2 == 0) {
      frameNum++;
    }
    if (frameNum > 30) {
      frameNum = 1;
    }

    if (xVelocity() > 0) {
      image(runPhotosF[frameNum], myX, myY);
    } else {
      image(runPhotos[frameNum], myX, myY);
    }

    fill(0);
    attack();
    healthBar();
  }
}
