class Emu { 
  float myHP, maxHP, myX, myY, mySize, myFade, myXVel, myYVel, speedModifier;
  boolean dead, bleeding, movingUp = false;
  PImage myPhoto, myPhotoF;
  Emu (float x, float y, float hp, float size) {
    myX = x;
    myY = y;
    myHP = hp;
    maxHP = hp;
    mySize = size;
    myFade = 255;
    myPhoto = emuPhoto.copy();
    myPhoto.resize((int) (mySize*400), (int) (mySize*406));

    myPhotoF = emuPhotoFlipped.copy();
    myPhotoF.resize((int) (mySize*400), (int) (mySize*406));
    
    speedModifier = 0.3/mySize;
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
    if (xVelocity() > 0) {
      image(myPhotoF, myX, myY);
    } else {
      image(myPhoto, myX, myY);
    }

    fill(0);
    healthBar();
  }
}
