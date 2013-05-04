// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// PBox2D example

// A rectangular box
class Box {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  int count = 0;
  ArrayList<RPoint> trajectoire = new ArrayList<RPoint>();
  

  // Constructor
  Box(float x, float y) {
    w = 5;
    h = 10;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    count++;
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*h || pos.x>width+w*h || pos.x<0 || pos.y<0) {
      killBody();
      return true;
    }
    Vec2 linVel =body.getLinearVelocity();
    /*if( count>2 && linVel.x==0 && linVel.y==0){
      return true;
    }
    if(count>500){
      return true;
    }*/
    return false;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    //fill(175);
    //stroke(0);
   if(!typo.contains(pos.x, pos.y)){
      rect(0, 0, w, h);
      //trajectoire.add(new RPoint(pos.x, pos.y));
    }
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    float POWER = 20;
    float a = random(0,PI*2);
    body.setLinearVelocity(new Vec2(0,0));
    body.setAngularVelocity(random(-5, 5));
  }
}


