// https://www.openprocessing.org/sketch/141841
class Truck {
  //declaration of floats, booleans, and pVectors
  PVector myLocation;
  PVector frontWheel;
  PVector backWheel;
  float myHeading, mySpeed, myBaseMaxSpeed, myMaxSpeed, mySteerAngle, myMaxSteerAngle, myWheelBase, myMinWheelBase, myMaxWheelBase, myHP, maxHP, carSize;
  boolean plus, minus, up, down, left, right, steerLock, exploding, exploded, timerStarted; 

  //timer for how long the explosion of the truck lasts
  Timer explosionTimer = new Timer(8);

  //truck object(what all it's variables mean
  Truck(float maxSpeed) {
    up = down = left = right = steerLock = false;
    myLocation = new PVector(860, 540);
    myHeading = PI;
    mySpeed = 0;
    myBaseMaxSpeed = maxSpeed;
    myMaxSpeed = myBaseMaxSpeed;
    mySteerAngle = 0;
    myWheelBase = 150;
    myMaxSteerAngle = PI/4;
    maxHP = 1;
    myHP = maxHP;
    carSize = 8;
  }

  //return function for speed
  float getSpeed() {
    return mySpeed;
  }

  //location of vehicle on x and y plane
  void setX (float x) {
    myLocation.x = x;
  }

  void setY (float y) {
    myLocation.y = y;
  }

  //return function for truck x and y locations  
  float getX() {
    return myLocation.x;
  }

  float getY() {
    return myLocation.y;
  }

  //return functions for gun x and y locations
  float gunX() {
    return myLocation.x;
  }

  float gunY() {
    return myLocation.y;
  }

  void setHeading(float heading) {
    myHeading = heading;
  }
  void setSteerAngle(float steerAngle) {
    mySteerAngle = steerAngle;
  }
  void setSpeed(float speed) {
    mySpeed = speed;
  }
  void setWheelBase(float wb) {
    myWheelBase = wb;
  }
  void setLeft (boolean l) {
    left = l;
  }
  void setRight(boolean r) {
    right = r;
  }
  void setUp(boolean u) {
    up = u;
  }
  void setDown(boolean d) {
    down = d;
  }

  void reduceHP(float dmg) {
    myHP-=dmg;
  }

  void setHP (float h) {
    myHP = h;
    if (myHP > 1) myHP = 1;
  }

  void setMaxSpeed() {
    myMaxSpeed = myHP * myBaseMaxSpeed;
  }

  void resetMaxSpeed() {
    myMaxSpeed = 6;
  }

  //this is the function for the damage on the car, it determines what HP the vehicle is at as well as what level it is on(using instanceof), once this is decided it implements the proper images onto the trucks location
  void carDamage() {
    if (myHP > 0) {
      if (myHP != maxHP) {
        pushMatrix();
        imageMode(CENTER);
        translate(myLocation.x, myLocation.y);
        rotate(-myHeading);
        for (Level l : levels) {
          if (l instanceof LevelVietnam) {
            if (myHP < 0.25) {
              image(carDamage[2], 0, 0);
              image(vietCarDamage[2], 0, 0);
            } else if (myHP < 0.5) {
              image(carDamage[1], 0, 0);
              image(vietCarDamage[1], 0, 0);
            } else if (myHP < 0.75) {
              image(carDamage[0], 0, 0);
              image(vietCarDamage[0], 0, 0);
            }
          } else if (l instanceof LevelAfghan) {
            if (myHP < 0.25) {
              image(carDamage[2], 0, 0);
              image(afghanCarDamage[2], 0, 0);
            } else if (myHP < 0.5) {
              image(carDamage[1], 0, 0);
              image(afghanCarDamage[1], 0, 0);
            } else if (myHP < 0.75) {
              image(carDamage[0], 0, 0);
              image(afghanCarDamage[0], 0, 0);
            }
          } else {
            if (myHP < 0.25) {
              image(carDamage[2], 0, 0);
              image(carDamage[5], 0, 0);
            } else if (myHP < 0.5) {
              image(carDamage[1], 0, 0);
              image(carDamage[4], 0, 0);
            } else if (myHP < 0.75) {
              image(carDamage[0], 0, 0);
              image(carDamage[3], 0, 0);
            }
          }
        }
        popMatrix();
      }
    }
  }

