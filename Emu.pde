class Emu { 
  float myHP, maxHP, myX, myY, mySize, myFade, myXVel, myYVel, speedModifier, mobXDistance, mobYDistance;
  boolean dead, bleeding, movingUp, attacking, tracking, grouping, leaving = false;
  boolean moving = true;
  //PImage myPhoto, myPhotoF;
  int frameNum = (int) random(1, 33);
  int myGroup;
  //int frameNum2 = 1;
  float myWidth, myHeight, leaveX, leaveY;
  Emu (float x, float y, float size) {
    mobXDistance = random (-200, 200);
    mobYDistance = random (-200, 200);
    leaveX = random(width + 500, width + 501) * floor(random(-3, 3));
    leaveY = random(height + 500, height + 501) * floor(random(-3, 3));
    myX = x;
    myY = y;
    myHP = size*250;
    maxHP = myHP;
    mySize = size;
    myWidth = 0;
    myHeight = 0;
    speedModifier = 0.3/mySize;
    myGroup = int(random(0, 20));
    myWidth = mySize*400;
    myHeight = mySize*406;
  }

  void reduceHP (float damage) {
    myHP-=damage;
    if (!bleeding) {
      bleeding = true;
    }
    bloods.add(new Blood(myX, myY));
  }

  void reduceHP (float damage, boolean b) {
    myHP-=damage;
    if (b) {
      if (!bleeding) {
        bleeding = true;
      }
      bloods.add(new Blood(myX, myY));
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

  float getWidth() {
    return (mySize*400);
  }

  float getHeight() {
    return (mySize*406);
  }

  void setAttacking(boolean a) {
    attacking = a;
  }

  void setTracking(boolean t) {
    tracking = t;
  }

  void setGrouping(boolean g) {
    grouping = g;
  }

  void setLeaving (boolean l) {
    tracking = false;
    attacking = false;
    grouping = false;
    leaving = l;
  }

  // HEALTH BAR DRAW FUNCTION
  void healthBar() {
    if (myHP >= 0) {
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

  float toMobX() {
    float toMobX = 0;
    for (Level l : levels) {
      toMobX = myX - (l.getMobLocationX() + mobXDistance);
      toMobX = (toMobX/Math.abs(toMobX))*-0.5;
    }
    return toMobX;
  }

  float toMobY() {
    float toMobY = 0;
    for (Level l : levels) {
      toMobY = myY - (l.getMobLocationY() + mobYDistance);
      toMobY = (toMobY/Math.abs(toMobY))*-0.5;
    }
    return toMobY;
  }

  float toGroupX() {
    float toGroupX = 0;
    for (Level l : levels) {
      toGroupX = myX - l.getGroupLocationX(myGroup);
      toGroupX = (toGroupX/Math.abs(toGroupX))*-1;
    }
    return toGroupX;
  }

  float toGroupY() {
    float toGroupY = 0;
    for (Level l : levels) {
      toGroupY = myY - l.getGroupLocationY(myGroup);
      toGroupY = (toGroupY/Math.abs(toGroupY))*-1;
    }
    return toGroupY;
  }

  float toLeaveY() {
    float toLeaveY = 0;
    toLeaveY = myY - leaveY;
    toLeaveY = (toLeaveY/Math.abs(toLeaveY))*-2.5;
    return toLeaveY;
  }

  float toLeaveX() {
    float toLeaveX = 0;
    toLeaveX = myX - leaveX;
    toLeaveX = (toLeaveX/Math.abs(toLeaveX))*-2.5;
    return toLeaveX;
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
    if (tracking) {
      xVel = toTruckX();
    } else if (grouping) {
      xVel = toGroupX();
    } else if (leaving) {
      xVel = toLeaveX();
    } else {
      xVel = toMobX();
    }
    return xVel;
  }

  float yVelocity() {
    float yVel;
    if (tracking) {
      yVel = toTruckY() + bob();
    } else if (grouping) {
      yVel = toGroupY();
    } else if (leaving) {
      yVel = toLeaveY();
    } else {
      yVel = toMobY();
    }
    return yVel;
  }

  void attack() { 
    if (myX > truck.getX() - 100 && myX < truck.getX() + 100 && myY > truck.getY() - 100 && myY < truck.getY() + 100) { 
      attacking = true;
      if (frameCount%(int(random(125, 175))) == 0) { 
        truck.reduceHP(0.05);
        attacking = false;
      }
    } else {
      attacking = false;
    }
  }

  void update() {
    if (keepEmusOnScreen) {
      constrain(myX, 0, width);
      constrain(myY, 0, height);
    }
    grouping = group;    // Sets this emu's grouping and tracking variable based on the global group and track variable (set in the gun shoot method)
    tracking = track;
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
  }
}