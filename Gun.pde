class Gun {
  float myX, myY, myTheta, myMaxAmmo, myAmmo, myDamage;
  int myID;
  int myRateOfFire, numShots;
  boolean reloading, flashing;
  PImage gunImage;
  Gun () {
    myX = truck.gunX();
    myY = truck.gunY();
    myTheta = 0;
    myID = 0;
    myDamage = 0;
    numShots = 0;
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

  // plays gunshot sound and reduces gun ammo on shooting, also causes emus to begin grouping and shows gun flash
  void shoot() {
    gunshot.rewind();
    gunshot.play();
    myAmmo--;
    if (!group) {
      group = true;
    }
    flashing = true;
    //track = true;
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

  // reload function to increase ammo. Sets ammo to 0 and reloads bullets individually every 2 frames
  void reload() {
    if (!reloading) {
      myAmmo = 0;
      reloading = true;
    }
    if (reloading) {
      if (myAmmo < myMaxAmmo) {
        if (frameCount%2 == 0) {
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

    // ke
    myX = truck.gunX();
    myY = truck.gunY();
    
    // calls the reload function when the button is pressed (causing reloading to be true) or automatically when ammo runs out
    if (reloading || myAmmo == 0) {
      reload();
    }

    // sets angle to rotate gun based on the x position of the truck (CAST)
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

    if (flashing) {
      image(flash, gunImage.width/2 + gunImage.width*.15, 0);

      if (frameCount%4==0) {
        flashing = false;
      }
    }

    popMatrix();
  }
}
