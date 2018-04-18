class Blood {
 float myX, myY, myFade;
 
 Blood(float x, float y) {
    myX = x;
    myY = y;
    myFade = 255;
 }
 
 void update() {
   if (myFade > 0) {
     myFade-=1;  
   }
   tint(255, myFade);
   image(blood, myX, myY);
 }
}
