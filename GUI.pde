button b1, b2, b3, b4;
String doneText = "";
void GUIsetup() {
    b1 =  new button("Import", width/3 - 4, height/10 * 6 - height/5 - 15, width * 1/3 - 8, height / 7 , 1);
    b2 =  new button("Export", width * 2/3 + 4, height/10 * 6 - height/5 - 15, width * 1/3 - 8, height / 7 , 2);
    b3 =  new button("Generate JS", width/2, height/5 * 4 - height/5, width * 2/3, height / 4 , 3);
    b3.staticColor = #656D78;
    b3.activeColor = #48CFAD;
    b3.active = false;
    
    b4 = new button("X", width/15, height - width/15, width/10, width/10, 4);
    b4.activeColor = #DA4453;
    b4.clickColor = #ED5565;
    b4.rounding = 50;
    b4.font = axis;
}
void GUI() {
  title();
  if (!b1.active && !b2.active) b3.active = true;
  else b3.active = false;
  b1.update();
  b1.render();
  b2.update();
  b2.render();
  b3.update();
  b3.render();
  b4.update();
  b4.render();
 
  textFont(microui);
  textSize(height/40);

  text("Import Location: " + getTextForGUI(root), width/2, height - height/6 - height/20);
  text("Export Location: " + getTextForGUI(selectedExport), width/2, height - height/6);  
  text(doneText, width/2, height - height/6  + height/20);  
  
  author();
}

void author() {
  textFont(adam);
  textAlign(RIGHT, BOTTOM);
  textSize(height/35);
//  fill(#E84A5F);
  text("2017, Fala Labs", width-width/50, height - height/45);
  textAlign(CENTER, CENTER);
}
void title() {

  textFont(adam);
  
 // stroke(#AAB2BD);
  //fill(#656D78);
  fill(#E84A5F);
  textSize(height/ 24);
  text("v" + version + "." + revision, width/2, height/8);
  
  fill(#E84A5F);
  textSize(height/ 12);
  text("AutoKey", width/2, height/8 +  height / 12); 
}


boolean queGenerate = false;
class button {
  int x, y, bWidth, bHeight, newPhase, id;
  color hex;
  String bText;
  boolean active = true;
  
  color activeColor = #99B898;
  color staticColor = #FF847C;
  color clickColor = #AAB2BD;
  
  int rounding = 7;
  PFont font = adam;
  
  
  button(String tText, int tx, int ty, int tbWidth, int tbHeight, int tId) {
    bText = tText;
    x = tx;
    y = ty;
    bWidth = tbWidth;
    bHeight = tbHeight;
    id = tId;
  }
  
  void render() {

    textFont(font);
    fill(hex);
    stroke(hex);
    rect(x, y, bWidth, bHeight, rounding);
    textSize(height/15);
    stroke(255);
    fill(255);
    fill(#E6E9ED);
    text(bText, x, y); //x + bWidth/7, y + bHeight/3 * 2);
    if (active) {
      hex = activeColor;
    }
    else {
      hex = staticColor;
    }
    
  }
  
  boolean refreshButton = false;
  void update() {
    
    if ( (mousePressed && (mouseButton == LEFT ) )
    && (mouseX < (x + .5 * bWidth) && mouseX > x - .5 * bWidth) 
    && (mouseY < (y + .5 * bHeight) && mouseY > y - .5 * bHeight) ){
      hex = clickColor;
      if (!refreshButton){ //deactivate if needs refresh
           refreshButton = true;
           if (active) {
                 if (id == 1) {
                   mouseX = 0;
                   mouseY = 0;
                   active = false;
                   selectFolder("Import a dichotomous key folder:", "setRoot");
  
                 }
                 else if (id == 2) {
                   mouseX = 0;
                   mouseY = 0;
                   active = false;
                   selectFolder("Select export location:", "setExport");
                   
                 }
                 else if (id == 3) {
                   if (!b1.active && !b2.active) {
                     active = false;
                     render();
                     queGenerate = true;
                   }
                   else {
                      msgBox( "Please select import dichotomous key, and export location", "Prompt");
                   }
                 }
                 
                 else if (id == 4) {    
                   cancilSelection();
                   
                 }
                 
           }
           else {
             hex = #FECEAB;
           }
           // Change button to Clicked color
          // hex = #E9573F;
           render();
                            
      }  
      
    } else refreshButton = false;
  }
  
}
void setRoot(File selected) {
  if (selected == null) {
    b1.active = true;
    msgBox("Select Import: Select dichotomous key to create JS", "Alert");
  }
  else {
    root  = selected;
    doneText = "";
  }
}
 
void setExport(File selected) {
  if (selected == null) {
    b2.active = true;
    msgBox("Select Export: Select where you want the files to be saved", "Alert");
  }
  else {
    selectedExport = selected;
    doneText = "";
  }
}

void cancilSelection() {
  b1.active = true;
  b2.active = true;
  
  selectedExport = null;
  root = null;
}

void generateJS() {
  
   clearData();
   questionWrite(cQ, root);
   packageQTinJS();
   if (!error) {
     fileJS(js);
     doneText = "Done!";
   }
   else {
     doneText = "There were errors. Consult Matthew Fala: matthewfala@gmail.com";
   }
   
   cancilSelection();
}