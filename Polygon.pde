class Polygon {

  protected int n;
  protected int rotation;
  protected float cx;
  protected float cy;
  protected float w;
  protected float h;
  protected float time, speed;
  protected float startAngle;

  public Polygon(int _sides, float _x, float _y, int _rotation, float _speed) {
    n = _sides;
    startAngle = -PI / 2;
    w = 50;
    h = 50;
    cx = _x;
    cy = _y;
    rotation = _rotation;
    speed = _speed;
    time = 0;
  }

  void draw(int _rotation) {
    rotation = _rotation;
    draw();  
  }
  
  void draw()
  {
    float angle = TWO_PI/ n;
    float sz = map(sin(time), -1, 1, 5, 720);
    w = sz;
    h = sz;
    
    // you want one spin?
    // rotation = (int) sz / 10;

    pushMatrix();
    translate(cx, cy);    
    rotate(radians(rotation));   

    beginShape();
    for (int i = 0; i < n; i++)
    {
      vertex(w * cos(startAngle + angle * i), 
      h * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
    
    popMatrix();
    
    time = time + speed;
  }
  
  float getWidth() {
    return w;
  }
  
  float getHeight() {
    return h;
  }

}

