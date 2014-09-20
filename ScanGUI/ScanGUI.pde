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
PrintWriter output;
PShape square;  // The PShape object
Boolean running = false;
Boolean overBox = false;
String[] transactions = new String[1024];//array of csv formatted transactions to be dumped into a file
String saved = "Have not saved any students";// so displays the last attendance file name saved

public void setup(){
  size(800,600, P2D);
//  printArray(PFont.list());
  f = createFont("Georgia", 24);
  fprint = createFont("Georgia", 6);
  textFont(f);
  monthName[1] = "Jan";monthName[2] ="Feb";monthName[3]="March";monthName[4]="April";monthName[5]="May";monthName[6]="June";monthName[7]="July";monthName[8]="August";monthName[9]="Sept";monthName[10]="Oct";monthName[11]="Nov";monthName[12]="Dec";
  cvsProcess();  
  square = createShape(RECT, 0, 0, 75, 25);
  square.setFill(color(255, 255, 255));
  square.setStroke(true);
  strokeWeight(2);
}


public void draw(){
  background(102);
  textAlign(LEFT);
  drawType(width * 0.10);//function is in drawStudentWindow tab
  if (mouseX > 80 && mouseX <155 && 
      mouseY > 290 && mouseY < 315) {
      overBox = true; 
   }
}

void mousePressed() {
  if(overBox) { 
     saveTransaction();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (Student < NumStudents-1) {
        Student = Student+1;
      } else {
        Student = 0;
      }
    } else if (keyCode == DOWN) {
      if (Student == 0) {
        Student = NumStudents-1;
      } else {
        Student = Student -1;
      }
    } 
  } else {
    if (key == 32) {
      recordAttendance();
    }
    if (key == RETURN || key == ENTER) {
      if (findStudent()) {
          recordAttendance();
      }
      keyIn = null;
    } else {
      if (keyIn == null) {
           // keyIn = key; doesn't work .. generates message can not convert to a string from ... why?
           keyIn = str(key);
           keyIn = trim(keyIn); //doesn't work here .. but does work below ... why?
      } else {
           keyIn += key;
//           keyIn = trim(keyIn);//now this will clip any leading space someone tries to type in the future and look like a bug if this code is reused ... is there another solution?
      }
    }
  }
}
