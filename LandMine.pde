class LandMine extends Projectile {
  LandMine(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
  }

  void update() {
    for (Emu e : emus) {
      if (e.getX() > myPosition.x - landmine.width/2 && e.getX() < myPosition.x + landmine.width/2 && e.getY() > myPosition.y - landmine.height/2 && e.getY() < myPosition.y + landmine.height/2) {
        explosions.add(new Explosion(myPosition.x, myPosition.y, 200));       
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