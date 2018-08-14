// Global Variables 
boolean error = false;
File root;
File selectedExport;

// Array memory alloc
int jsMaxLength = 100000;
int targetMaxLength = 60000;
int questionMaxAmt = 500;
int questionMaxLines = 100;

// question 2D array [question#] [line#]
String  qtJsData[][] = new String[questionMaxAmt] [questionMaxLines];

// target 1D array [line#]
String[] tJsData = new String[targetMaxLength];

String js[] = new String[jsMaxLength];
int jsCtx = 0;

String description = "";

PImage tempImage;
int uniqueImageId = 0;

int cQ = 1;