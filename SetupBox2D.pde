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
    //
    RPoint[] typoPoints = typo.getPoints();
    // Define the polygon
    /*BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    ChainShape chain = new ChainShape();
    println(typoPoints.length);
    Vec2[] vertices = new Vec2[typoPoints.length];*/
    int i = 0;
    int SIZE = 3;
    for(RPoint tp:typoPoints){
      //point(tp.x,tp.y);
      //
      BodyDef bd = new BodyDef();
      bd.type = BodyType.STATIC;
      bd.position.set(box2d.coordPixelsToWorld(tp.x,tp.y));
      //
      Body body = box2d.world.createBody(bd);

    PolygonShape ps = new PolygonShape();
      float box2dW = box2d.scalarPixelsToWorld(SIZE/2);
      float box2dH = box2d.scalarPixelsToWorld(SIZE/2);
      ps.setAsBox(box2dW, box2dH);
      
      FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;

//Set physics parameters.

    fd.friction = 0.3;
    fd.restitution = 0.5;
 

//Attach the Shape to the Body with the Fixture.

    body.createFixture(fd);
    
      i++;
    }
    /*chain.createChain(vertices,vertices.length);
    
    FixtureDef fd = new FixtureDef();
    //A fixture assigned to the ChainShape
    fd.shape = chain;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    // 
    body.createFixture(fd);*/


     
}
