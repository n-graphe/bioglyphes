import com.nootropic.processing.layers.*;
import java.util.Date;
import processing.pdf.*;

import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
//
RPoint o = new RPoint(0,0); // origine du plan
//
boolean recording;
PGraphicsPDF pdf;
PGraphics view;
PGraphics GUI;
//
//
void SetupGeomerative(){
  //
  view = createGraphics(width, height);
  view.beginDraw();
  view.endDraw();  
  GUI = createGraphics(width, height);
  GUI.beginDraw();
  GUI.endDraw();
  if(!debug){
  }
  //
  RG.init(this);
  InitTypo();
  //
}

RShape typo;

void InitTypo(){
  typo = new RShape();
  for(int line=0; line<text.length; line++){
    RShape shapeLine =  RG.getText(text[line],"heimatsansregular.ttf",(int)fontSize,LEFT);
    //
    int letterSpacingOffset = 0;
    for(int i=0; i<shapeLine.children.length; i++){
      RShape letter = shapeLine.children[i];
      letter.translate(letterSpacingOffset,0);
      letterSpacingOffset += letterSpacing;
    }
    shapeLine.translate(0,lineHeight*(1+line));
    typo.addChild(shapeLine);
  }
  typo.translate((width-typo.getWidth())/2,(height-typo.getHeight())/2);
}

long timestamp(){
  return (new Date()).getTime();
}

void StopPropagation(){
    for(Branche b:branches){
      b.StopPropagation();
   }
}

void keyPressed(){
  if(key=='k'){
    // arrète toute les branches
    StopPropagation();
  }
  // sauvegarde une frame
  if(key=='f'){
    saveFrame("preview.png");
  }
  // sauvegarde un PDF
  if(key=='s'){
    //
    //
    SavePDF();
    //exit();
  }
}
//
// Sauvegarde le PDF
//
void SavePDF(){
  //
  pdf = (PGraphicsPDF) createGraphics(width, height, PDF,"record-"+timestamp()+".pdf");
  //
    beginRecord(pdf);
    //
    background(0);
    //
    println("beginRecord PDF");
    println("rendu de "+clusters.size()+" branches : ");
    //
    long t0 = timestamp();
    int r=0;
    for(Branche branche:clusters){
       r++;
       //
       //
      if(r%10==0){
        print(".");
      }
      branche.DrawCluster();
    }
    endRecord();
    println(" > "+r+" branches rendues en "+(timestamp()-t0)+" ms");
}
