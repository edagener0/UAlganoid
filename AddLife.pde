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
    if (super.visivel && super.colisao_pad() && game_on)
    {
      coracao_sound.play();
      coracao_sound.amp(powerup_amp);
      header.lives++;
      if (header.lives > VIDAS) header.lives = VIDAS;
      
      for (int i = 0; i < life_adders.size(); i++)
      {
        if (!life_adders.get(i).visivel)
        {
          life_adders.remove(i);
        }
      }

    }
    super.draw();
  }
}
