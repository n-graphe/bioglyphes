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
  boolean inside = true;
  RPoint position = new RPoint(0,0);
  RPoint velocity = new RPoint(0,0);
  //
    float misc = .02;
    float miscLevel = 0;
    ArrayList<branche> sub = new ArrayList<branche>();
  //
  branche(RPoint start, RPoint startV, int l){
    level = l;
    //
    if(level == 0){
      //background(255);
    }
    offset = random(0,TWO_PI);
    lifeTime = (int) random(80-level*10,160-level*20);
    SIZE = (int) random(20,80);
    position = new RPoint(start.x,start.y);
    velocity = new RPoint(startV.x, startV.y);
    miscLevel =  misc*(2+level*level);
        inside = typo.contains(position);
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
        RPoint destination = new RPoint(position);
        //
        velocity.add(new RPoint(random(-miscLevel,miscLevel),random(-miscLevel,miscLevel)));
        destination.add(velocity);
        if(inside && !typo.contains(destination)){
        while(!typo.contains(destination) ){//&& !(random(1)<.02)){
           destination = new RPoint(position);
           velocity = new RPoint(random(-1,1),random(-.8,1));
           destination.add(velocity);
        }
        }
        //
        position.add(velocity);
        inside = typo.contains(position);
        ellipse(position.x,position.y,MAX_LEVEL-level+1,MAX_LEVEL-level+1);
        drawingCount++;
        //
        if(t>lifeTime){
        if(level<MAX_LEVEL){
          for(int q=0; q<=1; q++){
          sub.add(new branche(position, velocity, level+1));
          }
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
