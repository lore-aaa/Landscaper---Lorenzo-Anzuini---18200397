
/*
Thsi object creates a static version of the LiveLine object, with fixed
 colour and position.
 The Landscape object handles an arrangement of these objects creating a
 tail of lines behing the moving LiveLines
 */


class TailLine {

  //DATA


  //coordinate and single colour variables
  float x1, y1, x2, y2, rS, gS, bS;

  //collective colour variable
  color cS;

  //CONSTRUCTOR
  TailLine() {
  }

  //OTHER FUNCTIONS

  /*
  This function updates the object
   in the Landscape object data is passed on from a LiveLine object 
   to a TailLine object using this function
   */
  void update(float x1_, float y1_, float x2_, float y2_, int rS_, int gS_, int bS_) {

    x1 = x1_;
    y1 =y1_;
    x2 = x2_;
    y2 = y2_;

    rS = rS_;
    gS = gS_;
    bS = bS_;

    cS = color(rS, gS, bS);
  }

  /*
  This function draws the object according to the data gathered by the
   update() function
   */
  void show() {

    pushStyle();

    strokeWeight(4);
    stroke(cS);
    line(x1, y1, x2, y2);

    popStyle();
  }
}
