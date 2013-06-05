import java.util.Date;
import processing.pdf.*;

import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
//
RPoint o = new RPoint(0,0); // origine du plan
//
//
void SetupGeomerative(){
  //
  if(!debug){
    beginRecord(PDF,"record-"+timestamp()+".pdf");
  }
  //
  RG.init(this);
  InitTypo();
  //
}

RShape typo;

void InitTypo(){
  typo = RG.getText(text,"heimatsansregular.ttf",(int)fontSize,CENTER);
  typo.translate(width/2,height/2+fontSize/3);
}

long timestamp(){
  return (new Date()).getTime();
}
void keyPressed(){
  // sauvegarde une frame
  if(key=='f'){
    saveFrame("preview.png");
  }
  // sauvegarde une frame
  if(key=='s'){
    endRecord();
    exit();
  }
}
