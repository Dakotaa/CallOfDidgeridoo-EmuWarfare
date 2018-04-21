class Boomerang_Thrown extends Projectile {
  boolean returning;
  Boomerang_Thrown(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
  }

  void setReturning(boolean r) {
    returning = r;
  }

  void update() {
    for (Emu e : emus) {
      if (myPosition.x > e.getX() - e.getWidth()/2 && myPosition.x < e.getX() + e.getWidth()/2 && myPosition.y > e.getY() - e.getHeight()/2 && myPosition.y < e.getY() + e.getHeight()/2) {
        returning = true;
        e.reduceHP(15);
      }
    }

    if (myPosition.x > myXEnd - 20 && myPosition.x < myXEnd + 20 && myPosition.y > myYEnd - 20 && myPosition.y < myYEnd - 20) {
      returning = true;
    }

    if (returning) {
      myPosition.x += -myVelocity.x;
      myPosition.y += -myVelocity.y;
      if (myPosition.x > truck.gunX() - 10 && myPosition.x < truck.gunX() + 10 && myPosition.y > truck.gunY() - 10 && myPosition.y < truck.gunY() + 10) {
        visible = false;  
      }
    } else {
      myPosition.x += myVelocity.x;
      myPosition.y += myVelocity.y;
    }
    if (visible) {
      pushMatrix();
      translate(myPosition.x, myPosition.y);
      rotate(frameCount/3);
      image(boomerang, 0, 0);
      popMatrix();
    }
  }
}
