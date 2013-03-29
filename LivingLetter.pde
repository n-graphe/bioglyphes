class LivingLetter{
  
  RShape s;
  RPoint[] points;
  RPoint baricenter;
  RPoint reading;
  RPoint rVelocity = new RPoint();
    
  LivingLetter(RShape _s){
    s = _s;
    points = s.getPoints();
    baricenter = new RPoint();
    for(RPoint p: points){
      baricenter.add(p);
    }
    baricenter.x/=points.length;
    baricenter.y/=points.length;
    reading = new RPoint(baricenter);
  }
  float speed = random(10);
  float speed2 = random(20);
  void Update(){
    speed+=.2;
    speed2+=.8;
    //if(random(1)<.01){speed+=60;}
    RPoint pTarget = points[floor(speed)%points.length];
    RPoint pTarget2 = points[floor(speed2)%points.length];
    
    RPoint bar = new RPoint(pTarget);
    bar.add(pTarget2);
    bar.x/=2;
    bar.y/=2;
    
    rVelocity = new RPoint(pTarget);
    rVelocity.sub(reading);
    rVelocity.x *= .1;
    rVelocity.y *= .1;
    
    reading.add(rVelocity);
    //point(reading.x,reading.y);
    point(bar.x,bar.y);
    
    /*for(RPoint p: points){
      float d = baricenter.dist(p)/10+4;
      point(p.x+sin(PI*(i+frameCount)/360)*d,p.y+cos(PI*(i+frameCount)/360)*d);
      i++;
    }*/
  }
  
}
