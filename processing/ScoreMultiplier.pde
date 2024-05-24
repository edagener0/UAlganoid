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
  

  // -----------------------------------------------------------
  // Função que verifica se já passou o tempo de vida do PowerUp
  // -----------------------------------------------------------
  void has_passed()
  {
    if (millis() - this.start_time >= this.duration)  
    {
      this.active = false;
      multiplier = 1;
      for (int i = 0; i < score_multipliers.size(); i++)
      {
        if (!score_multipliers.get(i).visivel)
        {
          score_multipliers.remove(i);
        }
      }
    }
  }
  
  
  void draw()
  {
    if (super.is_active())
    {
       this.start_time = millis();
       this.active = true;
       multiplier = 5;
       picked_up_x5.play();
       picked_up_x5.amp(efeitos);
    }
    
    if (this.active) has_passed();

    super.draw();
  }
}
