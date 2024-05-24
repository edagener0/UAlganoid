class Fireball extends PowerUp
{
  float duracao;
  float start_time;
  boolean is_active;
  float on_fire_start_time;
  Fireball(float x, float y, int tipo)
  {
    super(x, y, tipo);
    this.duracao = 10000; 
    this.is_active = false;
    this.on_fire_start_time = 0;
  }
  
  void activate()
  {
    for (int i = 0; i < bolas.size(); i++)
    {
      Ball temp_ball = bolas.get(i);
      temp_ball.on_fire = true;
    }
    this.on_fire_start_time = millis();
    this.is_active = true;
  }
  
  void deactivate()
  {
    for (int i = 0; i < bolas.size(); i++)
    {
      Ball temp_ball = bolas.get(i);
      temp_ball.on_fire = false;
    }
    for (int i = 0; i < fireballs.size(); i++)
    {
        if(fireballs.get(i).posicao.y == 0)
        {
          fireballs.remove(i);
          break;  
        }
    }
    this.is_active = false;
    this.on_fire_start_time = 0;
  }
  
  void draw()
  {
    
    if (this.on_fire_start_time != 0 && millis() - this.on_fire_start_time >= this.duracao)
    {
      deactivate();
    }
    
    if (super.is_active())
    {
      picked_up_fireball.play();
      picked_up_fireball.play(efeitos);
      if(!this.is_active)
      {
        activate();
      }
      else this.on_fire_start_time = millis();
    }
    
    super.draw();
  }
  
}
