class Spit extends Projectile {
  float offset;
  Spit(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
    myPosition = position;
    myVelocity = new PVector(20, 20);
    offset = theta;

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

    return myTheta += offset*3;
  }

  void update() {
    super.update();
    pushMatrix();
    translate(myPosition.x, myPosition.y);
    rotate(myTheta);
    image(spitImage, 0, 0);
    popMatrix();

    if (myPosition.x > truck.getX() - 100 && myPosition.x < truck.getX() + 100 && myPosition.y > truck.getY() - 100 && myPosition.y < truck.getY() + 100) {
      truck.reduceHP(0.1);
      toRemove = true;
    }
  }
}