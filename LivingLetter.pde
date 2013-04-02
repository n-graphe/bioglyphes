class LivingLetter{
  
  RShape s;
  RPoint[] points;
  RPoint baricenter;
  RPoint reading;
  RPoint rVelocity = new RPoint();
  ArrayList<RPoint> rdmPoints = new ArrayList<RPoint>();
  ArrayList<RPoint> rdmVelocity = new ArrayList<RPoint>();
    
  LivingLetter(RShape _s){
    s = _s;
    points = s.getPoints();
    baricenter = new RPoint();
    for(RPoint p: points){
      baricenter.add(p);
    }
    //
    baricenter.x/=points.length;
    baricenter.y/=points.length;
    reading = new RPoint(baricenter);
    //
    int ShapeA = 120;
    int TOTAL = 100;
    for(int i = 0; i<TOTAL; i++){
      RPoint rp = new RPoint(baricenter);
      rp.x += sin(i/TWO_PI)*ShapeA*.5*i/TOTAL;
      rp.y +=  cos(i/TWO_PI)*ShapeA*i/TOTAL;
      if(!s.contains(rp)){
        rdmPoints.add(rp);
        rdmVelocity.add(new RPoint());
      }
    }
    //
  }
  float speed = random(10);
  float speed2 = random(20);
  void Update(){
  beginShape();
    
    for(RPoint rp: rdmPoints){
      RPoint cvel = new RPoint();
      for(RPoint rpp: rdmPoints){
        RPoint diff = new RPoint(rp.x-rpp.x,rp.y-rpp.y);
        cvel.add(diff);
      }
      cvel.x/=rdmPoints.size();
      cvel.y/=rdmPoints.size();
      
      RPoint diff = new RPoint(random(-1,1),random(-1,1));
      rp.add(diff);
      while(s.contains(rp)){
          rp.sub(diff);
         diff = new RPoint(random(-1,1),random(-1,1));
          rp.add(diff);
      }
        point(rp.x,rp.y);
    }
  endShape();
    //point(bar.x,bar.y);
    
    
    
    /*for(RPoint p: points){
      float d = baricenter.dist(p)/10+4;
      point(p.x+sin(PI*(i+frameCount)/360)*d,p.y+cos(PI*(i+frameCount)/360)*d);
      i++;
    }*/
  }
  
}
