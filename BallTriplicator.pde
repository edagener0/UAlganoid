class BallTriplicator extends PowerUp
{
  float x;
  float y;
  int tipo;
  
  boolean is_active;
  BallTriplicator(float x, float y, int tipo)
  {
    super(x, y, tipo);
    this.is_active = is_active;
  }
  
  void triplicate()
  {
    int limit = bolas.size();
    for (int i = 0; i < limit; i++)
    {
      Ball temp_ball = bolas.get(i);
      Ball deepcopy1 = temp_ball.deep_copy();
      Ball deepcopy2 = temp_ball.deep_copy();
      
      deepcopy1.velocidade.x = random(-5, 5);
      deepcopy2.velocidade.x = random(-5, 5);
      
      bolas.add(deepcopy1);
      bolas.add(deepcopy2);
    }
  }
  
  void remove_triplicator()
  {
    for (int i = 0; i < triplicators.size(); i++)
    {
      if (super.posicao.y == 0 || !super.visivel) 
      {
        triplicators.remove(i);
      }
    }
  }
  
  void draw()
  {
    
    if (super.visivel && super.colisao_pad())
    {
      //println("executing");
      super.posicao.y = 0;
      super.visivel = false;
      triplicate();
      remove_triplicator();
    }
    super.draw();
  }
}
