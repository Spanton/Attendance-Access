//record attendance of current ID selected in drop down
//called by processEvent several times
//can see something very similar in processEvent .. for leaving .. 
//returns false if ID has already been scanned

void recordAttendance() {
  //println("recording attendance");
  if (attend[Student].equals("not here")) {
     int minTotal = hour()*60 + minute();
     attend[Student] = "Arrived " +hour12 + ":" + minTxt + " " + amPM + " " + monthName[month()] + " " + day();
     messages = "Successful ID Scan .. marked arrived .. ready to scan another";
     String attendanceTransaction = "\"" + name[Student] + "\",\"" + sis[Student] + "\",\"" + section[Student] + "\",\"" + month()+"/"+day()+"/"+year() + "\"," + minTotal + ",\"" + attend[Student] + "\",\"" + EventName[iEventName] + "\",\"" + EventActivity[iEventActivity] + "\"";
     transactions[NumAttending] = attendanceTransaction;
     NumAttending = NumAttending +1;
     scanNumbers = ("Total Attending "+NumAttending+"/"+NumStudents);
  } else {
     messages = "Has already been scanned, please scan ID";
  }    
} 
