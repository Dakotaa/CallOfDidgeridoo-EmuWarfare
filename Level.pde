class Level {
  Level() {
  }
  void setupLevel() {
  }

  void clearLevel() {
    emus.clear();
    bloods.clear();
    bullets.clear();
    guns.clear();
  }

  void update() {
    fill(0, 255, 0);
    noStroke();
    rect(0, 0, 100, 40);
    fill(0);
    text("FPS: " + (int) frameRate, 2, 15);
    background(214, 154, 0);

    truck.update();
    for (Gun g : guns) {
      g.drawGun();
    }

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
    
    for (Gun g : guns) {
      if (frameCount%g.getRateOfFire()==0 && mousePressed && mouseButton == LEFT) { // https://forum.processing.org/one/topic/shoot-multiple-bullets.html
        if (truck.getSpeed() > 0 || truck.getSpeed() < 0) {
          gunInnac = 2;
        } else {
          gunInnac = 0;
        }
        if (g.getAmmo() > 0 && !g.getReloading()) {
          if (aiming) {
            bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, g.getTheta(), mouseX, mouseY, true));
            g.shoot();
          } else {
            bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, g.getTheta(), 10000, 10000, false));
            g.shoot();
          }
        }
        //gunShot.play(); //https://processing.org/reference/libraries/sound/SoundFile.html
      }
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
    //text((int) gun1.getAmmo() + " | " + (int) gun1.getMaxAmmo(), 200, 30);
  }
}
