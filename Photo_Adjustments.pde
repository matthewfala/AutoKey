
void packagePhoto(File fLocation, String name){
  String location = fLocation.getAbsolutePath();
  saveScaleImage( location, selectedExport.getAbsolutePath() + char(92) + "www" + char(92) + "img" + char(92) + "dichotomous" + char(92) + name, location);
}