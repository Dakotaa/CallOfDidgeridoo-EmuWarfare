class LevelOne extends Level {
  LevelOne() {
  }

  void setupLevel() {
    for (int i = 0; i < 10; ++i) {
      emus.add(new Emu(random(width*.75, width), random(300, height-300), (int) random(40, 100), random(0.1, 0.3)));
    }
    gun1.setAmmo(gun1.getMaxAmmo());
    truck.setX(200);
    truck.setY(200);
    truck.setHeading(PI);
    truck.setSpeed(0);
    truck.setHP(1);
    truck.resetMaxSpeed();
  }


  void update() {
    fill(0, 255, 0);
    noStroke();
    rect(0, 0, 100, 40);
    fill(0);
    text("FPS: " + (int) frameRate, 2, 15);
    background(214, 154, 0);
    
    truck.update();
    gun1.drawGun();
    
    ArrayList<Bullet> toRemove = new ArrayList();
    for (Bullet b : bullets) {
      b.drawBullet();
      if (b.getY() > height || b.getY() < 0 || b.getX() > width || b.getX() < 0) {
        toRemove.add(b);
      }
    }
    
    ArrayList<Emu> emuRemove = new ArrayList();
    for (Emu e : emus) {
      e.update();
      if (e.isDead()) {
        emuRemove.add(e);
      }
    }

    if (frameCount%gun1.getRateOfFire()==0 && mousePressed && mouseButton == LEFT) { // https://forum.processing.org/one/topic/shoot-multiple-bullets.html
      if (truck.getSpeed() > 0 || truck.getSpeed() < 0) {
        gunInnac = 2;
      } else {
        gunInnac = 0;
      }
      if (gun1.getAmmo() > 0 && !gun1.getReloading()) {
        if (aiming) {
          bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, gun1.getTheta(), mouseX, mouseY, true));
          gun1.shoot();
        } else {
          bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, gun1.getTheta(), 10000, 10000, false));
          gun1.shoot();
        }
      }
      //gunShot.play(); //https://processing.org/reference/libraries/sound/SoundFile.html
    }

    if (aiming) {
      strokeWeight(3);
      stroke(200, 50);
      line(truck.gunX(), truck.gunY(), mouseX, mouseY);
      noStroke();
    }

    bullets.removeAll(toRemove); // Removes offscreen bullets (https://stackoverflow.com/questions/18448671/how-to-avoid-concurrentmodificationexception-while-removing-elements-from-arr)
    emus.removeAll(emuRemove);
    textAlign(CORNER);
    fill(0);
    textSize(20);
    text((int) gun1.getAmmo() + " | " + (int) gun1.getMaxAmmo(), 200, 30);
  }
}
