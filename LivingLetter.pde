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
    float TOTAL = 300;
    float INTERVAL = 30;
    TOTAL = s.width*s.height/pow(INTERVAL,2);
    for(int i = 1; i<TOTAL; i++){
      /*RPoint rp = new RPoint((i*INTERVAL)%s.width,s.height*i/TOTAL);
      if(!s.contains(rp)){
        rdmPoints.add(rp);
      }*/
      
      RPoint rp = new RPoint(random(-20,740),random(20,200));
      //rp.x += sin(i/TWO_PI)*400*i/TOTAL;
      //rp.y +=  cos(i/TWO_PI)*100*i/TOTAL;
      if(!s.contains(rp)){
        rdmPoints.add(rp);
        rdmVelocity.add(new RPoint());
      }
      
      /*
      RPoint rp = new RPoint(baricenter);
      rp.x += sin(i/TWO_PI)*ShapeA*.5*i/TOTAL;
      rp.y +=  cos(i/TWO_PI)*ShapeA*i/TOTAL;
      if(!s.contains(rp)){
        rdmPoints.add(rp);
        rdmVelocity.add(new RPoint());
      }*/
    }
    //
  }
  float speed = random(10);
  float speed2 = random(20);
  void Update(){
//  beginShape();
    
    for(RPoint rp: rdmPoints){
      /*RPoint cvel = new RPoint();
      for(RPoint rpp: rdmPoints){
        RPoint diff = new RPoint(rp.x-rpp.x,rp.y-rpp.y);
        cvel.add(diff);
      }
      cvel.x/=rdmPoints.size();
      cvel.y/=rdmPoints.size();*/
      
      RPoint diff = new RPoint(random(-1,1),random(-1,1));
      rp.add(diff);
//
//*
      int tryCount = 0;
      while(s.contains(rp)&&(random(1)>.1)){
         rp.sub(diff);
         diff = new RPoint(random(-1,1),random(-1,1));
         rp.add(diff);
      }
//*/      
      //if(!s.contains(rp)){
        point(rp.x,rp.y);
      //} 
    }
//  endShape();
    //point(bar.x,bar.y);
    
    
    
    /*for(RPoint p: points){
      float d = baricenter.dist(p)/10+4;
      point(p.x+sin(PI*(i+frameCount)/360)*d,p.y+cos(PI*(i+frameCount)/360)*d);
      i++;
    }*/
  }
  
}
