class LandMine extends Projectile {
  LandMine(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
  }

  void update() {
    for (Emu e : emus) {
      if (myPosition.x > e.getX() - e.getWidth()/2 && myPosition.x < e.getX() + e.getWidth()/2 && myPosition.y > e.getY() - e.getHeight()/2 && myPosition.y < e.getY() + e.getHeight()/2) {
        explosions.add(new Explosion(myPosition.x, myPosition.y, 100));       
        toRemove = true;
      }
    }

    if (visible) {
      pushMatrix();
      translate(myPosition.x, myPosition.y);
      image(landmine, 0, 0);
      popMatrix();
    }
  }
}
