class branche{
  boolean dead = false;
  int t=0;
  int lifeTime = 40;
  int SIZE = 30;
  float time = 0;
  float offset = 0;
  float angle = 0;
  int level = 0;
  int MAX_LEVEL = 4;
  PVector position = new PVector(0,0);
  PVector velocity = new PVector(0,0);
  //
  ArrayList<branche> sub = new ArrayList<branche>();
  //
  branche(PVector start, PVector startV, int l){
    level = l;
    //
    if(level == 0){
      //background(255);
    }
    offset = random(0,TWO_PI);
    lifeTime = (int) random(40,80);
    SIZE = (int) random(20,80);
    position = new PVector(start.x,start.y);
    velocity = new PVector(startV.x, startV.y);
  }
  boolean draw(){
    update();   
    return dead;
  }
  void update(){
    if(!dead){
      if(sub.size()>0){
        boolean allDead = true;
        for(branche b:sub){
          allDead &= b.draw();
        }
        if(allDead){
          Kill();
        }
      }else{
        t++;
        time = (float)t/lifeTime;
        //
        float misc = .05;
        float miscLevel = misc*(1+level);
        velocity.add(new PVector(random(-miscLevel,miscLevel),random(-miscLevel,miscLevel)));
        position.add(velocity);
        ellipse(position.x,position.y,MAX_LEVEL-level+1,MAX_LEVEL-level+1);
        //
        if(t>lifeTime){
        if(level<MAX_LEVEL){
          sub.add(new branche(position, velocity, level+1));
          sub.add(new branche(position, velocity, level+1));
        }else{
          Kill();
        }
      }
      }
      
      
    }
  }
  void Kill(){
    dead = true;
  }
  
}
