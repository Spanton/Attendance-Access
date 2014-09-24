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

void findLastName(int l1) {
  int i = 0;
  if (l1 > 96) {
    l1 = l1-32;
  }
  String letter = str(char(l1));
  while (i < NumStudents) {
    String firstChr = name[i];

    char c1 = firstChr.charAt(0); 
    println("c1 is  ."+c1+". letter is ."+letter+".");
    if (str(c1).equals(letter)) {
        Student = i;
        i = NumStudents;
    }
    i += 1;
  }
}

