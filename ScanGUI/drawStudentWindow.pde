//called by void draw .. the main process .. so this is refreshed constantly

void drawType(float x) {
  line(x, 50, x, 65);
  line(x, 150, x, 255);
  line(x, 425, x, height);
  
  fill(0);
  text("Howard Community College Engineering Seminar Fall 2014",30,40);
  shape(saveBoxShape, x, 290);
  text("SAVE",x+7,311);
  fill(255);
  text(name[Student], x, 95);
  photo = loadImage("data/barCode.png");
  image(photo,x+350,83);
  text(section[Student],x+450,95);
  
  text(attend[Student], x, 130); 
  //arrival status
  if (!attend[Student].equals("not here")) {
//        text(clicker[Student], x, 165);clicker status displayed on the screen
  }
  //leaving status
  if (!left[Student].equals("hasn't arrived yet")) {
     text(left[Student], x, 200);
  }
  if (hour()>=12) {
      hour12 = hour()-12;
      amPM = "pm";
  } else {
      hour12 = hour();
      amPM = "am";
  }
  if (minute()<10) {
     minTxt = "0"+str(minute());
  } else {
     minTxt = str(minute());
  }
  fill(51);
  text(hour12 + ":" + minTxt + " " + amPM + " " + monthName[month()] + " " + day(), x, 280);
  text(saved,x,340);
  text(EventActivity[iEventActivity],x,375);
  text(EventName[iEventName],x,410);
  File f = new File(dataPath(sis[Student]+".png"));
  if (f.exists()) { 
    photo = loadImage(sis[Student]+".png");
    image(photo,400,200);
  } else {
    photo = loadImage("data/noImage.png");
    image(photo,400,200);
  }

   fill(0);
   text(messages,x+10,500);
   text(scanNumbers,x+10,535);

}


