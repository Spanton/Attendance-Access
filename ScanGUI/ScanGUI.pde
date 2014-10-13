import java.io.InputStreamReader;//used to print the bar codes
import processing.pdf.*;//used to create a hidden sketch that is drawn on and automatically saved as pdf

//variables used in cvsProcess
Table table;
String[] sis = new String[1024];//used to hold student id's
String[] name = new String[1024];//used to hold student's names
String[] section = new String[1024];//used to hold student's sections
String[] attend = new String[1024];//used to hold student id's of those currently attending the live event
String[] clicker = new String[1024];//text describing clicker event .. checked out, checked back in
String[] clickerScan = new String[1024];//actual clicker number assigned when checked out, searched when checked in .. see recordClicker
String[] monthName = new String[13];
String[] left = new String[1024];//text describing left event .. for display in Student Window
String[] leftScan = new String[1024];//used to check if student has already left and is being scanned twice .. recording first left only
String[] EventName = {"Seminar","Class","SWE","W3HCC","E-Club","NSBE"};
int iEventName = 0;
int maxEventName = 6;
String[] EventActivity = {"Arriving","Entering","Leaving","Arriving and Clicker","Clicker","Clicker Return"};
int maxEventActivity = 6;
int iEventActivity =0;

int NumStudents = 0;
int NumAttending = 0;
int idLength = 7; //length of the sis (student id code) coming from canvas
String keyIn = ""; // used to capture keyboard/scanner input .. must start with a space to keep processing happy

//variables used in drawStudentWindow
PImage photo;
int hour12 = 0;
String amPM = "am";
String minTxt;//minute text ... need to pad minutes 0-9 with a leading zero
String messages = "No messages yet";//message of either not scanned=  successful scan or already scanned
String scanNumbers;//message of total students and number scanned
int Student = 0; // student sequential number in the arrays
PFont f;
PFont fprint;
PFont barCodeFont;
PrintWriter output;
Boolean running = false;
String[] transactions = new String[1024];//array of csv formatted transactions to be dumped into a file
String saved = "Have not saved any students";// so displays the last attendance file name saved

//setting up for hot spots and pop ups
PShape saveBoxShape;  // The PShape object
Boolean overSaveBox = false;
Boolean tfEventName = false;
Boolean tfEventActivity = false;
Boolean tfPrintStudent = false;
Boolean tfPrintSection = false;
Boolean tfLockUnLock = false;

PShape helpBoxShape; // The help box, never over it
int mXt = 3 ; // mouse over help tail X offset
int mYt = 35; // mouse over help tail Y offset
PShape lock; //locked section icon
PShape unLock; //unlocked section icon
Boolean locked = false;

public void setup(){
  size(800,600, P2D);
//  printArray(PFont.list());
  f = createFont("Georgia", 24);
  fprint = createFont("Georgia", 12);
  barCodeFont = createFont("IDAutomationHC39M",14);//use 8 for laser printer, 10 for inkjet (minimums)
  textFont(f);
  monthName[1] = "Jan";monthName[2] ="Feb";monthName[3]="March";monthName[4]="April";monthName[5]="May";monthName[6]="June";monthName[7]="July";monthName[8]="August";monthName[9]="Sept";monthName[10]="Oct";monthName[11]="Nov";monthName[12]="Dec";
  cvsProcess();
// setting up for hot spots and pop ups  
  saveBoxShape = createShape(RECT, 0, 0, 75, 25);
  saveBoxShape.setFill(color(255, 255, 255));
  saveBoxShape.setStroke(true);
  strokeWeight(2);
  helpBoxShape = createShape(RECT, 0,0,200,20);
  helpBoxShape.setFill(color(255, 128, 255));
  helpBoxShape.setStroke(false);
  lock = loadShape("data/lock.svg");
  unLock = loadShape("data/unLock.svg");
}


