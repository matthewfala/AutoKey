
String Client = "Dr. Faucci";
int version = 4;
int revision = 0;

int imageConstrainWidth = 0; //px
int imageConstrainHeight = 800; //px

// Image Constrain Hack (Bad Code)
int imageConstrainHeightQuestion = 300; //px
int imageConstrainHeightTarget = 500; //px

specialChar[] charReplacements = new specialChar[] {
  new specialChar("..", ":"),
  new specialChar("~Q", "?"),
  new specialChar("~#", "*"),
  new specialChar("~B", "/"),
  new specialChar("\"", "\\\""),

};


class specialChar {
  String biChar, corChar;
  specialChar(String tempBi, String tempChar) {
    biChar = tempBi;
    corChar = tempChar;
  }
}