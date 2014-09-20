//this function loads up global variables sis, name and section while building a drop down list
//is run once during startup
//of students that mirrors this data ... the same index number identifies everyone
//this does not create the attendance.csv file ... it requires roster.csv to be in the data directory
//it ignores the first two lines of the roster.csv file and looks for column headings of ID, Student and Section
//it expects the section to be in the year-ENES-100-501 format ... and picks out just the 501

void cvsProcess() {
  int i=0; //is going to count rows in roster.csv
  table = loadTable("roster.csv", "header");//roster.csv is downloaded from canvas gradebook course megasite

  for (TableRow row : table.rows()) {
    int j; // is going to count rows of students, skipping header, second line and hopefully default, test students
    if (i>0) {
      if (!(row.getString("Student").equals("Student, Test"))) {
        j = i-1;
        sis[j] = row.getString("ID");//using only three columns of canvas gradebook
        name[j] = row.getString("Student");
        String[] q = split(row.getString("Section"),'-');
        section[j] = q[3];//hcc naming convention is 2013-ENES-100-501, want just the section 501
        attend[j] = "not here";
        clicker[j] = "no clicker";
        left[j] = "hasn't arrived yet";
        clickerScan[j] = " ";
        leftScan[j] = " ";
        
        while (sis[j].length() < 7) {
            sis[j] = "0" + sis[j];//canvas strips leading zero's off the student's sis, so putting back on
        }
//        println(j + " " + sis[j] + " " + name[j]  + " " + section[j]);//debugging line
      }
    }
    i++;
  }
  clickerScan[51] = " ";
  clickerScan[52] = " ";
  NumStudents = i-2;
  scanNumbers = ("Total Attending 0/"+NumStudents);
  loadAttendance();
}

void loadAttendance() {
  //loads up attendance back into the state variables .. attend, clicker, left, clickerScan, leftScan
   File f = new File(dataPath("Attendance.csv"));
  if(f.exists()){
    int i=0; //is going to count rows in roster.csv
    String searchDate = (month()+"/"+day()+"/"+year());
//    searchDate = ("6/30/2014");//choose this to look at a previous date
    table = loadTable("Attendance.csv", "header");//roster.csv is downloaded from canvas gradebook course megasite 
    for (TableRow row : table.rows()) {
      try{
        String checkDate = row.getString("Date");
        if (checkDate.equals(searchDate)) {//if the date is todays, then load
          String ID = row.getString("ID");//find i value that matches this ID in the sis[] array
          while (ID.length()<idLength) {
            ID = " "+ID;
          }
          i=0;
          while (ID.length() < idLength) {
              ID = "0"+ID;
          }
          while (i<NumStudents) {//go through list, stop when find matching ID
//           println("ID is "+ID+"ID length"+ID.length()+" sis is "+sis[i]);
             if (sis[i].equals(ID)) {
               if ((row.getString("ClickerNumber").length()>1)&&(!(row.getString("Activity").equals("Leaving")))) {
                  clickerScan[i] = row.getString("ClickerNumber");
                  clicker[i] = row.getString("Description");
               } 
               if (row.getString("Activity").equals("Leaving")) {
                 left[i] = row.getString("Description");
                 NumAttending = NumAttending - 1;
                 leftScan[i] = "Left";
                 scanNumbers = ("Total Attending "+NumAttending+"/"+NumStudents);
               }
               if ((row.getString("Activity").equals("Arriving & Clicker") && (row.getString("ClickerNumber").length() == 1)) || row.getString("Activity").equals("Arriving")) {
                 attend[i] = row.getString("Description");
               }
               if ((row.getString("Activity").equals("Arriving & Clicker")) || (row.getString("Activity").equals("Arriving"))) {
                 if (clickerScan[i].length()>1) {
                   NumAttending = NumAttending +1;
                 }
                 scanNumbers=("Total Attending "+NumAttending+"/"+NumStudents);                
               }
               if (row.getString("Activity").equals("Question Evaluation")) {
                  clicker[i] = "no clicker and out out out";
               }              
              }
              i++;
          }
        }
      } catch (NullPointerException npe) {
//        println("have reached end of file"); 
      }
    }
  }
}  

