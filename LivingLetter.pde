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
  float speed = 0;
  void Update(){
    speed+=.2;
    if(random(1)<.002){speed+=20;}
    int i=0;
    RPoint pTarget = points[floor(speed)%points.length];
    rVelocity = new RPoint(pTarget);
    rVelocity.sub(reading);
    rVelocity.x *= .1;
    rVelocity.y *= .1;
    reading.add(rVelocity);
    point(reading.x,reading.y);
    /*for(RPoint p: points){
      float d = baricenter.dist(p)/10+4;
      point(p.x+sin(PI*(i+frameCount)/360)*d,p.y+cos(PI*(i+frameCount)/360)*d);
      i++;
    }*/
  }
  
}
