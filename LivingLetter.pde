import java.util.Arrays;

class LivingLetter{
  RShape s;
  ArrayList<RPoint> points = new ArrayList<RPoint>();
  RPoint baricenter;
  int MIN_X = 99999;
  int MAX_X = -99999;
  int MIN_Y = 99999;
  int MAX_Y = -99999;
  int WIDTH = 0;
  int HEIGHT = 0;
  LivingLetter(RShape _s){
    s = _s;
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(10);
    points.addAll(Arrays.asList(s.getPoints()));
    SetupBBox();
    //UseInsidePoints();
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
    for(int i=0; i<WIDTH*HEIGHT/20; i++){
      RPoint randomPoint = new RPoint(MIN_X+random(WIDTH),MIN_Y+random(HEIGHT));
      if(s.contains(randomPoint)){
        points.add(randomPoint);
      }
    }
    //RG.setPolygonizer(RG.UNIFORMLENGTH);
    //RG.setPolygonizerLength(min(100,10+mouseY/10));
    points.addAll(Arrays.asList(s.getPoints()));
  }
  
  void Update(){
   
    if(keyPressed){
          beginRecord(PDF, "record-"+key+".pdf");
           noFill();
    }
    RPoint[] pts = s.getPoints();
    int totalPts = pts.length;
    RPoint[] tgs = s.getTangents();
    int totalTgs = tgs.length;
    //
    int total = 30+mouseX;
    for(int i=0; i<total; i++){
    stroke(0,10);

     RPoint p = s.getPoint((float)i/total);
      RPoint t = s.getTangent((float)i/total);
      t.scale(10);

     pushMatrix();
     translate(p.x,p.y);
      line(0,0,t.x,t.y);
      //point(t.x,t.y);
      popMatrix();  
    }
    
    

    
    
    if(keyPressed){
      endRecord();
      saveFrame("currentFrame.jpg");
    }
    if(mousePressed){
      saveFrame("currentFrame"+mouseX+"_"+mouseY+".jpg");
    }
  }
  
}
