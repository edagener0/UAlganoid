class Blocks
{
  Block[][] blocos;
  Blocks()
  {
    this.blocos = new Block[ROWS][COLS];
    return;
  }
  
  void verificar_blocos()
  {
    boolean esquerda, direita, cima, baixo;
    
    for (int i = 0; i < ROWS; i++)
    {
      for (int j = 0; j < COLS; j++)
      {
        if (this.blocos[i][j].exposto) continue;
        cima = false;
        baixo = false;
        direita = false;
        esquerda = false;
        /*
        if (this.blocos[i][j - 1].vida == 0 ||
        this.blocos[i][j + 1].vida == 0 ||
        this.blocos[i + 1][j].vida == 0 ||
        this.blocos[i - 1][j].vida == 0)
        {
          this.blocos[i][j].exposto = true;
        }*/
        
        //verificar esquerda do bloco
        if (i-1 >= 0) cima = true;
        if (i + 1 < ROWS) baixo = true;
        else
        {
          this.blocos[i][j].exposto = true;
          continue;
        }
        if (j - 1 >= 0) esquerda = true;
        if (j + 1 < COLS) direita = true;
        
        if (cima)
        {
          if(this.blocos[i - 1][j].vida == 0)
          {
            this.blocos[i][j].exposto = true;
            continue;
          }
        }
        if (baixo)
        {
          println("baixo:", i, j);
          if (this.blocos[i + 1][j].vida == 0)
          {
            this.blocos[i][j].exposto = true;
            continue;
          }
        }
        if (direita)
        {
          if (this.blocos[i][j + 1].vida == 0)
          {
            this.blocos[i][j].exposto = true;
            continue;
          }
        }
        if (esquerda)
        {
          if (this.blocos[i][j - 1].vida == 0)
          {
            this.blocos[i][j].exposto = true;
            continue;
          }
        }
      }
    }
  }
  void inicializar_blocos()
  {
    int offset_x = LARGURA_BLOCO;
    int offset_y = ALTURA_BLOCO + ALTURA_BLOCO / 2;
    //Block bloco = new Block (LARGURA_BLOCO, ALTURA_BLOCO + ALTURA_BLOCO / 2, LARGURA_BLOCO, GREEN, 5);
    //bloco.draw();
    for (int i = 0; i < ROWS; i++)
    {
      for (int j = 0; j < COLS; j++)
      {
        blocos[i][j] = new Block (offset_x, offset_y, LARGURA_BLOCO, GREEN, 1, false);
        offset_x += LARGURA_BLOCO;
      }
      offset_x = LARGURA_BLOCO;
      offset_y += ALTURA_BLOCO;
    }
  }
  
  void desenhar_blocos()
  {
    for (int i = 0; i < ROWS; i++)
    {
      for (int j = 0; j < COLS; j++)
      {
        blocos[i][j].draw();
      }
      
    }
  }
}
