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
    super.update();
  }
}
