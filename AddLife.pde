class AddLife extends PowerUp
{
  float x;
  float y;
  int tipo;
  AddLife(float x, float y, int tipo)
  {
    super(x, y, tipo);
  }
  
  void draw()
  {
    if (super.visivel && super.colisao_pad())
    {
      coracao_sound.play();
      coracao_sound.amp(powerup_amp);
      header.lives++;
      
      if (header.lives > VIDAS) header.lives = VIDAS;

    }
    super.draw();
  }
}
