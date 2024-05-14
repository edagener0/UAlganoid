final color GRAY = color(150, 150, 150); //O processing ja tem uma variavel predefinida gray mas como é preta preferimos substituir por uma cor mais acinzentada
final color YELLOW = color(250, 250, 0);
//final color GREEN = color(0,255,0);
final color GREEN = color(150, 240, 150);
final color RED = color(255, 0, 0);

final int LARGURA_BLOCO = 54;
final int ALTURA_BLOCO = LARGURA_BLOCO / 2;

final int ALTURA_HEADER = 2 * ALTURA_BLOCO;

final int LARGURA_JANELA = 14*LARGURA_BLOCO;
final int ALTURA_JANELA = LARGURA_JANELA  + ALTURA_HEADER;
final int FRAME_RATE = 60;

final float MIN_BORDER_X = LARGURA_BLOCO * 0.5;
final float MAX_BORDER_X = LARGURA_JANELA - MIN_BORDER_X;

final float MIN_BORDER_Y = ALTURA_BLOCO + ALTURA_HEADER; //rever
final float MAX_BORDER_Y = ALTURA_JANELA + ALTURA_HEADER;

final int LARGURA_PAD = 4 * LARGURA_BLOCO;
final float ALTURA_PAD = LARGURA_BLOCO * 0.5;
final float POSICAO_Y_PAD =  ALTURA_JANELA - ALTURA_BLOCO * 1.5;

final float DIAMETRO_BOLA = LARGURA_BLOCO * 0.5;
final float POSICAO_Y_BOLA = POSICAO_Y_PAD - ALTURA_PAD / 2 - DIAMETRO_BOLA / 2 - DIAMETRO_BOLA * 0.5;

final float BOLA_VEL_X = 5;
final float BOLA_VEL_Y = 5;

//final float BOLA_MODULO_VEL = sqrt(BOLA_VEL_X * BOLA_VEL_X + BOLA_VEL_Y * BOLA_VEL_Y);
final float BOLA_MODULO_VEL = LARGURA_BLOCO * 0.15;
final float PAD_MODULO_VEL = LARGURA_BLOCO * 0.2;

final int ROWS = 15;
final int COLS = 13;

boolean game_on = false;

Pad pad;
Border border;
Ball bola;

Header header;

Blocks blocos = new Blocks();

void settings()
{
  size(LARGURA_JANELA, ALTURA_JANELA);
}

void setup()
{
  frameRate(FRAME_RATE);
  noStroke();
  pad = new Pad(LARGURA_JANELA / 2, POSICAO_Y_PAD, LARGURA_PAD, ALTURA_PAD, RED);
  border = new Border(LARGURA_BLOCO, YELLOW);
  bola = new Ball(LARGURA_JANELA/2, POSICAO_Y_BOLA, DIAMETRO_BOLA, GRAY);
  header = new Header(LARGURA_JANELA/2, ALTURA_BLOCO);
  //println("min: ", MIN_BORDER_X, "max: ", MAX_BORDER_X);
  
  blocos.inicializar_blocos();
}

void keyPressed()
{  
  if (keyCode == RIGHT) pad.mover_direita();
  else if (keyCode == LEFT) pad.mover_esquerda();
  else if (keyCode == 32 && !game_on) 
  {
    bola.lancar_bola(pad);
    game_on = true;
  }
  else if (key == 'r')
  {
    bola.posicao.y = POSICAO_Y_BOLA;
    bola.velocidade.y = 0;
    bola.velocidade.x = 0;
    game_on = false;
  }
  else if (key == 'i')
  {
    bola.velocidade.rotate(PI);
  }
}



void draw()
{
  println(bola.velocidade);
  background(255);
  border.draw();
  pad.draw();
  bola.before_game(pad, game_on);
  //println(blocos.blocos[14][12].exposto);
  blocos.verificar_blocos();
  bola.detetar_colisoes(pad, blocos.blocos);
  blocos.desenhar_blocos();
  bola.draw();
  header.draw();
}
