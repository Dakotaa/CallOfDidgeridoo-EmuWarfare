class Projectile {
  PVector myPosition, myVelocity, mySpeed;
  float myTheta, velocity, myXEnd, myYEnd;
  boolean visible = true;
  boolean toRemove;
  Projectile (PVector position, float velocity, float theta, float xEnd, float yEnd) {
    myPosition = position;
    myVelocity = new PVector(15, 15);
    myTheta = theta;
    this.velocity = velocity;
    myXEnd = xEnd;
    myYEnd = yEnd;
    
    // math for angle of projectile
    if (mouseX >= truck.gunX()) {
      myVelocity.y = ((float) ((velocity) * (Math.sin(Math.abs((myTheta))))));
      myVelocity.x = ((float) Math.sqrt((((velocity)*(velocity))-((myVelocity.y)*(myVelocity.y)))));
      if (mouseY < truck.getY()) {
        myVelocity.y*=-1;
      }
    } else {
      myVelocity.y = ((float) ((velocity) * (Math.sin(Math.abs((myTheta))))));
      myVelocity.x = ((float) Math.sqrt((((velocity)*(velocity))-((myVelocity.y)*(myVelocity.y)))))*-1;
    }
  }

  void setToRemove(boolean tr) {
    toRemove = tr;
  }

  boolean getToRemove() {
    return toRemove;
  }
  float getX() {
    return myPosition.x;
  }

  float getY() {
    return myPosition.y;
  }

  void update() {
    myPosition.x += myVelocity.x;
    myPosition.y += myVelocity.y;
  }
}
