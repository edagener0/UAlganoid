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
      VIDAS++;
      if (VIDAS > VIDAS_MAX) VIDAS = VIDAS_MAX;
      header.lives = VIDAS;
    }
    super.draw();
  }
}
