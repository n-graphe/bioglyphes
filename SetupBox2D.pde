//
// utilise la librairie Box2d
// https://github.com/shiffman/Box2D-for-Processing/
//

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


// A reference to our box2d world
PBox2D box2d;

void SetupBox2D(){
  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(10, 0);
  //
  SetupTypoBox2D();
}
void SetupTypoBox2D(){
  for(RShape shape: typo.children){
    SetupShape(shape);
  }
}

void SetupShape(RShape shape){
    // Define the polygon
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    ChainShape chain = new ChainShape();
    RPoint[] shapePoints = shape.getPoints();
    Vec2[] vertices = new Vec2[shapePoints.length];
    int i = 0;
    for(RPoint tp:shapePoints){
      vertices[i] = box2d.coordPixelsToWorld(tp.x,tp.y);
      i++;
    }
    chain.createChain(vertices,vertices.length);
    
    FixtureDef fd = new FixtureDef();
    //A fixture assigned to the ChainShape
    fd.shape = chain;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    // 
    body.createFixture(fd);     
}
