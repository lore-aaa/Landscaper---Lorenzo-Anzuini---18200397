/*
This class creates and hadles an array of LiveLine objects
 and a 2D array of TailLine objects. It updates the objects providing the 
 information needed and draws them, creating the digital landscape
 that the user can interact with.
 */


class Landscape {


  //DATA


  //maximum size the LiveLine object array can have and size tha is
  //currently used depending on the program selected by the users
  int maxSize, currSize;

  //one dimension of the TailLine objects array, determines the length
  //of the tail of TailLine objects behind the LiveLine objects
  int tail;


  //used to store the coordinates of the LiveLine objects in the
  //TailLine objects
  float x1, y1, x2, y2;

  //used to store colour components of the LiveLine objects in the
  //TailLine objects
  int rS, gS, bS;

  //live lines array
  LiveLine[] group;

  //tail lines array, behaves like a ring buffer
  TailLine[][] pastLines;

  //determined in the keyPressed() function in the main code tab
  //used to determine which program is being used
  //and therefore the number of lines currently shown
  //used in the programChange() function
  int program;



  //used to fine tune the tapping interaction with the tablet
  //in the tabPressed() function
  float lim;

  //logical structure of the tabPressed() function, to determine
  //if the tablet has been tapped
  boolean tap;
  boolean aboveThresh;
  boolean checking;
  int currTime;


  //used to store data in the TailLine array like in a ring buffer
  int indexPosTail;
  int indexPosLive;






  //CONSTRUCTOR

  Landscape() {


    indexPosTail = 0;
    indexPosLive = 0;

    // initializing size variables
    currSize = 20;
    maxSize = 50;

    tail = 50;


    program = 2;



    //initializing tapping interaction variables
    tap = false;
    aboveThresh = false;
    checking = false;
    currTime = 0;

    lim = 0.15;


    //initializing arrays that hold the objects
    group = new LiveLine[maxSize];

    pastLines = new TailLine[tail][maxSize];


    //initializing LiveLine objects needed when the program is launched
    for (int i = 0; i<currSize; i++) {

      group[i] = new LiveLine();
    }
    // filling the rest of the array with nulls 
    for (int i = currSize; i < maxSize; i++) {

      group[i] = null;
    }

    //initializing TailLine objects needed when the program is launched
    for (int i = 0; i < tail; i++) {

      for (int j = 0; j < currSize; j++) {

        pastLines[i][j] = new TailLine();
      }
      for (int j = currSize; j < maxSize; j++) {

        // filling the rest of the array with nulls 
        pastLines[i][j] = null;
      }
    }
  }


  //OTHER FUNCTIONS

  /*
  This function updates the Liveline and the TailLine objects
   */

  void update() {


    for (int i = 0; i < currSize; i++) {
      group[i].update();
      if (group[i].y1 ==0) {
        println(i);
      }
    }


    //update TailLine objects only if the cursor is moving
    //so that if it stops the tail is not erased
    if (mouseX != pmouseX || mouseY != pmouseY) {


      //treat the pastLines array as a ring buffer of efficency
      //idea originally taken from this tutorial https://bit.ly/2IRjXYP
      //at the Record Data section, and developped to work with a 2D array
      indexPosTail = (indexPosTail + 1) % tail;
      indexPosLive =(indexPosLive +1)%currSize;
      for (int i = 0; i < currSize; i++) {

        indexPosLive =(indexPosLive +i)%currSize;


        //taking information from the LiveLine objects
        x1 = group[indexPosLive].x1;
        y1 = group[indexPosLive].y1;
        x2 = mouseX;
        y2 = mouseY;

        rS = group[indexPosLive].r;
        gS = group[indexPosLive].g;
        bS = group[indexPosLive].b;


        //passing the information on to the TailLine objects
        pastLines[indexPosTail][indexPosLive].update(x1, y1, x2, y2, rS, gS, bS);
      }
    }
  }


  /*
  This function draws the LiveLine and the TailLine objects
   */
  void show() {

    //check TailLine objects
    for (int i = 0; i < tail; i++) {
      int indexPos =(indexPosTail +i)%tail;

      for (int j = 0; j < currSize; j++) {

        pastLines[indexPos][j].show();
      }
    }

    //check LiveLine objects
    for (int i = 0; i < currSize; i++) {
      group[i].show();
    }
  }


  /*
  This method initializes the arrays of objects.
   It is called when the screen is refreshed
   to generate a new set of lines
   */
  void init() {

    //initializing LiveLine objects
    for (int i=0; i<currSize; i++) {
      group[i].init();
    }


    //initializing TailLine objects
    for (int i = 0; i < tail; i++) {

      for (int j = 0; j < currSize; j++) {

        pastLines[i][j] = new TailLine();
      }
      for (int j = currSize; j < maxSize; j++) {

        pastLines[i][j] = null;
      }
    }
  }

  /*
  This method switches between four programs with different number of lines
   the keyPressed() function in the main tab determines the program variable
   and calls this function when the appropriate buttons are pushed
   */
  void programChange(int program) {

    //the number of lies shown (currSize variable)
    //is varied according to the program variable
    switch (program) {

    case 0:
      currSize = 5;
      break;

    case 1:
      currSize = 10;
      break;

    case 2:
      currSize = 20;
      break;

    case 3:
      currSize = 50;
      break;
    }


    //initializing LiveLine objects according to currSize
    for (int i = 0; i < currSize; i ++) {
      group[i] = new LiveLine();
      group[i].init();
    }
    for (int i = currSize; i < maxSize; i ++) {
      group[i] = null;
    }


    //initializing TailLine objects according to currSize
    for (int i = 0; i < tail; i++) {

      for (int j = 0; j < currSize; j++) {

        pastLines[i][j] = new TailLine();
      }
      for (int j = currSize; j < maxSize; j++) {

        pastLines[i][j] = null;
      }
    }
  }


  /*
  This function determies if the tablet has been tapped
   and therefore wether or not the screen shpuld be initialized
   */
  void tabPressed() {

    //pressure is above the threshold (aboveThresh) for the first time
    //frmecount gets stored
    //function checks for the evolution of pressure over time (checking)
    if (tablet.getPressure() > lim && !checking) {
      currTime = int(frameCount);


      aboveThresh = true;
      checking = true;
    } 

    //after 15 frames, if the pressure is still above the threshold
    //the action will not considered tapping
    if ( currTime + 15 <= frameCount && tablet.getPressure() > lim && aboveThresh) {
      aboveThresh = false;
    }

    //after 15 frames, if the pressure has gone below the threshold, checking
    //mode is exited, whithout considering the lowering of the pressure a tap
    if ( currTime + 15 <= frameCount && tablet.getPressure() < lim && !aboveThresh) {
      checking = false;
    }

    // if after 5 frames, the pressure goes below the threshold, the action is
    // considered a tap 
    if ( currTime + 5 <= frameCount && tablet.getPressure() < lim && aboveThresh) { 

      aboveThresh = false;
      tap = true;
    }

    // a tap has been performed, a new set of lines is generated
    if (tap) {

      init();
      tap = false;
      checking = false;
    } else {
    }
  }
}
