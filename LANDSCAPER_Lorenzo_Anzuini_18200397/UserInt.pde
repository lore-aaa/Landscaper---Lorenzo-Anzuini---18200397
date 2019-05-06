/*
This object creates a starting/information screen that is
 partially adaptable to different screen sizes, and a writing at the bottom
 of the screen that reminds the user how to visualize the information
 screen
 */

class UserInt {


  //DATA

  //used to store the writings shown on the screen
  String title, info, drawCon, tapCon, programsCon, info2, screenCon;

  //used to hold the pictures in the background of the info screen
  PImage picL, picR;

  //leading of the text
  int leading;

  //coordinates of the writings and the rectangles drawn around them
  int infoX, infoY, infoHeight;

  //determines if info screen is shown. controlled by keyPressed()
  //function in the main tab
  boolean showControls;

  //fonts of different sizes
  PFont fontBig, fontMedium, fontSmall;




  //CONSTRUCTOR
  UserInt() {



    title = "LANDSCAPER";
    info = "push the white labeled button to show/hide controls";
    drawCon = "move the pen to draw the landscape";
    tapCon = "tap on the tablet to create a new set of lines";
    programsCon = "push the red and yellow labeled buttons to switch between\nprograms with different numbers of lines";
    info2 = "push the white labeled button to show/hide this screen";
    screenCon = "push the spacebar to take a screenshot";


    picL = loadImage("screen.jpg");
    picR = loadImage("screen2.jpg");


    //resizing images depending on screensize
    if (width/height >= 2) {
      if (height < 900) {
        picL.resize(height*2/3, height*2/3);
        picR.resize(height*2/3, height*2/3);
      }
    } else {
      if (width < 1200) {
        picL.resize(width*2/6, width*2/6);
        picR.resize(width*2/6, width*2/6);
      }
    }

    //creating three different vrsions of the same font with different size
    //to avoid pixelating
    fontBig = createFont("Muli-Regular", width/24);
    fontMedium = createFont("Muli-Regular", width/60);
    fontSmall = createFont("Muli-Regular", width/80);

    //variable set to true so the info screen is shown when the program
    //is launched and therefore also functions as a starting screen
    showControls = true;

    // defining variables to control text position depending on screensize
    leading = height/100;

    infoX = width/2;
    infoY = height/3;
    infoHeight = height/15;
  }


  //OTHER FUNCTIONS

  /*
    This fuctions shows the information screen
   depending on the showControls variable
   controlled by the keyPressed() function
   */
  void show() {

    //if showControls is false the information screen is not shown
    //and only a reminder on how to showit is drawn at the bottom of the
    //screen
    if (!showControls) {
      pushStyle();

      noStroke();
      fill(bg);
      rectMode(CENTER);
      rect(width/2, height*15/16, width/3, height/30);

      textFont(fontSmall);
      textAlign(CENTER, CENTER);
      fill(230, 50, 150);
      text(info, width/2, height*15/16);
      popStyle();
    } 

    //if showControls is true the info screen is shown
    else {

      //drawing the pictures
      imageMode(CENTER);
      image(picL, width/5, height/2);
      image(picR, width*4/5, height/2);

      //drawing the rectangles around the texts
      pushStyle();
      strokeWeight(2);

      //colour a LiveLine object is used for the stroke of the rectangles
      //to make the colour change over time
      stroke(landscape.group[0].c);
      fill(0);
      rectMode(CENTER);

      //calculating position of rectangles and drawing them
      rect(infoX, infoY, width/2, infoHeight);
      rect(infoX, infoY+(infoHeight*1.5), width/2, infoHeight);
      rect(infoX, infoY+(infoHeight*3.75), width/2, infoHeight*2);
      rect(infoX, infoY+(infoHeight*6), width/2, infoHeight);
      rect(infoX, infoY+(infoHeight*7.5), width/2, infoHeight);


      textAlign(CENTER, CENTER);
      textLeading(leading);
      fill(250, 50, 170);

      //drawing the title
      textFont(fontBig);
      text(title, width/2, height/6);


      //drawing information texts
      textFont(fontMedium);
      text(drawCon, infoX, infoY);
      text(info2, infoX, infoY+(infoHeight*1.5));
      text(programsCon, infoX, infoY+(infoHeight*3.75));
      text(tapCon, infoX, infoY+(infoHeight*6));
      text(screenCon, infoX, infoY+(infoHeight*7.5));
      popStyle();
    }
  }
}
