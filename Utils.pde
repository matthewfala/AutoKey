void msgBox( String Msg, String Title ){

 javax.swing.JOptionPane.showMessageDialog ( null, Msg, Title, javax.swing.JOptionPane.INFORMATION_MESSAGE  );
 
}

boolean dirTarget(File location) {
  // no sub dirs -> target
  if  (listDirs(location).length == 0) {
    return true;
  }
  else {
    return false;
  }
}

String arrayToString(String[] array) {
  String condensed = "";
  for (int i = 0; i < array.length; i++) {
    if (!condensed.equals("") && !array[i].equals("")) {
      println(array[i]);
      if (condensed.charAt(condensed.length() - 1) != ' ' && array[i].charAt(0) != ' ') {
        condensed = condensed + ' ';     
      }  
    }
    condensed = condensed + array[i];
  }
  
  return condensed;
}

String specialCharReplace(String uncorrected) {
  String output = "";
  String moChar = "";
  String biChar = "";
  String charCor = "";
  for (int i = 0; i < uncorrected.length() - 1; i++) {
    moChar = "" + uncorrected.charAt(i);
    biChar = "" + uncorrected.charAt(i) + uncorrected.charAt(i+1);
    charCor = "" + uncorrected.charAt(i);
    
    for (int c = 0; c < charReplacements.length; c++) {
      
      // check single char correction
      if (moChar.equals(charReplacements[c].biChar)) {
        charCor = charReplacements[c].corChar;
      }
      
      // check double char correction
      else if (biChar.equals(charReplacements[c].biChar)) {
        charCor = charReplacements[c].corChar;
        i++; // skip the biChar
      }
      
    }
    output = output + charCor;   
  }
  
  if( uncorrected.length() > 0) {
    
    // check to see if a final biChar was replaced
    biChar = "" + uncorrected.charAt(uncorrected.length()-2) + uncorrected.charAt(uncorrected.length()-1);
    boolean lastCharCor = false;
    for (int c = 0; c < charReplacements.length; c++) {
      if (biChar.equals(charReplacements[c].biChar)) {
          lastCharCor = true;
      }
    }
    
    // replace if last biChar is not corrected.
    if (!lastCharCor) {
      output = output + uncorrected.charAt(uncorrected.length()-1);
    }
    
  }
  
  return output;
}
  
  
int numOfQs(File fLocation) {
  String location = fLocation.getAbsolutePath();
  int numQs = 0;
  File[] dirList = listDirs(fLocation);
  
  for (int i = 0; i < dirList.length; i++) {
    if (listDirs(dirList[i]).length > 0) {
      numQs ++;
    }
  }
  
  return numQs;
}

void saveScaleImage(String locationFrom, String locationTo, String fileName) {
  PImage resizable = loadImage(fileName);
  if (imageConstrainWidth != 0) {
    resizable.resize(imageConstrainWidth, resizable.height * imageConstrainWidth/resizable.width);
    println("new image Size: " + imageConstrainWidth + " by " + resizable.height * imageConstrainWidth/resizable.width);
  }
  else if (imageConstrainHeight != 0) {
    resizable.resize(resizable.width * imageConstrainHeight/resizable.height, imageConstrainHeight);
    println("new image Size: " + imageConstrainHeight + " x " + resizable.width * imageConstrainHeight/resizable.height);
  }
  resizable.save(locationTo);
}