
void saveTransaction() {
  if (!running) {
  running = true;
  //make sure Attendance.csv exists
  String fileName = ("Attendance-"+monthName[month()] + "-" + day() + "_" + NumAttending +".csv");
  File f = new File(dataPath(fileName));
  if(!f.exists()){
    //creating new file with header if it doesn't exist
    output = createWriter("data/"+fileName);//creating output file using processing rather than java
    //output.println("Close this excel spreadsheet before entering more data. Failure to do this will result in the data being lost.");
    output.println("Name,ID,Section,Date,Time (1020 is 5pm),Description,EventDescription,EventActivity");//print header
    int i = 0;
    while (i < NumAttending) {
      output.println(transactions[i]);//saved individual transaction
      i = i+1;
    }
    output.flush();
    output.close();
    messages = ("created the "+fileName+" file");
    saved = ("last save was "+ NumAttending+" students");
    openExcel(fileName); 
    running = false;
  } else {
    messages = ("attempted save failed .. "+fileName+" already existed");
    running = false;
  }
 }
}

void openExcel(String fname) {
       String DEST_FILE = "data/Eprocess.bat";
       File dataFile = sketchFile(DEST_FILE);
       if (dataFile.exists()) {
           dataFile.delete(); // Returns false if it cannot do it
       }
 
      String excelPath = ("\"C:\\Program Files (x86)\\Microsoft Office\\Office14\\excel\" ");
      output = createWriter(DEST_FILE);//creating output file using processing       
      String pBat = "cd "+"\""+dataPath(".")+"\"";
      output.println(pBat);
      output.println(excelPath + " " + fname);
      output.println("exit");
      output.flush();
      output.close();
      pBat = "\""+dataPath("Eprocess.bat")+"\"";
      open(new String[] { "cmd", "/c", pBat});
}
