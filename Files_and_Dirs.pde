


File returnExt(String ext, File fLocation) {
  String location = fLocation.getAbsolutePath();
  int counter = 0;
  File extFile = new File("c:\\garbage.txt");
  File[] files = listFiles(location);
  for ( int i = 0; i < files.length; i++ ) {
     if (getFileExt(files[i]).equals(ext)) {
       if (counter == 0) {
         extFile = files[i];
         counter++;
       }
       else {
         msgBox("Warning: Directory " + location + " contains multiple " + ext + " files. Each taxonomic folder must contain only 1 ", "Warning" );
         //exit();
       }
     }
  }
  
  if (extFile.getAbsolutePath() == "c:\\garbage.txt" ) {
    msgBox("ERROR: No " + ext + " file in " + location + ".", "Error");
    error = true;
    return extFile;
  }
  
  return extFile;
}


File[] listDirs(File fLocation) {
  String location = fLocation.getAbsolutePath();
  int counter = 0;
  java.io.File dir = new java.io.File(location); 
  File[] files = dir.listFiles();
  
  
  for (int i = 0; i < files.length; i++) {
    if (files[i] == null) {
      error = true;
    }
    else {
      if (files[i].isDirectory()) {
        counter++;
      }
    }
  }
  
  
  // create dir array
  File[] dirArray = new File[counter];
  int z = 0;
  for (int i = 0; i < files.length; i++) {
    if (files[i].isDirectory()) {
      dirArray[z] = files[i];
      z++;
    }
  }
  
  return dirArray;
}

File[] listFiles(File fLocation) {
  String location = fLocation.getAbsolutePath();
  
  int counter = 0;
  java.io.File dir = new java.io.File(location); 
  File[] files = dir.listFiles();
  for (int i = 0; i < files.length; i++) {
    if (!files[i].isDirectory()) {
      counter++;
    }
  }
  
  // create dir array
  File[] fileArray = new File[counter];
  int z = 0;
  for (int i = 0; i < files.length; i++) {
    if (!files[i].isDirectory()) {
      fileArray[z] = files[i];
      z++;
    }
  }
  
  return fileArray;
}

String getFileExt(File file) {
  String fileSt = file.getAbsolutePath();
  
  String ext = "";
  for (int i = 0; i < fileSt.length(); i++) {
    ext = ext +  fileSt.charAt(i);
    if ( int(fileSt.charAt(i)) ==  int('.')) {
      ext = "";
    }
  }
  
  return ext;
}

String getFolderName(File fDir) {
  String dir = fDir.getAbsolutePath();
  
  String folderName = "";
  for (int i = 0; i < dir.length(); i++) {
     folderName = folderName + dir.charAt(i);
     if (int(dir.charAt(i)) == 92) {
       folderName = "";
     }
  }
  
  return folderName;
}

String getFileName(File fFile) {
  String file = fFile.getAbsolutePath();
/*
  String fileName = "";
  for (int i = 0; i < file.length() && file.charAt(i) != '.'; i++) {
     fileName = fileName + file.charAt(i);
     if (int(file.charAt(i)) == 92) {
       fileName = "";
     }
  }
  */
  boolean extRemoved = false;
  String reversed = "";
  for (int i = file.length() - 1; i >= 0 && file.charAt(i) != char(92) && file.charAt(i) != char(47); i--) {
     reversed = reversed + file.charAt(i);
     
     if (!extRemoved && file.charAt(i) == '.') {
         reversed = "";
         extRemoved = true;
     }
  }
  
  String fileName = "";
  for (int i = reversed.length() - 1; i >= 0; i--) {
    fileName = fileName + reversed.charAt(i);
  }
  return fileName;
}

File[] getImageFiles(File fLocation) {
  String location = fLocation.getAbsolutePath();
  File[] files = listFiles(location);
  
  int z = 0;
  for (int i = 0; i < files.length; i++) {
    if (getFileExt(files[i]).equals("png") || getFileExt(files[i]).equals("jpg") || getFileExt(files[i]).equals("PNG") || getFileExt(files[i]).equals("JPG")) {
      z++;
    }
  }
  
  File[] imgs = new File[z];
  
  z = 0;
  for (int i = 0; i < files.length; i++) {
    if (getFileExt(files[i]).equals("png") || getFileExt(files[i]).equals("jpg") || getFileExt(files[i]).equals("PNG") || getFileExt(files[i]).equals("JPG")) {
      imgs[z] = files[i];
      z++;
    }
  }
  
  return imgs;
}

File[] getTxtFiles(File fLocation) {
  String location = fLocation.getAbsolutePath();
  File[] files = listFiles(location);
  
  int z = 0;
  for (int i = 0; i < files.length; i++) {
    if (getFileExt(files[i]).equals("txt")) {
      z++;
    }
  }
  
  File[] txts = new File[z];
  
  z = 0;
  for (int i = 0; i < files.length; i++) {
    if (getFileExt(files[i]).equals("txt")) {
      txts[z] = files[i];
      z++;
    }
  }
  
  return txts;
}

String getTextForGUI(File file) {
  if (file == null) {
    return "Select file";
  }
  else {
  return file.getAbsolutePath(); 
  }
}