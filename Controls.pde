import controlP5.*;
ControlP5 cp5;
//
int sliderCount = 0;
//
void SetupControls(){
  //
  cp5 = new ControlP5(this);
  //
  SetupSlider("LIFE_TIME",5,400);
  SetupSlider("MAX_VELOCITY",0,8);
  SetupSlider("NATURAL_TANGENT_AREA_SIZE",1,fontSize);
  SetupSlider("STRUCTURE_ATTRACTION",0,5);
  SetupSlider("MISC_LEVEL",0,2000);
  SetupSlider("CIRCONVOLUTION_LEVEL",0,600);
  SetupSlider("STROKE_WEIGHT",0,20);
  SetupSlider("MAX_CHILDREN",1,6);
  SetupSlider("MAX_LEVEL",1,8);
  SetupSlider("INTERNAL_VIBRATION_LEVEL",0,3);
  SetupSlider("GREY_LEVEL",0,255);
  SetupSlider("ALPHA_LEVEL",0,255);
  //
}
void SetupSlider(String valName, float min, float max){
     Slider s = cp5.addSlider(valName)
     //
     .setPosition(10,10+sliderCount*12)
     .setRange(min,max)
     .setColorCaptionLabel(color(255-BACKGROUND_COLOR))
     .setColorValueLabel(color(255-BACKGROUND_COLOR))
     //
     ;
     sliderCount++;
}
