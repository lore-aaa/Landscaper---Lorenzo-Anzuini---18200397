/*
Lorenzo Anzuini
 30/04/2019
 LANDSCAPER
 
 This program draws on the screen an arrangemenr of lines that go from
 random points to the position of the cursor (LiveLine objects).
 The clour of this object changes dinamically. The lines are followed
 by a tail of fixed colour lines (TailLine bojects) that mimic
 their movement. The lies objects are handled by the Landscape object.
 
 This arrangement of lies creates abstract shapes, that look like
 distant mountains coming in and out of sight. The intention is to make
 the user get lost in the visuals that they are drawing, as if they were 
 looking at fire or waves.
 
 The program is written for graphic pen tablets and relies on the
 Tablet library, developped by Andres Colubri.
 The library is only tesed (and therefore assured to work with) Wacom
 tablets, and can be dawnloaded here:
 https://github.com/codeanticode/tablet
 
 Copyright (c) 2019 Lorenzo Anzuini. MIT License.
 v1.0
 */

//Libraries
import codeanticode.tablet.*;

// Initialization

//variable to read the pressure intensity from the tablet
//in the tabPressed() function of the Landscape object
Tablet tablet;


//initializing Landscape, object that handles the arrangement of lines on screen
Landscape landscape;

//initializing UserInt, object that draws information screen
UserInt ui;

//used in the keyPressed() function, determines which program is being used
//and therefore how many lines are drawn on the screen
int program;

//used in the keyPressed() and screenShot() functions to determine if a screenshot
//should be taken
boolean screenShot;

//background colour
int bg;


void setup() {

  size(1800, 900, P2D);

  screenShot = false;

  bg = 0;
  background (bg);



  tablet = new Tablet(this); 

  landscape = new Landscape();

  ui = new UserInt();

  program = 2;
}

void draw() {
  background (bg);

  landscape.tabPressed();
  landscape.update();

  //if the info screen is not shown, draw the lines on the screen
  if (!ui.showControls) {
    landscape.show();
  }

  screenShot();
  ui.show();
}




/*
 This function constrols the changeProgram()
 function, and determines whether or not
 a program change is needed
 
 It controls the showControls variable
 determining wether or not the screen
 created by the UserInt object is visible
 
 It also controls the Screenshot variable
 determining wether or not a screenshot should be taken
 
 Shift, Alt and Control buttons correspond to buttons
 on the tablet
 */
void keyPressed() {
  if (key == CODED) {

    //determining if a program change is needed
    if (keyCode == SHIFT) {
      if (program < 3) {
        program++;
        landscape.programChange(program);
      }
    } else if (keyCode == ALT) {
      if (program >0) {
        program--;
        landscape.programChange(program);
      }
    }

    //determining if the info screen needs to be shown
    //this affects the UserInt show() function
    if (keyCode == CONTROL) {
      ui.showControls = !ui.showControls;
    }
  }

  //determining if the program should take a screenshot
  //this affects the screenShot() function
  if (key == ' ') {
    screenShot = true;
  }
}

/*
This function takes a screenshot if the screenShot variable is true
 */
void screenShot() {
  if (screenShot) {
    saveFrame("landscape-######.tif"); 
    screenShot = false;
  }
}
