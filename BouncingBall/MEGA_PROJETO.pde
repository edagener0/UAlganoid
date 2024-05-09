final color GRAY = color(150, 150, 150); //O processing ja tem uma variavel predefinida gray mas como é preta preferimos substituir por uma cor mais acinzentada
final color YELLOW = color(250, 250, 0);
//final color GREEN = color(0,255,0);
final color GREEN = color(150, 240, 150);
final color RED = color(255, 0, 0);

final int LARGURA_BLOCO = 60;
final int ALTURA_BLOCO = LARGURA_BLOCO / 2;

final int LARGURA_PAD = 4*LARGURA_BLOCO;
final float ALTURA_PAD = LARGURA_BLOCO / 4 * 0.5;

final int LARGURA_JANELA = 14*LARGURA_BLOCO;
final int ALTURA_JANELA = LARGURA_JANELA;
final int FRAME_RATE = 60;

final int PAD_VEL_X = 410;

final float MIN_BORDER_X = LARGURA_BLOCO * 0.5;
final float MAX_BORDER_X = LARGURA_JANELA - MIN_BORDER_X;

final float MIN_BORDER_Y = LARGURA_BLOCO * 0.5; //rever
final float MAX_BORDER_Y = ALTURA_JANELA;

final float DIAMETRO_BOLA = LARGURA_BLOCO * 0.5;

final float BOLA_VEL_X = 410;
final float BOLA_VEL_Y = -410;

final float BOLA_MODULO_VEL = sqrt(BOLA_VEL_X * BOLA_VEL_X + BOLA_VEL_Y * BOLA_VEL_Y);

final int ROWS = 15;
final int COLS = 13;

boolean game_on = false;

Block[][] blocos = new Block[ROWS][COLS];

Pad pad;
Border border;
Ball bola;
void settings()
{
  size(LARGURA_JANELA, ALTURA_JANELA);
}

void setup()
{
  frameRate(FRAME_RATE);
  noStroke();
  pad = new Pad(LARGURA_JANELA / 2, ALTURA_JANELA - ALTURA_BLOCO * 5, LARGURA_PAD, ALTURA_PAD, RED);
  border = new Border(LARGURA_BLOCO, YELLOW);
  bola = new Ball(LARGURA_JANELA/2, ALTURA_JANELA - LARGURA_BLOCO * 0.5 * 5 - 100, DIAMETRO_BOLA, GRAY);
  println("min: ", MIN_BORDER_X, "max: ", MAX_BORDER_X);
  inicializar_blocos();
}

void keyPressed()
{  
  if(keyCode == RIGHT) pad.velocidade.x = PAD_VEL_X / FRAME_RATE;
  else if(keyCode == LEFT) pad.velocidade.x = -PAD_VEL_X / FRAME_RATE;
  else if(keyCode == 32 && !game_on) 
  {
    bola.velocidade.y = 5;
    bola.velocidade.x = 0;
    //game_on = true;
  }
  else if (key == 'r')
  {
    bola.posicao.x = LARGURA_JANELA/2;
    bola.posicao.y = ALTURA_JANELA - LARGURA_BLOCO * 0.5 * 5 - 100;
    bola.velocidade.x = 0;
    bola.velocidade.y = 0;
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
      blocos[i][j] = new Block (offset_x, offset_y, LARGURA_BLOCO, GREEN, 5, true);
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

void draw()
{
  background(255);
  border.draw();
  pad.draw();
  bola.colisao_pad(pad);
  bola.colisao_parede(border);
  bola.colisao_blocos(blocos);
  desenhar_blocos();
  bola.draw();
}
