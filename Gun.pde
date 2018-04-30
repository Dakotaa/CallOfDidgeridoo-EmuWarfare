class Gun {
  float myX, myY, myTheta, myMaxAmmo, myAmmo, myDamage;
  int myID;
  int myRateOfFire, numShots;
  boolean reloading;
  PImage gunImage;
  Gun () {
    myX = truck.gunX();
    myY = truck.gunY();
    myTheta = 0;
    myID = 0;
    myDamage = 0;
    numShots = 0;
    //gunImage = lewisGun;
  }

  int getRateOfFire() {
    return myRateOfFire;
  }
  int getID() {
    return myID;
  }

  float getDamage() {
    return myDamage;
  }
  
  int getNumShots() {
    return numShots;  
  }
  
  float getTheta() {
    return myTheta;
  }

  void shoot() {
    myAmmo--;
    track = true;
  }
  float getAmmo() {
    return myAmmo;
  }

  float getMaxAmmo() {
    return myMaxAmmo;
  }

  void setAmmo(float ammo) {
    myAmmo = ammo;
  }

  void reload() {
    if (!reloading) {
      myAmmo = 0;
      reloading = true;
    }
    if (reloading) {
      if (myAmmo < myMaxAmmo) {
        if (frameCount%3 == 0) {
          myAmmo++;
        }

        // Draws the green rectangle to show visual reloading progress.
        pushMatrix();
        fill(0, 255, 0);
        rectMode(CORNER);
        rect(myX - 50, myY+ 20, 100*(myAmmo/myMaxAmmo), 10);
        rectMode(CENTER);
        fill(0);
        textAlign(CENTER);
        textSize(5);
        text("RELOADING", myX, myY+30);
        popMatrix();
      } else {
        reloading = false;
      }
    }
  }

  boolean getReloading() {
    return reloading;
  }

  void drawGun() {
    myX = truck.gunX();
    myY = truck.gunY();

    if (reloading) {
      reload();
    }

    if (mouseX > truck.getX()) {
      myTheta = atan((truck.getY() - mouseY)/(truck.getX() - mouseX));
    } else {
      myTheta = (atan((mouseY-truck.getY())/(mouseX - truck.getX()))) + radians(180);
    }

    pushMatrix();
    imageMode(CENTER);
    translate(truck.getX(), truck.getY());
    rotate(myTheta);
    image(gunImage, 0, 0);
    popMatrix();
  }
}
