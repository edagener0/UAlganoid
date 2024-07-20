# UAlganoid
<img src="https://github.com/user-attachments/assets/2e87da23-f92e-46d5-ac3c-1d82fc299f75" width="25%" height="25%">
<img src="https://github.com/user-attachments/assets/305431fd-b859-4e08-98c7-78e88c91ec83" width="25%" height="25%">
<img src="https://github.com/user-attachments/assets/3f8dbca2-d0e5-44f0-945c-143c9751a220" width="25%" height="25%">

## Tabela de Conteúdos
1. [Acerca do Projeto](#Acerca-do-Projeto)
2. [Jogabilidade](#Jogabilidade)
    1. [Ativar e Desativar texturas](#Ativar-e-Desativar-texturas)
    2. [Blocos](#Blocos)
    3. [Vidas](#Vidas)
    4. [Movimento do Pad](#Movimento-do-Pad)
    5. [A Bola](#A-Bola)
    6. [Powerups](#Powerups)
    7. [Objetivo](#Objetivo)
4. [Cheat Codes](#Cheat-Codes)
    1. [Powerups](#Invocar-Powerups)
    2. [Mapas](#Mapas)
5. [Executar o jogo a partir do souce code](#Executar-o-jogo-a-partir-do-source-code)
6. [Executar o jogo sem source code](#Executar-o-jogo-sem-source-code)
    1. [No Windows](#No-Windows)
    2. [No Linux](#No-Linux)
## Acerca do Projeto
- Projeto desenvolvido no âmbito da disciplina de [Laboratório de Programação](https://academico.ualg.pt/netpa/doc?codeDiscip=14781068&anoLectivo=202425&codInstituic=9&stage=FichaUnidadeCurricular&_event=publicacaoFUC&docIsAttachment=false) do [Curso de Engenharia Informática](https://www.ualg.pt/curso/1478/plano) da [Universidade do Algarve](https://www.ualg.pt/)


- Ao longo do projeto aplicámos vários conceitos sobre Programação Orientada a Objetos.

- O nosso jogo é suposto ser algo semelhante ao jogo clássico [Arkanoid](https://en.wikipedia.org/wiki/Arkanoid).

- Todas as texturas e animações adicionadas ao jogo foram criadas por nós.
- Os sons do jogo tratam-se de misturas de sons retirados de outros jogos.
- Todo o jogo foi desenvolvido segundo a largura dos blocos, o que o torna dinâmico para qualquer resolução que o utilizador escolha, isto é, o tamanho de todos os objetos, textos e imagens é ajustado de acordo com a resolução escolhida.
- Para facilitar a geração de níveis do jogo foi criado um script em [Python](https://www.python.org/).


## Jogabilidade
### Ativar e Desativar texturas
- É possível ativar e desativar as texturas do jogo na tecla **i**
### Blocos
- Existem 9 tipos de blocos no jogo que têm diferentes vidas e dão diferentes pontuações ao jogador quando destruidos.
- Todos os blocos têm uma vida à exceção dos blocos prateados e dos blocos dourados.
- Os blocos prateados têm duas vidas.
- Os blocos dourados são indestrutíveis a menos que a bola possua o powerup **Fireball**, nesse caso são necessários dois hits para destruir esse bloco.

    |   Tipo   |  Vida    | Vida com Fireball | Pontuação| Cor   |
    |----------|----------|------------------|----------|--------|
    | 1        | 1        | 1              | 50       | White    |
    | 2        | 1        | 1              | 60       | Orange   |
    | 3        | 1        | 1              | 70       | Cyan     |
    | 4        | 1        | 1              | 80       | Green    |
    | 5        | 1        | 1              | 90       | Red      |
    | 6        | 1        | 1              | 100      | Blue     |
    | 7        | 1        | 1              | 110      | Purple   |
    | 8        | 2        | 1              | 200      | Silver   |
    | 9        | -1       | 2              | 1000     | Gold     |

### Vidas

- O máximo de vidas que o jogador pode ter são três.
- O jogador começa com o número máximo de vidas.
- Se a bola sair por baixo da tela o utilizador perde uma vida.


### Movimento do Pad


- Seta para a direita movimenta o pad para a direita.
- Seta para a esquerda movimenta o pad para a esquerda.
- Barra de espaços inicializa o jogo quando a bola está parada em cima do pad.


### A Bola

- O movimento da bola depende do ângulo de colisão da bola com o pad. O sentido e intensidade do vetor velocidade aplicado na bola é calculado segundo uma regressão linear.
- Para efeitos da regressão linear definimos que se a bola bater no centro do Pad o ângulo do vetor velocidade é 0º. No caso de colidir com o canto direito do Pad o ângulo é de 45º. No caso de colidir com o canto esquerdo do Pad o ângulo é de -45º.
- Com as informações acerca desses três pontos de colisão é possível fazer uma regressão linear e definir os ângulos para todos os outros pontos de colisão.


### Powerups
Há vários tipos de powerups no jogo. Há uma pequena chance de ser invocado um powerup aleatório aquando da destruição de um bloco.\
Para apanhar o powerup basta fazer com que o powerup colida com o Pad.


- Fireball
    - Permite a destruição de todos os blocos com apenas uma colisão.
    - Esta permite também que os blocos de dourados se tornem destrutíveis, necessitando de duas colisões.

- BallMultiplier
    - Invoca três bola novas por cada bola presente no jogo.
    - O jogador só perde uma vida se todas as bolas saírem do ecrã.

- LifeAdder
    - Acrescenta uma vida às vidas totais do jogador.
    - Se o jogador já tiver as vidas máximas, neste caso três, nenhuma vida é acrescentada.


- ScoreMultiplier
    - Multiplica os scores obtidos por cinco e soma à pontuação total do jogador.


### Objetivo

- Tal como no Arkanoid clássico o objetivo é fazer com que a bola ressalte no pad e bata nos blocos até partir todos os blocos.
- Ao partir todos os blocos de um nível passamos para o próximo nível automaticamente.
- Se o jogador conseguir completar os 25 níveis com sucesso ganha o jogo e aparece uma tela de vitória. 
- Se por acaso o jogador perder todas as vidas então aparece uma tela de derrota. 
- Após o fim de um jogo a única forma de iniciar o jogo é voltando a executar o jogo.

## Cheat Codes

- Para efeitos de teste desenvolvemos alguns comandos de "cheats".

### Invocar Powerups
Estes "cheats" invocam um powerup específico por diretamente acima do pad.

- A tecla **f** invoca uma Fireball.
- A tecla **l** invoca um LifeAdder.
- A tecla **s** invoca um ScoreMultiplier
- A tecla **m** invoca um BallMultiplier

### Mapas

Estes "cheats" permitem que o jogador salte um ou vários níveis.

- As teclas **1**, **2**, **3**, **4** e **5** permitem que o jogador salte para qualquer um desses níveis.
- A tecla *w* permite que o utilizador ganhe instantaneamente o nível em questão.

## Executar o jogo a partir do source code

1. Transferir e instalar o [Processing IDE](https://processing.org/download).
2. Transferir e instalar o [Java Development Kit](https://www.oracle.com/java/technologies/downloads/).
3. Clonar o [repositório](https://github.com/edagener0/UAlganoid.git), transferindo diretamente do Github como ficheiro Zip ou, caso tenha o git instalado no seu sistema pode utilizar o comando
```
git clone https://github.com/edagener0/UAlganoid.git
```
4. Abrir a pasta que transferiu e abrir o ficheiro principal do programa **UAlganoid.pde** no processing, o que irá abrir todo o projeto no IDE.
5. Por fim, instalar a biblioteca de som no Processing IDE.
    1. Abrir o processing IDE
    2. Na barra de ferramentas colocar o rato sobre o **Sketch** e esperar abrir um dropdown menu.
    3. Em seguida colocar o rato sobre **Import Libraries** e esperar abrir outro dropdown menu.
    4. Clicar em **Manage Libraries**.
    5. Na barra de pesquisa filtar por **Sound** e instalar a biblioteca **Sound** cujo autor é [The Processing Foundation](https://processingfoundation.org/).
6. O projeto está pronto a executar e a ser modificado à sua vontade. Divirta-se.

## Executar o jogo sem source code

Pode ser necessário instalar o [Java Development Kit](https://www.oracle.com/java/technologies/downloads/).
### No Windows

1. Transferir a [Windows Release](https://github.com/edagener0/UAlganoid/releases/tag/UAlganoid-windows64).
2. Descomprimir o ficheiro.
3. Executar o ficheiro executável dentro da pasta.

### No Linux
1. Transferir a [Linux Release](https://github.com/edagener0/UAlganoid/releases/tag/UAlganoid-Linux)
2. Descomprimir o ficheiro.
3. Executar o ficheiro shell script dentro da pasta.
```
bash UAlganoid-main
```


