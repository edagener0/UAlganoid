class Fireball extends PowerUp
{
  float duracao;
  float start_time;
  Fireball(float x, float y, int tipo)
  {
    super(x, y, tipo);
    this.duracao = 10000; //em milisegundos;
    this.start_time = 0;
  }
  
  void activate()
  {
    this.start_time = millis();
    for (int i = 0; i < bolas.size(); i++)
    {
      Ball temp_ball = bolas.get(i);
      temp_ball.on_fire = true;
    }
  }
  void deactivate()
  {
    for (int i = 0; i < bolas.size(); i++)
    {
      Ball temp_ball = bolas.get(i);
      temp_ball.on_fire = false;
    }
  }
  
  void draw()
  {
    if (millis() - this.start_time >= this.duracao)
    {
      deactivate();
    }
    if (super.visivel && super.colisao_pad())
    {
      super.posicao.y = 0;
      activate();
    }
    
    super.draw();
  }
  
}
