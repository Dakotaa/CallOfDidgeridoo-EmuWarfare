class Gas_Thrown extends Projectile {
  boolean moving = true;
  int fuse = 0;
  Timer myTimer = new Timer(5);
  Gas_Thrown(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
  }

  void update() {
    myTimer.update();
    if (myPosition.x > myXEnd - 30 && myPosition.x < myXEnd + 30 && myPosition.y > myYEnd - 30 && myPosition.y < myYEnd + 30) {
      moving = false;
    }

    if (moving) { 
      myPosition.x += myVelocity.x;
      myPosition.y += myVelocity.y;
    }

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