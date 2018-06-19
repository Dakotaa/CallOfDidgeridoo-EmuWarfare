class Emu { 
  float myHP, maxHP, myX, myY, mySize, myFade, myXVel, myYVel, speedModifier, mobXDistance, mobYDistance;
  boolean dead, bleeding, movingUp, attacking, tracking, grouping, leaving, exploded = false;
  boolean moving, removeOnKill = true;
  //PImage myPhoto, myPhotoF;
  int frameNum = (int) random(1, 33);
  int myGroup;
  //int frameNum2 = 1;
  float myWidth, myHeight, leaveX, leaveY;
  Emu (float x, float y, float size) {
    // sets a random distance away from the emu's mob location for it to follow
    mobXDistance = random (-300, 300);
    mobYDistance = random (-300, 300);
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
    
    // assigns emu to a random group (for spreading into small groups)
    myGroup = int(random(0, 20));
    myWidth = mySize*400;
    myHeight = mySize*406;
  }

  // function to reduce emu's HP, make it start bleeding, and add a blood
  void reduceHP (float damage) {
    myHP-=damage;
    bleeding = true;
    bloods.add(new Blood(myX, myY));
  }

  // damage function that does the same as above, but has option to not make emu bleed
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
  
  boolean getExploded() {
    return exploded;  
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

  void setExploded(boolean e) {
    exploded = e;  
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

  // draws health bar under emu
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


 // functions to calculate velocity towards the following targets
 
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

  // adds random "bobbing" to emu's velocity to make their movement seem a bit more natural
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

  // sets emu's velocities based on it's movement setting
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

  // when emu is near truck, attacks at intervals, damaging truck and setting attacking to true for attack animation
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

    // emu changes its velocity less often when not grouping (so grouped emus stay tighter together)
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

    // finally, moves emu based on their velocity and set speed modifier
    if (moving) {
      myX += myXVel*speedModifier;
      myY += myYVel*speedModifier;
    }

    // checks if each bullet hits the emu, removes the bullet and damages emu if true
    ArrayList<Bullet> toRemove = new ArrayList();
    for (Bullet b : bullets) {
      if (b.getX() > myX-(myWidth/2) && b.getX() < myX+(myWidth/2) && b.getY() > myY-(myHeight/2) && b.getY() < myY+(myHeight/2)) {
        toRemove.add(b);
        reduceHP(b.getDamage());
      }
    }
    bullets.removeAll(toRemove);

    // if the emu is bleeding, randomly adds some blood (only for effect, does not damage emu)
    if (bleeding) {
      if (frameCount%((int) random(180, 500)) == 0) {
        bloods.add(new Blood(myX, myY));
      }
    }

    // if the emu is set to be removed on kill (true for all emus except the boss), sets emu's dead flag to true, to be removed on the next frame in the level class.
    if (myHP <= 0) {
      if(removeOnKill) {
         dead = true; 
      }
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
