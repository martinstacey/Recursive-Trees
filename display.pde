//DISPLAY
void display() {
  nButX = 4;                                                                    //Number of buttons in X 
  nButY = 5;                                                                    //Number of buttons in Y 
  sButX = 1000/nButX;                                                           //Size of buttons in X 
  sButY = 25;                                                                   //Size of buttons in Y

  String[][] t = {                                                              //Array of String with Texts
    {"RECURSIVE TREE A:AB B:A ", " ", "  ", ""}, 
    {" ", "RESET", str(in[0]), "ADD BRANCHES"}, 
    {"BOX SIZE  ", "Previous", str(in[1]), "Next"}, 
    {"LENGTH OF PRINCIPAL BRANCH", "Previous", str(in[2]), "Next"}, 
    {"THICKNESS OF PRINCIPAL BRANCH", "Previous", str(in[3]), "Next"}, 
  };

  for (int i=0; i<nButX; i++) {                                                  //Button Display
    for (int j=1; j<nButY; j++) {
      if (j==0&&mouseX>sButX*i && mouseX<sButX*(i+1)&& mouseY>sButY*j && mouseY<sButY*(j+1)) fill (0, 0, 98);                               
      else if ((i==1||i==3)&&mouseX>sButX*i && mouseX<sButX*(i+1)&& mouseY>sButY*j && mouseY<sButY*(j+1))  fill(0, 0, 98);  
      else fill (0, 0, 100);                                                    //Paint White if previous statements are false
      rect(sButX*.5+(i*sButX), sButY*.5+(j*sButY), sButX, sButY);               //Draw Rectangle
      fill(0);
      text (t[j][i], sButX*(i+.5), sButY*(j+.5), 0);                            //Write Text
    }
  }
  fill(0, 0, 0);
  rect(sButX*2, sButY*.5+(0*sButY), sButX*nButX, sButY); 
  fill(0, 0, 100);
  text (t[0][0], sButX*2, sButY*(0+.5), 0);
}
void click() {
  if (mouseX>sButX*1 && mouseX<sButX*2 && mouseY>sButY*(1) && mouseY<sButY*(2)) reset();                           //RESET     
  for (int i=1; i<3; i++) if (mouseX>sButX*1 && mouseX<sButX*2 && mouseY>sButY*(i+1) && mouseY<sButY*(i+2)) {      //LENGTHS OF BRANCH AND BOX
    in[i]-=25;
    reset();
  }
  for (int i=1; i<3; i++) if (mouseX>sButX*3 && mouseX<sButX*4 && mouseY>sButY*(i+1) && mouseY<sButY*(i+2)) {
    in[i]+=25;
    reset();
  }
  //THICKNESS BOX
  if (mouseX>sButX*1 && mouseX<sButX*2 && mouseY>sButY*(4) && mouseY<sButY*(5)) {
    in[3]--;
    reset();
  }
  if (mouseX>sButX*3 && mouseX<sButX*4 && mouseY>sButY*(4) && mouseY<sButY*(5)) {
    in[3]++;
    reset();
  }

  //ADD BRANCHES
  if (mouseX>sButX*3 && mouseX<sButX*4 && mouseY>sButY*(1) && mouseY<sButY*(2)) {
    in[0]++;
    //RULE = For Branches A: AB
    for (int i=treeA.size()-1; i>=0; i--) {                                  //For every root in the tree 
      if (treeA.get(i).endx>-in[1]/2&&treeA.get(i).endx<in[1]/2) {           //If its between x values of Box
        if (treeA.get(i).endy>-in[1]&&treeA.get(i).endy<0) {                 //If its between y values of Box
          if (treeA.get(i).endz>-in[1]/2&&treeA.get(i).endz<in[1]/2) {       //If its between z values of Box       
            if (treeA.get(i).finish==false) {                                //Only draw finished roots (avoid redrawing all roots for every time)
              treeA.add(treeA.get(i).secBrA());                              //Create Branch A from previous Branch 
              treeB.add(treeA.get(i).secBrB());                              //Create Branch B from previous Branch
            }
          }
        }
      }
      treeA.get(i).finish = true;                                            //Finish Tree for all branches drawn
    }

    if  (treeB.size()>=1) {                                                   //RULE = For Branches B: A
      for (int i=treeB.size()-1; i>=0; i--) {                                 //For every root in the tree 
        if (treeB.get(i).endx>-in[1]/2&&treeB.get(i).endx<in[1]/2) {           //If its between x values of Box
          if (treeB.get(i).endy>-in[1]&&treeB.get(i).endy<0) {                 //If its between y values of Box
            if (treeB.get(i).endz>-in[1]/2&&treeB.get(i).endz<in[1]/2) {       //If its between z values of Box       
              if (treeB.get(i).finish==false) {   
                treeA.add(treeB.get(i).secBrA());
              }
            }
          }
        }
        treeB.get(i).finish = true;                                             //Finish Tree for all branches drawn
      }
    }
    println("A: "+treeA.size());
    println("B: "+treeB.size());
  }
}
void reset () {
  treeA = new ArrayList <Branch>();                                            //Instanciate Tree
  treeB = new ArrayList <Branch>();                                            //Instanciate Tree
  rootBegin= new PMatrix3D();                                                  //Instanciate Initial Branch Matrixes
  rootEnd= new PMatrix3D();                                                    //Repeat every Time New Root is Changed
  rootEnd.translate(0, -in[2]);                                                //Translate End Matrix to End of Initial Branch
  root= new Branch (rootBegin, rootEnd, in[2], in[3], in[4], in[5]);           //Root Instanciate with Initial Variables
  treeA.add(0, root);
}