  //continuously centered health bar that goes down and changes color depending on the amount of health left
  void healthBar() {
    if (myHP > 0) {
      if (myHP != maxHP) {
        if (myHP > (maxHP*0.75)) {
          fill(0, 255, 0);
        } else if (myHP > (maxHP * 0.25)) {
          fill(255, 255, 0);
        } else {
          fill(255, 0, 0);
        }
        rectMode(CENTER);
        rect(myLocation.x, myLocation.y - 50, (200)*(myHP/maxHP), 10);
        rectMode(CENTER);
      }
    }
  }

  //checks if the vehicle is exploding by check if the HP is less than or equal to zero, clears the gun and spawns the explosion image at the trucks location, emus in location have their HP reduced, after explosion timer is up gameOver becomes true 
  void explode() {
    if (!exploding) {
      if (!exploded) {
        if (myHP <= 0) {
          exploded = true;
          explosions.add(new Explosion(myLocation.x, myLocation.y, 300));
          explosionTimer.setSeconds(8);
          exploding = true;
          guns.clear();
          for (Emu e : emus) {
            if (e.getX() > myLocation.x - 300 && e.getX() < myLocation.x + 300 && e.getY() > myLocation.y - 300 && e.getY() < myLocation.y + 300) {
              e.reduceHP(500);
            }
          }
        }
      }
    } else {
      explosionTimer.update();
      if (explosionTimer.isDone()) {
        exploding = false;
        for (Level l : levels) {
          if (l instanceof LevelFour) {
            if (l.getBossDead()) {
              l.setEndTimerState(true);
            } else {
              gameOver = true;
            }
          } else {
            gameOver = true;
          }
        }
      }
    }
  }

  //if your speed is greater than 2 and you hit an emu it kills them and reduces the driver's HP, if the emu is not the boss emu. If it is the boss emu, hitting it stops and damages the car.
  void hitEmu() {
    for (Emu e : emus) {
      if (e instanceof BossEmu) {
        if (e.getX() > myLocation.x - 100 && e.getX() < myLocation.x + 100 && e.getY() > myLocation.y - 100 && e.getY() < myLocation.y + 100) {
          reduceHP(0.005);
        }
      } else {
        if (e.getX() > myLocation.x - 100 && e.getX() < myLocation.x + 100 && e.getY() > myLocation.y - 100 && e.getY() < myLocation.y + 100) {
          if (mySpeed > 2) {
            e.reduceHP(50);
            reduceHP(0.005);
          }
        }
      }
    }
  }

  float getHP() {
    return myHP;
  }