public void draw(){
  background(102);
  textAlign(LEFT);
  drawType(width * 0.10);//the function drawType is in drawStudentWindow tab
// determining if mouse is over hot spot
  if (mouseX > 80 && mouseX <155 && //checking to see if mouse is over the save button
      mouseY > 290 && mouseY < 315) {
      overSaveBox = true; 
      shape(helpBoxShape, mouseX, mouseY+20);
      textFont(fprint);
      text("click to record current attendance",mouseX+mXt,mouseY+mYt);
      textFont(f);
  } else {
      overSaveBox = false;
  }
  if (mouseX > 400 && mouseX <600 && //checking to see if mouse is over the student image and pixel color underneath has changed
      mouseY > 200 && mouseY < 450
      && get(mouseX,mouseY)!=-10066330 ) {
      shape(helpBoxShape, mouseX, mouseY+20);
      textFont(fprint);
      text("click for new image",mouseX+mXt,mouseY+mYt);
      textFont(f);
   }
   if (mouseX > 430 && mouseX <501 && //checking to see if mouse is over the student barcode
      mouseY > 83 && mouseY < 96) {
      shape(helpBoxShape, mouseX, mouseY+20);
      textFont(fprint);
      text("click to print student bar code",mouseX+mXt,mouseY+mYt);
      textFont(f);
      tfPrintStudent = true;
   } else {
     tfPrintStudent = false;
   } 
   if (mouseX > 530 && mouseX <570 && //checking to see if mouse is over the section
      mouseY > 78 && mouseY < 100) {
      shape(helpBoxShape, mouseX, mouseY+20);
      textFont(fprint);
      text("click to print section's bar code",mouseX+mXt,mouseY+mYt);
      textFont(f);
      tfPrintSection = false;
   } else {
      tfPrintSection = false;
   }
   if (mouseX > 580 && mouseX <610 && //checking to see if mouse is over the lock icon
      mouseY > 78 && mouseY < 100) {
      shape(helpBoxShape, mouseX, mouseY+20);
      textFont(fprint);
      text("toggle lock/unlock section",mouseX+mXt,mouseY+mYt);
      textFont(f);
      tfLockUnLock = true;
   } else {
      tfLockUnLock = false;   
   }   
   if (mouseX > 75 && mouseX <250 && //checking to see if mouse is over event activity
      mouseY > 340 && mouseY < 375) {
      shape(helpBoxShape, mouseX, mouseY+20);
      textFont(fprint);
      text("click to scroll through activities",mouseX+mXt,mouseY+mYt);
      textFont(f);
      tfEventActivity=true;
   } else {
      tfEventActivity=false;
   }
   if (mouseX > 75 && mouseX <200 && //checking to see if mouse is over the event name
      mouseY > 385 && mouseY < 410) {
      shape(helpBoxShape, mouseX, mouseY+20);
      textFont(fprint);
      text("click to scroll through events",mouseX+mXt,mouseY+mYt);
      textFont(f);
      tfEventName=true;
   } else {
      tfEventName=false;
   }
}

void mousePressed() { //do something associated with hot spot
  if(overSaveBox) { 
     saveTransaction();
  }
  if(tfEventActivity) {
     iEventActivity = iEventActivity + 1;
     if (iEventActivity == maxEventActivity) {
         iEventActivity = 0;
     }
  }
  if(tfEventName) {
     iEventName = iEventName + 1;
     if (iEventName == maxEventName) {
         iEventName = 0;
     }
  }
  if(tfPrintSection) {
        printSectionBarCode(0,0);
  }
  if(tfPrintStudent) {
        printBarCode();
  }
  if(tfLockUnLock) {
    if (locked) {
        locked = false;
    } else {
        locked = true;
    }
  }
}

void keyPressed() {
  if (key == 32) {
     recordAttendance();     
  } else { 
      if (key == CODED) {
        if (keyCode == DOWN) {
          String s = section[Student];
          if (Student < NumStudents-1) {
            Student = Student+1;
          } else {
            Student = 0;
          }
          if (locked) {
            while (!(section[Student].equals(s))){
              if (Student < NumStudents-1) {
                Student = Student+1;
              } else {
                Student = 0;
              }
            }
          }           
        } else if (keyCode == UP) {
          String s = section[Student];
          if (Student == 0) {
            Student = NumStudents-1;
          } else {
            Student = Student -1;
          }
          if (locked) {
            while (!(section[Student].equals(s))){
              if (Student == 0) {
                Student = NumStudents-1;
              } else {
                Student = Student -1;
              }
            }
          }                 
        }
      } else {
        if (key == RETURN || key == ENTER) {
          if (findStudent()) {
              recordAttendance();
          }
          keyIn = null;
        } else {
          if (keyIn == null) {
               keyIn = str(key);
          } else {
               if (key > 63) {
                    findLastName(key);     
                } else {
                   keyIn += key;
                }
          }
        }
      }
  }
}
