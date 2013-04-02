class LivingLetter2{
  RShape s;
  RPoint[] points;
  RPoint baricenter;
  LivingLetter2(RShape _s){
    s = _s;
    points = s.getPoints();
    SetupBaricenter();
    // 
  }
  
  void SetupBaricenter(){
    baricenter = new RPoint();
    for(RPoint p: points){
      baricenter.add(p);
    }
    baricenter.scale((float)1/points.length);
  }
  
  void Update(){
    randomSeed(0);
    int i=0;
    int total = points.length;
    for(RPoint p:points){
      RPoint rp = new RPoint();
      rp = points[((int)pow(i,1.05))%total];
      line(p.x,p.y,rp.x,rp.y);
      i++;
    }
    if(keyPressed){
      saveFrame("currentFrame.jpg");
    }
  }
  
}
