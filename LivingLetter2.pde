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
    for(int i=0; i<WIDTH*HEIGHT/1000; i++){
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
    strokeWeight(.5);
    int i=0;
    int total = points.size();
    //
    for(RPoint p:points){
      RPoint p0 = new RPoint(points.get(0));
      RPoint p1 = new RPoint(points.get(0));
      RPoint p2 = new RPoint(points.get(0));
      p0 = p1 = p2 = new RPoint(300,-50);
      for(RPoint pn:points){
        if(p!=pn){
          if(p.dist(pn)<p.dist(p0)){
            //p2 = new RPoint(p1);
            p1 = new RPoint(p0);
            p0 = new RPoint(pn);
          }
        }
      }
      stroke(0);
      strokeWeight(0.5);
      line(p.x, p.y,p0.x,p0.y);
      stroke(0,0,255);
      //strokeWeight(1);
      line(p.x, p.y,p1.x,p1.y);
      //line(p.x, p.y,p2.x,p2.y);
      i++;
    }
    if(keyPressed){
      saveFrame("currentFrame.jpg");
    }
  }
  
}
