/*
This object creates a line from a random point on the screen to the position
 of the cursor. The colour of the line changes over time.
 An arrangement of this objects is handled by the Landscape object
 */


class LiveLine {

  //DATA


  //coordinates of the lines
  float x1, y1, x2, y2;



  // colour variables 
  color c;
  int r, g, b;



  //these variables determine in what ranges the colours change over time
  int minR = 0; 
  int maxR = 80;

  int minG = 0;
  int maxG = 200;

  int minB = 170;
  int maxB = 250;



  //angle for changing colours
  float a;




  //CONSTRUCTOR

  LiveLine() {
    init();
  }

  //OTHER FUNCTIONS

  /*
  This function initializes the object giving it random coordinates
   and initializin the angle at a random number
   */
  void init() {


    //generating line starting position
    //inside a limited section on the screen
    x1 = random(width/5, width*4/5);
    y1 = random(height/8, height*7/8);

    //generating angle starting point
    a = random(0, 360);
  }


  /*
  This function updates the object's colour and stores the cursor position
   */
  void update() {
    //updating the colour
    r = int( map( sin(a), -1, 1, minR, maxR));
    g = int( map( sin(a + 120), -1, 1, minG, maxG));
    b = int( map( sin(a + 240), -1, 1, minB, maxB));
    c = color(r, g, b);

    //updating the angle
    a+= 0.05;
    if (a >360) a=0;

    //storing cursor position
    x2 = mouseX;
    y2 = mouseY;
  }

  //this function shows the object, using data from the update() function
  void show() {

    pushStyle();

    stroke(c);
    strokeWeight(4);
    line(x1, y1, x2, y2);

    popStyle();
  }
}