  void update() {

    if (myLocation.x<0) myLocation.x=0;  
    if (myLocation.x>width) myLocation.x=width;  
    if (myLocation.y<0) myLocation.y=0;  
    if (myLocation.y>height) myLocation.y=height;

    frontWheel = new PVector(myLocation.x+(myWheelBase/2)*sin(myHeading), myLocation.y+(myWheelBase/2)*cos(myHeading));
    backWheel = new PVector(myLocation.x-(myWheelBase/2)*sin(myHeading), myLocation.y-(myWheelBase/2)*cos(myHeading));
    // front axle
    pushMatrix();
    translate(frontWheel.x, frontWheel.y);
    rotate(-myHeading);
    strokeWeight(2);
    line (-myWheelBase/7, 0, myWheelBase/7, 0);
    strokeWeight(1);
    popMatrix();
    // end: front axle


    // front left wheel
    pushMatrix();
    translate(frontWheel.x+sin(myHeading+PI/2)*myWheelBase/2, frontWheel.y+cos(myHeading+PI/2)*myWheelBase/2);
    // sin(myHeading+PI/2) and cos(myHeading+PI/2) helps to place wheel to correct position shifted to side by (myWheelBase/7)
    // otherwise it would circle around the front regarding to a heading

    rotate(-mySteerAngle-myHeading);
    rectMode(CENTER);
    fill(0);
    rect(0, 0, myWheelBase/7, myWheelBase/3, myWheelBase/(myWheelBase/10));
    popMatrix();
    // end: front left wheel


    // front right wheel
    pushMatrix();
    translate(frontWheel.x-sin(myHeading+PI/2)*myWheelBase/2, frontWheel.y-cos(myHeading+PI/2)*myWheelBase/2);
    rotate(-mySteerAngle-myHeading);
    rectMode(CENTER);
    fill(0);
    rect(0, 0, myWheelBase/7, myWheelBase/3, myWheelBase/(myWheelBase/10));
    popMatrix();
    // end: front right wheel


    // back wheels
    pushMatrix();

    translate(backWheel.x, backWheel.y);
    rotate(-myHeading);

    rectMode(CENTER);
    fill(0);

    strokeWeight(2);
    line(-myWheelBase/7, 0, myWheelBase/7, 0);
    strokeWeight(1);


    rect(-myWheelBase/3, 0, myWheelBase/2, myWheelBase/3, myWheelBase/(myWheelBase/10));
    rect(myWheelBase/3, 0, myWheelBase/2, myWheelBase/3, myWheelBase/(myWheelBase/10));

    popMatrix();

    frontWheel.add(mySpeed*sin(myHeading+mySteerAngle), mySpeed*cos(myHeading+mySteerAngle), 0);
    backWheel.add(mySpeed*sin(myHeading), mySpeed*cos(myHeading), 0);
    myLocation.set(frontWheel.x+backWheel.x, frontWheel.y+backWheel.y, 0) ;
    myLocation.div(2);
    // end: back wheels
    pushMatrix();
    translate(myLocation.x, myLocation.y);
    rotate(-myHeading);
    rectMode(CENTER);
    fill(150);
    rect(0, 0, myWheelBase, myWheelBase+myWheelBase/1.5 + 30, 3, 3, myWheelBase/(myWheelBase/20), myWheelBase/(myWheelBase/20));
    popMatrix();

    myHeading = atan2(frontWheel.x - backWheel.x, frontWheel.y - backWheel.y );

    //locks the tires in place when you steer too far to the left and right
    if (left) {
      if (mySteerAngle < myMaxSteerAngle) mySteerAngle += 0.08;
      if (mySteerAngle>myMaxSteerAngle) mySteerAngle = myMaxSteerAngle;
    } else {
      if (!steerLock) {
        if (mySteerAngle > 0) mySteerAngle -= 0.08;
      }
    }


    // Right
    if (right) {
      if (mySteerAngle >  -myMaxSteerAngle)  mySteerAngle -= 0.08;
      if (mySteerAngle<-myMaxSteerAngle) mySteerAngle = -myMaxSteerAngle;
    } else {
      if (!steerLock) {
        if (mySteerAngle < 0) mySteerAngle += 0.08;
      }
    }

    /* check with Dakota */
    // UP
    if (up)
    { 
      if (mySpeed<myMaxSpeed) mySpeed += 0.08;
    } else {
    }  

    // DOWN
    if (down) {
      if (mySpeed>0) mySpeed -= 0.15; //brake
      else 
      if (abs(mySpeed)<myMaxSpeed) mySpeed -= 0.05; // reverse
    } else {
    }


    if (abs(mySteerAngle)<0.08) mySteerAngle = 0;


    if (mySpeed>0) mySpeed -= 0.01; //friction for forward
    if (mySpeed<0) mySpeed += 0.01; //friction for backward

    if ((!up && !down) && (abs(mySpeed)<0.01))  mySpeed=0;

    //calling of major functions into the update function
    carDamage();
    setMaxSpeed();
    healthBar();
    hitEmu();
    explode();
  }
}