void printBarCode() {
/*  String ff = "output-"+millis()+".pdf";
  PGraphics pdf = createGraphics(300, 300, PDF, "data\\"+ff);
  pdf.beginDraw();
  pdf.fill(0);
  pdf.textFont(barCodeFont);
  pdf.text("*"+sis[Student]+"*", 5, 150);
  pdf.textFont(fprint);
  pdf.text(name[Student], 78, 150);
  pdf.dispose();
  pdf.endDraw();
  pdfPrint(ff);
  //println("here");
  messages = ("Have printed "+name[Student]+"'s barcode");
*/}

void printSectionBarCode(int i, int pagePrint) {
/*  String ff = "output-"+millis()+".pdf";
  PGraphics pdf = createGraphics(300,1000, PDF, "data\\"+ff);
  pdf.beginDraw();
  pdf.fill(0);
  pdf.textFont(barCodeFont);
  int j=0;
  String ID = section[Student];
  while (i<NumStudents) {
      if (section[i].equals(ID)) {
          pdf.textFont(barCodeFont);
          pdf.text("*"+sis[i]+"*", 0, 170 + 60*j);
          pdf.textFont(fprint);
          pdf.text(name[i], 123, 170+60*j);
          j = j+1;
      }
      i = i+1;
//recursive stuff to print multiple pdf pages 
//print("j = "+j+"    ");
      if ((j - pagePrint*12) == 12) {
         pagePrint = pagePrint+1;
//println("recursing .. j is "+j+" and pagePrint is "+pagePrint);
         printSectionBarCode(i, pagePrint);
         i = NumStudents;
      }
//println("finished recursing .. j is "+j+" and pagePrint is "+pagePrint);
  }
  pdf.dispose();
  pdf.endDraw();
  pdfPrint(ff);
  messages = ("Have printed section's "+ID+" barcodes");
*/}

void pdfPrint(String ff) {
/*  String dOutput = dataPath(ff);
  println(dOutput);
  String params[] = {"\"C:\\Program Files (x86)\\Foxit Software\\Foxit Reader\\Foxit Reader.exe\"", "/p", dOutput };
  println(params);
  try {
    Process p = Runtime.getRuntime().exec(params);
    BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
    String line;
    while ( (line = input.readLine ()) != null) {
      println(line);
    }
    input.close();
  }
  catch(Exception e) {
    println(e);
  }
  println(params);
  println("del " + dOutput);
  open("del " + dOutput);
*/}
