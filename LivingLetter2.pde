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
    points = new ArrayList<RPoint>();
    for(int i=0; i<WIDTH*HEIGHT/(max(50,mouseX)); i++){
      RPoint randomPoint = new RPoint(MIN_X+random(WIDTH),MIN_Y+random(HEIGHT));
      if(s.contains(randomPoint)){
        points.add(randomPoint);
      }
    }
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(min(100,10+mouseY/10));
    points.addAll(Arrays.asList(s.getPoints()));
  }
  
  void Update(){
    UseInsidePoints();
    strokeWeight(.5);
    int i=0;
    int total = points.size();
    //
    for(RPoint p:points){
      RPoint p0 = new RPoint(points.get((i+1)%total));
      RPoint p1 = new RPoint(points.get((i+3)%total));
      RPoint p2 = new RPoint(points.get((i+7)%total));
      p0 = p1 = p2 = new RPoint(300,-50);
      for(int pcount=0; pcount<points.size()*2+2; pcount++){
        RPoint pn = points.get(pcount%points.size());
        if(p!=pn){
          if(p.dist(pn)<p.dist(p0)){
            p0 = new RPoint(pn);
          }
          if(p.dist(pn)<p.dist(p1)){
            if(p.dist(pn) != p.dist(p0)){
              p1 = new RPoint(pn);
            }
          }
          if(p.dist(pn)<p.dist(p2)){
           if((p.dist(pn) != p.dist(p1))&&(p.dist(pn) != p.dist(p0))){
              p2 = new RPoint(pn);
            }
          }           

          
        }
        
      }
      rectMode(CORNERS);
      ellipseMode(CORNERS);
      stroke(0,50);
      strokeWeight(0.5);
      float Size = (p.x-p0.x);
       ellipse(p.x-Size*2,p.y-Size,2*Size+p0.x,p.y+Size*2);
     //line(p.x, p.y,p0.x,p0.y);
      stroke(0,0,255,200);
      rect(p0.x,p0.y,p1.x,p1.y);
      //strokeWeight(1);
      //line(p.x, p.y,p1.x,p1.y);

      stroke(255,0,0,255);
       line(p0.x,p0.y,p2.x,p2.y);
     //line(p.x, p.y,p2.x,p2.y);
      strokeWeight(6);
      //point(p.x,p.y);
      i++;
    }
    if(keyPressed){
      saveFrame("currentFrame.jpg");
    }
    if(mousePressed){
      saveFrame("currentFrame"+mouseX+"_"+mouseY+".jpg");
    }
  }
  
}
