
void clearData() {
  // question 2D array [question#] [line#]
  qtJsData = null;
  qtJsData = new String[questionMaxAmt] [questionMaxLines];

  tJsData = null;
  // target 1D array [line#]
  tJsData = new String[targetMaxLength];

  js = null;

  js = new String[jsMaxLength];
  jsCtx = 0;
  
  cQ = 1;
  uniqueImageId = 0;
  
  error = false;

}

// qtJsData line 0 is for current line record
void writeQT(int question, String txt){
  if (!error) {
    int line; // lossy?
    
    if (question >= qtJsData.length) {
      msgBox("ERROR: Memory allocation issue, key questions excedes max, " + qtJsData + " questions", "Error");
      error = true;
      return;
    }
    // create record
    if (qtJsData[question][0] == null)
    {
      qtJsData[question][0] = str(1);
      qtJsData[question][1] = ""; // format line 1
    }
    
    // write on record line
    line = Integer.parseInt( qtJsData[question][0] ); //test
    qtJsData[question][line] = qtJsData[question][line] + txt;
    
    newLnQT(question); //Remove to not auto indent;
  }
}

void newLnQT(int question) {
  int newLine = Integer.parseInt( qtJsData[question][0] ) + 1;
  String newLineString = str(newLine);
  
  if (!error) {
    if (newLine < qtJsData[question].length) {
      qtJsData[question][0] = newLineString;
      qtJsData[question][newLine] = ""; // format new line
    }
    else {
      
      msgBox("ERROR: Memory allocation error, question " + question + " excedes max " + qtJsData[question].length + "lines", "Error");
      error = true;
    }
  }
}

void writeT(String txt) {
  int line; // lossy?
  
  // create record
  if (tJsData[0] == null)
  {
    tJsData[0] = str(1);     
    tJsData[1] = "";
  }
  // wite on record line
  line = Integer.parseInt( tJsData[0] );
  tJsData[line] = tJsData[line] + txt;
  
  newLnT();
}

void newLnT() {
  if (!error) {
    int newLine = Integer.parseInt( tJsData[0] ) + 1;
    if (newLine < tJsData.length) {
      String newLineString = str(newLine);
      tJsData[0] = newLineString;
      tJsData[newLine] = "";
    }
    else {
      msgBox("ERROR: Memory allocation error. Target text exceeds" + tJsData.length + " lines", "Error");
      error = true;
    }
  }
}

void packageQTinJS(){
  //pre Text
  preWrite();
  
  // Target Pre-Text
  for( int i = 1; i < tJsData.length-1; i++) {
    if (tJsData[i] != null ) {
      writejs(tJsData[i]);
      newline();
    }
  }
  
  // Write all questions backwards
  for( int i = qtJsData.length - 2; i >= 1; i-- ) {
    if (qtJsData[i][0] != null) {
      
      // Parse all question lines
      for ( int z = 1; z < qtJsData[i].length -1; z++ ) {
        if (qtJsData[i][z] != null) {
          writejs(qtJsData[i][z]);
          newline();
        }
      }
      
      newline();
    }
  }
  
  // Minor post-text
  newline();
  writejs("    return q1;");
  newline();
  writejs("})");
  
}

void writejs(String txt){
  if (js[jsCtx] == null ) {
    js[jsCtx] = "";
  }
  
  js[jsCtx] = js[jsCtx] + txt;
}


void newline() {
  if ( jsCtx < js.length-1 ) {
    jsCtx ++;
    js[jsCtx] = "";
  }
  else {
    if (!error) {
      msgBox("ERROR: JS array memory allocation error. Key excedes " + js.length + " lines.", "Error");
      error = true;
    }
  }
}

void fileJS(String[] myJS) {
  int saveSize = 0;
  print(myJS.length);
  for (int i = 0; i < myJS.length; i++) {
    if( myJS[i] != null ) {
      saveSize++;
    }
  }
  
  String[] saveFile = new String[saveSize];
  for (int i = 0; i < myJS.length; i++) {
    if( myJS[i] != null ) {
      saveFile[i] = myJS[i];
    }
  } //<>// //<>//
  
  saveStrings(selectedExport + "/www/js/dichotomous_Questions.js", saveFile);
}