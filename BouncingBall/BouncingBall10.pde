import processing.sound.*;

SoundFile VICTORY;
SoundFile DEFEAT;
SoundFile block_hit;
SoundFile pad_bounce;

final color INVISIBLE = color(0, 0, 0, 0);
final color GRAY = color(150, 150, 150); //O processing ja tem uma variavel predefinida gray mas como é preta preferimos substituir por uma cor mais acinzentada
final color YELLOW = color(250, 250, 0);
final color GREEN = color(100, 240, 100);
final color RED = color(240, 50, 50);
final color BLACK = color(0, 0, 0);
final color WHITE = color(255, 255, 255);
final color ORANGE = color(240, 140, 0);
final color CYAN = color(0, 225, 230);
final color BLUE = color(40, 60, 240);
final color PURPLE = color(200, 40, 250);
final color SILVER = color(180, 180, 180);
final color GOLD = color(250, 195, 50);

final color BACKGROUND_COLOR = BLACK;
final color BIGMESSAGE_COLOR = color(50, 150, 255);

final int LARGURA_BLOCO = 54;
final int ALTURA_BLOCO = LARGURA_BLOCO / 2;

final int ALTURA_HEADER = 3 * ALTURA_BLOCO;

final int LARGURA_JANELA = 14*LARGURA_BLOCO;
final int ALTURA_JANELA = LARGURA_JANELA  + ALTURA_HEADER;
final int FRAME_RATE = 60;

final float MIN_BORDER_X = LARGURA_BLOCO * 0.5;
final float MAX_BORDER_X = LARGURA_JANELA - MIN_BORDER_X;

final float MIN_BORDER_Y = ALTURA_BLOCO + ALTURA_HEADER; //rever
final float MAX_BORDER_Y = ALTURA_JANELA + ALTURA_HEADER;

final int LARGURA_PAD = 4 * LARGURA_BLOCO;
final float ALTURA_PAD = LARGURA_BLOCO * 0.5;
final float POSICAO_X_PAD = LARGURA_JANELA / 2;
final float POSICAO_Y_PAD = ALTURA_JANELA - ALTURA_BLOCO * 1.5;

final float DIAMETRO_BOLA = LARGURA_BLOCO * 0.5;
final float POSICAO_Y_BOLA = POSICAO_Y_PAD - ALTURA_PAD / 2 - DIAMETRO_BOLA / 2 - LARGURA_BLOCO * 0.01;

final float BOLA_VEL_X = 5;
final float BOLA_VEL_Y = 5;

//final float BOLA_MODULO_VEL = sqrt(BOLA_VEL_X * BOLA_VEL_X + BOLA_VEL_Y * BOLA_VEL_Y);
final float BOLA_MODULO_VEL = LARGURA_BLOCO * 0.15;
final float PAD_MODULO_VEL = LARGURA_BLOCO * 0.2;

final int VIDAS = 3;

final int ROWS = 15;
final int COLS = 13;

int MAX_NUMERO_NIVEIS = 5;

int max_score;
int score_atual;

int nivel_atual = 1;

boolean game_on = false;
boolean lost = false;

boolean won_level = false;
boolean won_game = false;

boolean[] passed_levels = new boolean[MAX_NUMERO_NIVEIS];

Pad pad;
Border border;
Ball bola;
BigMessage message;
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
  pad = new Pad(POSICAO_X_PAD, POSICAO_Y_PAD, LARGURA_PAD, ALTURA_PAD, RED);
  border = new Border(LARGURA_BLOCO, YELLOW);
  bola = new Ball(LARGURA_JANELA/2, POSICAO_Y_BOLA, DIAMETRO_BOLA, GRAY);
  header = new Header(LARGURA_JANELA/2, ALTURA_BLOCO);
  message = new BigMessage();
  //println("min: ", MIN_BORDER_X, "max: ", MAX_BORDER_X);
  
  blocos.carregar_nivel(nivel_atual, message);
  
  for (int i = 0; i < MAX_NUMERO_NIVEIS; i++)
  {
    passed_levels[i] = false;
  }
  
  VICTORY = new SoundFile(this, "victory.wav");
  DEFEAT = new SoundFile(this, "defeat.wav");
  block_hit = new SoundFile(this, "hit.wav");
  pad_bounce = new SoundFile(this, "pad.wav");
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
    bola.reset(pad);
  }
  else if (key == 'i')
  {
    bola.velocidade.rotate(PI);
  }
  else if (key == '1')
  {
    nivel_atual = 1;
    blocos.carregar_nivel(1, message);
    bola.reset(pad);
    pad.reset();
  }
  else if (key == '2')
  {
    nivel_atual = 2;
    blocos.carregar_nivel(2, message);
    bola.reset(pad);
    pad.reset();
  }
  else if (key == '3')
  {
    nivel_atual = 3;
    blocos.carregar_nivel(3, message);
    bola.reset(pad);
    pad.reset();
  }
  else if (key == '4')
  {
    nivel_atual = 4;
    blocos.carregar_nivel(4, message);
    bola.reset(pad);
    pad.reset();
  }
  else if (key == '5')
  {
    nivel_atual = 5;
    blocos.carregar_nivel(5, message);
    bola.reset(pad);
    pad.reset();
  }
  else if (key == '6')
  {
    //println(millis());
    message.display("ganda papada", YELLOW, 2000);
  }
  else if (key == 'w')
  {
    score_atual = max_score;
  }
}

boolean have_lives()
{
  if (!header.have_lives())
  {
    if (!lost)
    {
      message.display("Game Over!", RED, 4500);
      DEFEAT.play();
    }
    lost = true;
    return false;
  }
  return true;
}

boolean ganhou_jogo()
{
  //println(passed_levels);
  for (int i = 0; i < MAX_NUMERO_NIVEIS; i++)
  {
    if (!passed_levels[i]) return false;
  }
  
  if (!won_game) 
  {
    message.display("Victory!!", CYAN, 4500);
    VICTORY.play();
  }
  
  won_game = true;
  
  return true;
}

boolean ganhou()
{
  if (won_level && nivel_atual <= MAX_NUMERO_NIVEIS)
  {
    passed_levels[nivel_atual - 1] = true;
    nivel_atual++;
    blocos.carregar_nivel(nivel_atual, message);
    won_level = false;
    bola.reset(pad);
    return true;
  }
  return false;
}

void draw()
{
  //println(bola.velocidade);
  background(BACKGROUND_COLOR);
  
  border.draw();
  pad.draw();
  bola.before_game(pad, game_on, lost);
  blocos.verificar_blocos();
  blocos.desenhar_blocos();
  header.draw();
  message.draw();
  bola.detetar_colisoes(pad, blocos.blocos, header);
  header.ganhou_nivel();
  
  if (!have_lives()) return;
  if (ganhou()) return;
  if (ganhou_jogo()) return;
  
  
  bola.draw();
}
