// https://www.openprocessing.org/sketch/141841
class Truck {
  PVector myLocation;
  PVector frontWheel;
  PVector backWheel;
  float myHeading, mySpeed, myBaseMaxSpeed, myMaxSpeed, mySteerAngle, myMaxSteerAngle, myWheelBase, myMinWheelBase, myMaxWheelBase, myHP, maxHP, carSize;
  boolean plus, minus, up, down, left, right, steerLock, exploding, timerStarted; 
  //PImage damagePhotos[] = new PImage[3];

  Timer explosionTimer = new Timer(8);

  Truck(float maxSpeed) {
    up = down = left = right = steerLock = false;
    myLocation = new PVector(860, 540);
    myHeading = PI;
    mySpeed = 0;
    myBaseMaxSpeed = maxSpeed;
    myMaxSpeed = myBaseMaxSpeed;
    mySteerAngle = 0;
    myWheelBase = 200;
    myMaxSteerAngle = PI/4;
    maxHP = 1;
    myHP = maxHP;
    carSize = 10;
  /*
    for(int i = 1; i < damagePhotos.length; i++) {
     damagePhotos[i] = carDamage[i].copy(); 
     damagePhotos[i].resize((int) (carSize*400), (int) (carSize*406));
  }
  */
}

  float getSpeed() {
    return mySpeed;
  }

  void setX (float x) {
    myLocation.x = x;
  }

  void setY (float y) {
    myLocation.y = y;
  }
  float getX() {
    return myLocation.x;
  }

  float getY() {
    return myLocation.y;
  }
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
    myMaxSpeed = 5;
  }

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

  void myDamage() {
    if (myHP > 0) {
      if (myHP != maxHP) {
        if (myHP > (maxHP*0.75)) {
        
        }
      }
    }
  }

  void explode() {
    if (!exploding) {
      if (myHP <= 0) {
        explosions.add(new Explosion(myLocation.x, myLocation.y, 300));
        exploding = true;
        guns.clear();
        for (Emu e : emus) {
          if (e.getX() > myLocation.x - 300 && e.getX() < myLocation.x + 300 && e.getY() > myLocation.y - 300 && e.getY() < myLocation.y + 300) {
            e.reduceHP(500);
          }
        }

        //truckExplosion.setX(myLocation.x);
        // truckExplosion.setY(myLocation.y);
      }
    } else {
      text("exploding = true", 500, 500);
      // TODO : Convert this into explosion object
      explosionTimer.update();
      //truckExplosion.update();
      if (explosionTimer.isDone()) {
        exploding = false;
        explosionTimer.setSeconds(8);
        gameOver = true;
      }
    }
  }

  void hitEmu() {
    for (Emu e : emus) {
      if (e.getX() > myLocation.x - 100 && e.getX() < myLocation.x + 100 && e.getY() > myLocation.y - 100 && e.getY() < myLocation.y + 100) {
        if (mySpeed > 2) {
          e.reduceHP(50);
          reduceHP(0.005);
        }
      }
    }
  }

  float getHP() {
    return myHP;
  }


  void update() {
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
    // otherwise it would circle adound front regarding to a heading
    // I don't know to work well with these Processing matrix translate/rotate things

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
    fill(200);
    rect(0, 100, myWheelBase*.9, myWheelBase/2, 3, 3, myWheelBase/(myWheelBase/15), myWheelBase/(myWheelBase/15));
    popMatrix();


    // Moves car to other side of screen when leaving screen
    if (myLocation.x<0) myLocation.x=0;  
    if (myLocation.x>width) myLocation.x=width;  
    if (myLocation.y<0) myLocation.y=0;  
    if (myLocation.y>height) myLocation.y=height;

    myHeading = atan2(frontWheel.x - backWheel.x, frontWheel.y - backWheel.y );


    if (left) {
      if (mySteerAngle < myMaxSteerAngle) mySteerAngle += 0.08;
      if (mySteerAngle>myMaxSteerAngle) mySteerAngle = myMaxSteerAngle;
    } else {
      if (!steerLock) {
        if (mySteerAngle > 0) mySteerAngle -= 0.08;
      }
    }


    // RIGHT
    if (right) {
      if (mySteerAngle >  -myMaxSteerAngle)  mySteerAngle -= 0.08;
      if (mySteerAngle<-myMaxSteerAngle) mySteerAngle = -myMaxSteerAngle;
    } else {
      if (!steerLock) {
        if (mySteerAngle < 0) mySteerAngle += 0.08;
      }
    }

    // UP
    if (up)
    { 
      if (mySpeed<myMaxSpeed) mySpeed += 0.05;
    } else
    {
    }  

    // DOWN
    if (down)
    {
      if (mySpeed>0) mySpeed -= 0.15; //brake
      else 
      if (abs(mySpeed)<myMaxSpeed) mySpeed -= 0.05; // reverse
    } else
    {
    }


    if (abs(mySteerAngle)<0.08) mySteerAngle = 0;


    if (mySpeed>0) mySpeed -= 0.01; //friction for forward
    if (mySpeed<0) mySpeed += 0.01; //friction for backward

    if ((!up && !down) && (abs(mySpeed)<0.01))  mySpeed=0;

    setMaxSpeed();
    healthBar();
    hitEmu();
    explode();
  }
}