class Level {
  float mobLocationX, mobLocationY;
  String[] textScene = new String[3];
  int scene = 0;
  int character = 0;
  Level() {
    mobLocationX = random(width-700, width);
    mobLocationY = random(0, height);
    constrain(mobLocationX, 0, width);
    constrain(mobLocationY, 0, height);
  }
  void setupLevel() {
  }

  void clearLevel() {
    emus.clear();
    bloods.clear();
    bullets.clear();
    guns.clear();
    projectiles.clear();
    gasses.clear();
    track = false;
    character = 0;
    scene = 0;
  }

  float getMobLocationX() {
    return mobLocationX;
  }

  float getMobLocationY() {
    return mobLocationY;
  }

  void update() {
    if (scene <= textScene.length) {
      pushMatrix();
      background(255);
      fill(0);
      String text = textScene[scene].substring(0, character);
      textFont(typeWriterFont);
      text(text + "|", width/2, height/2);
      popMatrix();
      
      if (frameCount%6 == 0) {
        if (character < textScene[scene].length()) {
          character++;
        }
      }
    } else {
      if (frameCount%20 == 0) {
        mobLocationX += random(-10, 10);
        mobLocationY += random(-10, 10);
      }
      boomerangTimer.update();
      fill(0, 255, 0);
      noStroke();
      rect(0, 0, 100, 40);
      fill(0);
      text("FPS: " + (int) frameRate, 2, 15);
      background(214, 154, 0);
      fill(0);
      text(mobLocationX, 500, 500);
      text(mobLocationY, 500, 600);
      truck.update();
      for (Gun g : guns) {
        g.drawGun();
      }

      ArrayList<Blood> bloodToRemove = new ArrayList();
      for (Blood b : bloods) {
        b.update();  
        if (b.toRemove()) {
          bloodToRemove.add(b);
        }
      }

      ArrayList<Projectile> projectilesToRemove = new ArrayList();
      for (Projectile p : projectiles) {
        p.update();
        if (p.getToRemove()) {
          projectilesToRemove.add(p);
        }

        if (p.getX() > width + 100 || p.getX() < - 00 || p.getY() > height + 100 || p.getY() < -100) {
          projectilesToRemove.add(p);
        }
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
              for (int i = 0; i < g.getNumShots(); i++) {
                bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, g.getTheta(), mouseX, mouseY, true, g.getDamage()));
              }
              g.shoot();
            } else {
              for (int i = 0; i < g.getNumShots(); i++) {
                bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, g.getTheta(), 10000, 10000, false, g.getDamage()));
              }
              g.shoot();
            }
          }
          //gunShot.play(); //https://processing.org/reference/libraries/sound/SoundFile.html
        }
      }

      ArrayList<Explosion> explosionsToRemove = new ArrayList();
      for (Explosion e : explosions) {
        e.update(); 
        if (e.isComplete()) {
          explosionsToRemove.add(e);
        }
      }

      ArrayList<Gas> gasToRemove = new ArrayList();
      for (Gas g : gasses) {
        g.update();
        if (g.isComplete()) {
          gasToRemove.add(g);
        }
      }

      if (aiming) {
        strokeWeight(3);
        stroke(200, 50);
        line(truck.gunX(), truck.gunY(), mouseX, mouseY);
        strokeWeight(1);
        noStroke();
      }
      projectiles.removeAll(projectilesToRemove);
      bullets.removeAll(toRemove); // Removes offscreen bullets (https://stackoverflow.com/questions/18448671/how-to-avoid-concurrentmodificationexception-while-removing-elements-from-arr)
      emus.removeAll(emuRemove);
      explosions.removeAll(explosionsToRemove);
      bloods.removeAll(bloodToRemove);
      gasses.removeAll(gasToRemove);
      textAlign(CORNER);
      fill(0);
      //textSize(20);
      //text((int) gun1.getAmmo() + " | " + (int) gun1.getMaxAmmo(), 200, 30);
      hud.update();
    }
  }
}
