final class Gun_Lewisgun extends Gun {
  Gun_Lewisgun(int maxAmmo) {
    super();
    myMaxAmmo = maxAmmo;
    myAmmo = myMaxAmmo;
    myRateOfFire = 6;
    //gunImage = miniGun;
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
        textSize(10);
        textAlign(CENTER);
        text("RELOADING", myX, myY+30);
        popMatrix();
      } else {
        reloading = false;
      }
    }
  }
}
