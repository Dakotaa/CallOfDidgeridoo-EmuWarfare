// thrown gas projectile
class Gas_Thrown extends Projectile {
  boolean moving = true;
  int fuse = 0;
  // uses the timer class so the gas begins 5 seconds after the projectile is created
  Timer myTimer = new Timer(5);
  Gas_Thrown(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
  }

  void update() {
    myTimer.update();
    
    // if the gas reaches the position that the cursor was over when thrown, stops moving
    if (myPosition.x > myXEnd - 30 && myPosition.x < myXEnd + 30 && myPosition.y > myYEnd - 30 && myPosition.y < myYEnd + 30) {
      moving = false;
    }

    if (moving) { 
      myPosition.x += myVelocity.x;
      myPosition.y += myVelocity.y;
    }

    // when 5 seconds has passed, adds a new gas and removes the grenade
    if (myTimer.isDone()) {
      gasses.add(new Gas(myPosition.x, myPosition.y, 250));  
      toRemove = true;
    }

    if (visible) {
      pushMatrix();
      translate(myPosition.x, myPosition.y);
      if (moving) {
        rotate(frameCount/5);
      }
      image(grenade, 0, 0);
      popMatrix();
    }
  }
}
