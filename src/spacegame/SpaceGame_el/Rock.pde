class Rock {
  //Member Variables
  int x, y, diam, speed, c;
  PImage r1, r2;
  boolean broken;

  //Constructor
  Rock() {
    x = int(random(width));
    y = -100;
    diam = int(random(50, 150));
    speed = int(random(1, 6));
    if (random(10)>6.6) {
      r1 = loadImage ("coral3.png");
      r2 = loadImage("coral3break.png");
      broken = false;
    } else if (random(10)>5.0) {
      r1 = loadImage ("coral2.png");
      r2 = loadImage ("coral2break.png");
      broken = false;
    } else {
      r1 = loadImage ("coral1.png");
      r2 = loadImage ("coral1.png");
      broken = false;
    }
  }

  //Member Methods
  void display() {

    if (broken == false) {
      imageMode(CENTER);
      r1.resize(diam, diam);
      image(r1, x, y);
    } else {
      imageMode(CENTER);
      r2.resize(diam, diam);
      image(r2, x, y);
    }
  }

  void move() {
    y = y + speed;
  }

  boolean reachedBottom () {
    if (y>height + 100) {
      return true;
    } else {
      return false;
    }
  }
}
