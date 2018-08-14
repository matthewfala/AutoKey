

void preWrite() {
   writejs("/* AUTO GENERATED JS CODE, GENERATOR BY MATTHEW FALA */");
   newline();
   newline();

   writejs("angular.module('starter.controllers')");
   newline();
   writejs(".factory('qSeed', function () {");
   newline();

   newline();
   writejs("    // Question Library // ng-repeat text // HTML on ng-click updateQ($index);");   
   newline();

}

void targetWrite(String tarName, String imgName, File location) {
  
  String name;
  String description;
  boolean simpleMode;
  
  File[] txts = getTxtFiles(location);
  // determine mode
  if (txts.length == 0) {
    simpleMode = true;
  }
  else simpleMode = false;
  
  if (simpleMode) {
    name = getFolderName(location);
    description = "";
  }
  else {
    name = getFileName(txts[0]);
    String[] descStored = loadStrings(txts[0]);
    description = arrayToString(descStored);
    description = specialCharReplace(description);
  }
  
  writeT("    var " + tarName + " = {");
  writeT("        target: " + char(34) + name + char(34) + ",");
  if (getImageFiles(location).length != 0) {
    writeT("        img: " + char(34) + "img/dichotomous/" + imgName + ".png" + char(34) + ",");
    
    imageConstrainHeight = imageConstrainHeightTarget; // HACK bad code
    saveScaleImage( location.getAbsolutePath(), selectedExport.getAbsolutePath() + char(92) + "www" + char(92) + "img" + char(92) + "dichotomous" + char(92) + imgName + ".png", getImageFiles(location)[0].getAbsolutePath());
  } 
  writeT("        description: " + char(34) + description + char(34) + ",");
  writeT("    };"); 
  newLnT();
}

// write questions, recursive
void questionWrite(int qNumber, File location) { 
  imageConstrainHeight = imageConstrainHeightQuestion; // HACK (bad code)
  
  File[] subDirs = listDirs(location);
 // nextQ = qNumber + 1;
  
  // write this q's data before moving on
  writeQT( qNumber, "    " + "var q" + qNumber + " = {" );
  
  // direct
  writeQT( qNumber, "        direct: [" );
  
  // use the current q, which might not be qNumber, for  routeQ, save increment for later.
  int trackQ = cQ + 1;
  int targetI = 0;
  for (int i = 0; i < subDirs.length; i++ ) {
    if (!dirTarget(subDirs[i])) {
      
      writeQT( qNumber, "            q" + trackQ + "," );
      trackQ++;
    }
    else {
      writeQT( qNumber, "            t" + qNumber + char(65 + targetI) + "," );
      targetI++;
    }
  }
  
  writeQT( qNumber, "        ]," );
  
  // text
  writeQT( qNumber, "        text: [");
  for (int i = 0; i < subDirs.length; i++) {
    writeQT( qNumber, "            " + char(34) + specialCharReplace( getFolderName(subDirs[i]) ) + char(34) + ",");
  }
  writeQT( qNumber, "        ]," );
  
  // image
  writeQT( qNumber, "        img: [" );  
  for (int i = 0; i < subDirs.length; i++) {
    
    if (getImageFiles(subDirs[i]).length == 0) {
//      msgBox("WARNING: No image in " + subDirs[i] + ". Replaced with blank holder.", "WARNING" );                                //////////////////////////////////////////////////////////////////
      writeQT( qNumber, "            " + char(34) + "img/dichotomous/" + "Empty"  + ".png" + char(34) + ",");
    }
    else if (getImageFiles(subDirs[i]).length > 0) {
      writeQT( qNumber, "            " + char(34) + "img/dichotomous/" + getFileName(getImageFiles(subDirs[i])[0])  + uniqueImageId + "_img.png" + char(34) + ",");
      packagePhoto(getImageFiles(subDirs[i])[0], getFileName(getImageFiles(subDirs[i])[0])  + uniqueImageId + "_img.png");
      uniqueImageId ++;
    }
    
    if (getImageFiles(subDirs[i]).length == 2) {
      msgBox("WARNING: More than one image in " + subDirs[i] + ". Using image " + getImageFiles(subDirs[i])[0], "WARNING");
    }
  }
  writeQT( qNumber, "        ]," );
  
  writeQT( qNumber, "    };" );
  
  // Remove objects we don't need (Same code as direct: [])
  trackQ = cQ + 1; // Question track
  targetI = 0; // ABC Track
  for (int i = 0; i < subDirs.length; i++ ) {
    if (!dirTarget(subDirs[i])) {
      
      writeQT( qNumber, "    q" + trackQ + " = null;" );
      trackQ++;    
    }
    else {
      writeQT( qNumber, "    t" + qNumber + char(65 + targetI) + " = null;" );
      targetI++;
    }
  }
  
  
  // Setup itteration
  int qI = 0;
  targetI = 0;
  int firstCInDir = cQ + 1;
  cQ = cQ + numOfQs(location); // increment before itterating
  
  if (!error) { // kill kids if error
    
    // Call itterations
    for (int i = 0; i < subDirs.length;  i++) {
      if (!error) {
        if (!dirTarget(subDirs[i])) {
          questionWrite(firstCInDir + qI, subDirs[i]);
          qI ++;
        }
        else {
          targetWrite("t" + qNumber + char(65 + targetI), str(qNumber) + char(65 + targetI), subDirs[i]);
          targetI++;
        }
      }
    }
  
  }
  
}