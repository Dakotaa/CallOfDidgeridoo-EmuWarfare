//

//import processing.sound.*;
//SoundFile gunShot;
void setup() {
  fullScreen();
  cursor(CROSS);
  thread("loadImages");
  //gunShot = new SoundFile(this, "gunshot.wav");
}

Button buttonOne = new Button(200, 250, 100, 75, "Test Level", color(100, 200, 250));

Truck truck = new Truck (5);
//Gun gun1 = new Gun();
Gun gun1 = new Gun_Lewisgun();
PImage lewisGun, miniGun, emuPhoto, blood;
boolean isDone, autoFire, aiming = false;
float gunInnac;
int level = 0;
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Emu> emus = new ArrayList();
ArrayList<Blood> bloods = new ArrayList();
ArrayList<Level> levels = new ArrayList();

void loadImages() { // https://forum.processing.org/two/discussion/1360/how-to-speedup-loadimage
  lewisGun = loadImage("lewisgun.png");
  miniGun = loadImage("minigun.png");
  emuPhoto = loadImage("emu.png");
  blood = loadImage("blood.png");
  lewisGun.resize((int) (lewisGun.width*0.5), (int) (lewisGun.height*0.5));
  blood.resize(200, 200);
  isDone = true;
}

void draw() {
  if (!isDone) {
    background(0);
    pushMatrix();
    textAlign(CENTER);
    textSize(50);
    text("LOADING...", width/2, height/2);
    popMatrix();
  } else {
    if (level == 0) {
      titleScreen();
    }

    if (level == 1) {
      for (Level l : levels) {
        l.update();
        text(truck.getSpeed(), 100, 100);
      }
    }
  }
}
void keyPressed() {
  if (level != 0) {
    switch(keyCode) {
    case 65: 
      truck.setLeft(true);
      break;
    case 68:
      truck.setRight(true);
      break;
    case 87:
      truck.setUp(true);
      break;
    case 83:
      truck.setDown(true);
      break;
    }
  }
}


void keyReleased() {
  if (level != 0) {
    switch(keyCode) {
    case 65: 
      truck.setLeft(false);
      break;
    case 68:
      truck.setRight(false);
      break;
    case 87:
      truck.setUp(false);
      break;
    case 81:
      emus.add(new Emu(mouseX, mouseY, (int) random(40, 100), random(0.1, 0.3)));
      break;
    case 82:
      gun1.reload();
      break;
    case 83:
      truck.setDown(false);
      break;
    case 192:
      level = 0;
      for (Level l : levels) {
        l.clearLevel();
      }
      levels.clear();
      break;
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (buttonOne.getDown()) {
      buttonOne.setDown(false);
      level = 1;
      levels.add(new LevelOne());
      for (Level l : levels) {
        l.setupLevel();
      }
    }
  }
  if (level != 0) {
    if (mouseButton == LEFT) {
      if (gun1.getAmmo() > 0 && !gun1.getReloading()) {
        if (aiming) {
          bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, gun1.getTheta(), mouseX, mouseY, true));
          gun1.shoot();
        }
      }
      //gunShot.play();
    }
    if (mouseButton == RIGHT) {
      aiming = true;
    }
  }
}

void mouseReleased() {
  if (level != 0) {
    if (mouseButton == RIGHT) aiming = false;
  }
}


void titleScreen() {
  pushMatrix();
  background(0);
  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("CALL OF DIDGERIDOO: Emu Warfare", width/2, 100);
  popMatrix();

  buttonOne.update();
}









/*
void setupLevelOne() {
 for (int i = 0; i < 10; ++i) {
 emus.add(new Emu(random(width*.75, width), random(300, height-300), (int) random(40, 100), random(0.1, 0.3)));
 }
 }
 void levelOne() {
 background(255);
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
 fill(0, 255, 0);
 noStroke();
 rect(0, 0, 100, 40);
 fill(0);
 text("FPS: " + (int) frameRate, 2, 15);
 text((int) gun1.getAmmo() + " | " + (int) gun1.getMaxAmmo(), 200, 12);
 }
 */
