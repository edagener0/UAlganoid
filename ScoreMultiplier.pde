class ScoreMultiplier extends PowerUp
{
  float x;
  float y;
  int tipo;
  float start_time;
  boolean active;
  float duration;
  
  ScoreMultiplier(float x, float y, int tipo)
  {
    super(x, y, tipo);
    this.start_time = 0;
    this.active = false;
    this.duration = 5000;
  }
  
  void has_passed()
  {
    if (millis() - this.start_time >= this.duration)  
    {
      this.active = false;
      multiplier = 1;
    }
  }
  
  
  void draw()
  {
    if (super.visivel && super.colisao_pad())
    {
       this.start_time = millis();
       this.active = true;
       multiplier = 5;
       println("APANHASTE POWERUP");
    }
    
    if (this.active) has_passed();

    super.draw();
  }
  
}
