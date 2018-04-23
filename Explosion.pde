class Explosion {
  float myX, myY, myRadius;    
   Explosion(float x, float y,float radius) {
     myX = x;
     myY = y;
     myRadius = radius;
     explosion.resize((int) (myRadius), (int) (myRadius*.75));
   }
   
   void setX(float x) {
     myX = x;
   }
   
   void setY(float y) {
     myY = y;  
   }
   
   void update () {
     image(explosion, myX, myY);
   }
}
