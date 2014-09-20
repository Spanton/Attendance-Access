//look up student ID in drop down list and select
//returns true if successful, false if could not find student, or scanlength is not that of an ID

boolean findStudent() {
  //check scanner length to see if ID
   if (keyIn.length() == idLength) {
     //find student
     int i = 0;
     int j=0;
     // println ("here searching for "+ scannerString + " number of students is " +NumStudents);
     while (i < NumStudents) {
         if (sis[i].equals(keyIn)) {
           j = i;
           i = NumStudents;
         } else {
           i = i+1;
         }
     }
     if (j == 0) {
        messages = "ID not found, try scanning again";
        return(false);
     } else {
       //student id was found
       Student = j;
       return(true);
     }
   } else {
     messages = "Bad Scan .. Try Again";
     return(false);
   }   
}
