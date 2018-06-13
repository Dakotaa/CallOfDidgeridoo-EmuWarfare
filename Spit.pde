class Spit extends Projectile {
  Spit(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
    myPosition = position;
    myVelocity = new PVector(20, 20);
    
    for (Emu e : emus) {
      if (myXEnd > e.getX()) {
        myTheta = atan((e.getY() - myYEnd)/(e.getX() - myXEnd));
      } else {
        myTheta = (atan((myYEnd-e.getY())/(myXEnd - e.getX()))) + radians(180);
      }
    }
    
    this.velocity = velocity;
    myXEnd = xEnd;
    myYEnd = yEnd;
    if (xEnd >= myPosition.x) {
      myVelocity.y = ((float) ((velocity) * (Math.sin(Math.abs((myTheta))))));
      myVelocity.x = ((float) Math.sqrt((((velocity)*(velocity))-((myVelocity.y)*(myVelocity.y)))));
      if (yEnd < myPosition.y) {
        myVelocity.y*=-1;
      }
    } else {
      myVelocity.y = ((float) ((velocity) * (Math.sin(Math.abs((myTheta))))));
      myVelocity.x = ((float) Math.sqrt((((velocity)*(velocity))-((myVelocity.y)*(myVelocity.y)))))*-1;
    }
  }

  // truck.get = emu position
  // myX = end location

  float geTheta() {
    for (Emu e : emus) {
      if (myXEnd > e.getX()) {
        myTheta = atan((e.getY() - myYEnd)/(e.getX() - myXEnd));
      } else {
        myTheta = (atan((myYEnd-e.getY())/(myXEnd - e.getX()))) + radians(180);
      }
    }

    return myTheta;
  }

  void update() {
    super.update();
    rect(myPosition.x, myPosition.y, 30, 30);
    
    if (myPosition.x > truck.getX() - 200 && myPosition.y < truck.getX() + 200 && myPosition.y > truck.getY() - 200 && myPosition.x < truck.getY() + 200) {
      truck.reduceHP(0.1);
      toRemove = true;
    }
  }
}