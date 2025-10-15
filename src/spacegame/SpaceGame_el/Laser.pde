
class Laser {

  //Member Variables
  int x, y, w, h, speed;
  PImage hydro;

  //Constructor
  Laser (int x, int y) {
    this.x = x;
    this.y = y;
    w = 4;
    h = 10;
    speed = 10;
    hydro = loadImage("laser.png");
  }

  //Member Methods
  void display() {
    imageMode(CENTER);
    image(hydro, x, y, w, h);
  }

  void move() {
    y = y - speed;
  }

  boolean reachedTop () {
    if (y<0-10) {
      return true;
    } else {
      return false;
    }
  }


  boolean intersect(Rock c) {
    float d = dist( x, y, c.x, c.y);
    if (d<40) {
      return true;
    } else {
      return false;
    }
  }
}
