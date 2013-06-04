import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;

String title = "aA";
RShape typo;
RPoint o = new RPoint(0,0);

void SetupGeomerative(){
  RG.init(this);
  typo = RG.getText(title,"heimatsansregular.ttf",800,CENTER);
  typo.translate(width/2,height/2+300);
  //
}
