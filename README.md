# UAlganoid
<ul>

<li>Projeto desenvolvido no âmbito da disciplina de [Laboratório de Programação](https://academico.ualg.pt/netpa/doc?codeDiscip=14781068&anoLectivo=202425&codInstituic=9&stage=FichaUnidadeCurricular&_event=publicacaoFUC&docIsAttachment=false) do [Curso de Engenharia Informática](https://www.ualg.pt/curso/1478/plano) da [Universidade do Algarve](https://www.ualg.pt/).</li>

<li>Ao longo do projeto aplicámos vários conceitos sobre Programação Orientada a Objetos.</li>

<li>O nosso jogo é suposto ser algo semelhante ao jogo antigo [Arkanoid](https://en.wikipedia.org/wiki/Arkanoid).</li>

<li>Todas as texturas e animações adicionadas ao jogo foram criadas por nós.</li>
<li>Os sons do jogo tratam-se de misturas de sons retirados de outros jogos.</li>
<li>Todo o jogo foi desenvolvido segundo a largura dos blocos, o que o torna dinâmico para qualquer resolução que o utilizador escolha, isto é, o tamanho de todos os objetos, textos e imagens é ajustado de acordo com a resolução escolhida.</li>
</ul>

## Jogabilidade

### Vidas
<ul>
<li>O máximo de vidas que o jogador pode ter são três.</li>
<li>O jogador começa com o número máximo de vidas..</li>
<li>Se a bola sair por baixo da tela o utilizador perde uma vida.</li>
</ul>

### Movimento do Pad

<ul>
<li>Seta para a direita movimenta o pad para a direita</li>
<li>Seta para a esquerda movimenta o pad para a esquerda</li>
<li>Barra de espaços inicializa o jogo quando a bola está parada em cima do pad</li>
</ul>

### A Bola

<ul>
<li>O movimento da bola depende do ângulo de colisão da bola com o pad. O sentido e intensidade do vetor velocidade aplicado na bola é calculado segundo uma regressão linear.</li>
<li>Para efeitos da regressão linear definimos que se a bola bater no centro do Pad o ângulo do vetor velocidade é 0º. No caso de colidir com o canto direito do Pad o ângulo é de 45º. No caso de colidir com o canto esquerdo do Pad o ângulo é de -45º.</li>
<li>Com as informações acerca desses três pontos de colisão é possível fazer uma regressão linear e definir os ângulos para todos os outros pontos de colisão.</li>
</ul>

### Powerups
Há vários tipos de powerups no jogo. Há uma pequena chance de ser invocado um powerup aleatório aquando da destruição de um bloco.<br>
Para apanhar o powerup basta fazer com que o powerup colida com o Pad.
<ul>

<li>Fireball</li>

<ul>
<li>Permite a destruição de todos os blocos com apenas uma colisão.</li> 
<li>Esta permite também que os blocos de dourados se tornem destrutíveis, necessitando de duas colisões.</li>
</ul>

<br>

<li>BallMultiplier</li>
<ul>
<li>Invoca três bola novas por cada bola presente no jogo.</li>
<li>O jogador só perde uma vida se todas as bolas saírem do ecrã.</li>
</ul>

<br>

<li>LifeAdder</li>
<ul>
<li>Acrescenta uma vida às vidas totais do jogador.</li>
<li>Se o jogador já tiver as vidas máximas, neste caso três, nenhuma vida é acrescentada.</li>
</ul>

<br>

<li>ScoreMultiplier</li>
<ul>
<li>Multiplica os scores obtidos por cinco e soma à pontuação total do jogador.</li>
</ul>
</ul>

### Objetivo
<ul>
<li>Tal como no Arkanoid clássico o objetivo é fazer com que a bola ressalte no pad e bata nos blocos até partir todos os blocos.</li>
<li>Ao partir todos os blocos de um nível passamos para o próximo nível automaticamente.</li>
<li>Se o jogador conseguir completar os 25 níveis com sucesso ganha o jogo e aparece uma tela de vitória.</li> 
<li>Se por acaso o jogador perder todas as vidas então aparece uma tela de derrota.</li> 
<li>Após o fim de um jogo a única forma de iniciar o jogo é voltando a executar o jogo.</li>
</ul>

## Cheat Codes

Para efeitos de teste desenvolvemos alguns comandos de "cheats".

### Powerups 
Estes "cheats" invocam um powerup específico por diretamente acima do pad.
<ul>
<li>A tecla 'f' invoca uma Fireball.</li>
<li>A tecla 'l' invoca um LifeAdder.</li>
<li>A tecla 's' invoca um ScoreMultiplier</li>
<li>A tecla 'm' invoca um BallMultiplier</li>
</ul>

### Mapas

Estes "cheats" permitem que o jogador salte um ou vários níveis.
<ul>
<li>As teclas '1', '2', '3', '4' e '5' permitem que o jogador salte para qualquer um desses níveis.</li>
<li>A tecla 'w' permite que o utilizador ganhe instantaneamente o nível em questão.
</ul>




