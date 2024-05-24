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
  
  void inicializar_blocos(String caminho_ficheiro)
  {
    int offset_x = LARGURA_BLOCO;
    int offset_y = ALTURA_BLOCO + ALTURA_BLOCO / 2;

    Ficheiro ficheiro = new Ficheiro("levels/" + caminho_ficheiro);
    String[][] tipos_blocos = ficheiro.parse_file(",");
 
    max_score = 0;
    score_atual = 0;
    
    for (int i = 0; i < ROWS; i++)
    {
      for (int j = 0; j < COLS; j++)
      {
        blocos[i][j] = new Block (offset_x, offset_y, LARGURA_BLOCO, int(tipos_blocos[i][j]), false);
        offset_x += LARGURA_BLOCO;
        if (blocos[i][j].tipo != 9) max_score += blocos[i][j].score;
      }
      offset_x = LARGURA_BLOCO;
      offset_y += ALTURA_BLOCO;
    }
  }
  
  void carregar_nivel(int nivel, BigMessage message)
  {
    if (nivel > MAX_NUMERO_NIVEIS) return;
    inicializar_blocos("level_" + nivel + ".lvl");
    message.display("Level " + nivel, BIGMESSAGE_COLOR, 2500);
    remove_fireballs();
    remove_triplicators();
    remove_balls();
    remove_life_adders();
    remove_score_multipliers();
    bolas.add(new Ball(LARGURA_JANELA/2, POSICAO_Y_BOLA, 0, 0, DIAMETRO_BOLA, GRAY, false));
    verificar_blocos();
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
