import java.util.Arrays;

class LivingLetter2{
  RShape s;
  ArrayList<RPoint> points = new ArrayList<RPoint>();
  RPoint baricenter;
  int MIN_X = 99999;
  int MAX_X = -99999;
  int MIN_Y = 99999;
  int MAX_Y = -99999;
  int WIDTH = 0;
  int HEIGHT = 0;
  LivingLetter2(RShape _s){
    s = _s;
    points.addAll(Arrays.asList(s.getPoints()));
    SetupBBox();
    UseInsidePoints();
    // 
  }
  
  void SetupBBox(){
    baricenter = new RPoint();
    //
    for(RPoint p: points){
      //
      MAX_X = (int)(p.x>MAX_X?p.x:MAX_X);
      MAX_Y = (int)(p.y>MAX_Y?p.y:MAX_Y);
      MIN_X = (int)(p.x<MIN_X?p.x:MIN_X);
      MIN_Y = (int)(p.y<MIN_Y?p.y:MIN_Y);
      //
      baricenter.add(p);
    }
    //
    WIDTH = MAX_X-MIN_X;
    HEIGHT = MAX_Y-MIN_Y;
    //
    baricenter.scale((float)1/points.size());
  }
  
  void UseInsidePoints(){
    println(WIDTH*HEIGHT);
    points = new ArrayList<RPoint>();
    for(int i=0; i<WIDTH*HEIGHT/400; i++){
      RPoint randomPoint = new RPoint(MIN_X+random(WIDTH),MIN_Y+random(HEIGHT));
      if(s.contains(randomPoint)){
        points.add(randomPoint);
      }
    }
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(20);
    points.addAll(Arrays.asList(s.getPoints()));
  }
  
  void Update(){
    strokeWeight(2);
    int i=0;
    int total = points.size();
    //
    for(RPoint p:points){
      RPoint rp = new RPoint();
      point(p.x, p.y);
      i++;
    }
    if(keyPressed){
      saveFrame("currentFrame.jpg");
    }
  }
  
}
