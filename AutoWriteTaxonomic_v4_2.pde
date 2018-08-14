PFont bigJohn, axis, adam, arc, microui;
void setup() {
  size( 1500,1000 );

   bigJohn = loadFont("BigJohn-48.vlw");
   axis = loadFont("AXIS-ExtraBold-48.vlw");
   adam = loadFont("ADAM.CGPRO-48.vlw");
   arc = loadFont("Arciform-48.vlw");
   microui = loadFont("MicrosoftYaHeiUI-48.vlw");
   textFont(adam);
   
   qtJsData[0][0] = "hello world, is there a null?";
   println(qtJsData [0][0]);
   println(qtJsData[1].length);
   
   //selectFolder("Select a folder to process:", "folderSelected");
   rectMode(CENTER);
   textAlign(CENTER, CENTER);
   GUIsetup();
   
}

void draw() {
  if (queGenerate) {
    queGenerate=false;
    generateJS();
    b3.active = true;
  }
    
  background(#2A363B);
  GUI();
}