class Fireball extends PowerUp
{
  float duracao;
  float start_time;
  boolean is_active;
  Fireball(float x, float y, int tipo)
  {
    super(x, y, tipo);
    this.duracao = 10000; //em milisegundos;
    //this.start_time = 0;
    this.is_active = false;
  }
  
  void activate()
  {
    for (int i = 0; i < bolas.size(); i++)
    {
      Ball temp_ball = bolas.get(i);
      temp_ball.on_fire = true;
    }
    on_fire_start_time = millis();
    this.is_active = true;
  }
  void deactivate()
  {
    //println("Desativando!");
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
    on_fire_start_time = 0;
  }
  
  //TODO Se apanharmos outro powerup do mesmo tipo enquanto um deles está ativo, na teoria deveria resetar o tempo desse powerup isto isto é continuar por +10 segundos no caso da bola
  void draw()
  {
    
    if (on_fire_start_time != 0 && millis() - on_fire_start_time >= this.duracao)
    {
      deactivate();
    }
    if (super.visivel && super.colisao_pad())
    {
      if(!this.is_active)
      {
        super.posicao.y = 0;
        activate();
      }
      else on_fire_start_time = millis();
    }
    //println("fireballs size", fireballs.size());
    //println("Tempo: ", millis() - on_fire_start_time);
    super.draw();
  }
  
}
