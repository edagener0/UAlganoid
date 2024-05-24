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
    if (super.is_active())
    {
      picked_up_coracao.play();
      picked_up_coracao.amp(efeitos);
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
