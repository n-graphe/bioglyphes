import geomerative.*;

RShape archi;

int fc = 0;

float unitSize = 10;
float eqTriH = 0.8660254;
int w = 1000;
int h = 500;
int cellsX = int(w/(unitSize*3));
int cellsY = int(h/(unitSize*eqTriH*2+eqTriH));
ArrayList<RPoint> hexGrid = new ArrayList<RPoint>();
PGraphics hexGridGraphics ;
ArrayList<LivingLetter> livingLetters = new ArrayList<LivingLetter>();


void setup() {
  size(w, h);
  RG.init(this);
  background(255);
  archi = RG.loadShape("archi.svg");
  //setupHexGrid();
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(10);
  for(RShape shape:archi.children){
    livingLetters.add(new LivingLetter(shape));
  }
}

void setupHexGrid(){
  hexGridGraphics = createGraphics(w,h);
  hexGridGraphics.beginDraw();  
    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        for (int k = 0; k < 4; k++){
          RPoint p = new RPoint(unitSize+i*unitSize*3+cos(TWO_PI/6*k)*unitSize, unitSize*eqTriH+j*unitSize*2*eqTriH+sin(TWO_PI/6*k)*unitSize);
          hexGrid.add(p);
          hexGridGraphics.point(p.x,p.y);
        }
      }
    }
  hexGridGraphics.endDraw();
  image(hexGridGraphics,0,0);
}

RPoint lastPoint = new RPoint();
void draw() {
  
  fc = frameCount;
  translate(100,100);
  
  noFill();
  beginShape();

  for(LivingLetter letter:livingLetters){
    for(int i=0; i<50; i++){
      letter.Update();
    }
  }
  
  endShape();
  
}

void keyPressed(){
  if(key=='s'){
    saveFrame("preview.png");
  }
}

