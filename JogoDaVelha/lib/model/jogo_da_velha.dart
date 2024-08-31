class JogoDaVelha {
  int vez = 1;
  //1 para a vez do "X".
  //-1 para a vez do "O".

  int vencedor = 0;
  int vitoriasX = 0;
  int vitoriasO = 0;

  List<int> tabuleiro = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  bool jogar(posicao) {
    if (tabuleiro[posicao] == 0) {
      tabuleiro[posicao] = vez;

      vez *= -1;

      return true;
    }

    return false;
  }

  int obterEstadoPosicao(posicao) {
    return tabuleiro[posicao];
  }

  bool checkDraw() {
    return checkPositions();
  }

  int checkVictory() {
    // Condições de vitória - Linhas

    if (tabuleiro[0] != 0 &&
        tabuleiro[0] == tabuleiro[1] &&
        tabuleiro[1] == tabuleiro[2]) return tabuleiro[0];
    if (tabuleiro[3] != 0 &&
        tabuleiro[3] == tabuleiro[4] &&
        tabuleiro[4] == tabuleiro[5]) return tabuleiro[3];
    if (tabuleiro[6] != 0 &&
        tabuleiro[6] == tabuleiro[7] &&
        tabuleiro[7] == tabuleiro[8]) return tabuleiro[6];

    // Condições de vitória - Colunas
    if (tabuleiro[0] != 0 &&
        tabuleiro[0] == tabuleiro[3] &&
        tabuleiro[3] == tabuleiro[6]) return tabuleiro[0];
    if (tabuleiro[1] != 0 &&
        tabuleiro[1] == tabuleiro[4] &&
        tabuleiro[4] == tabuleiro[7]) return tabuleiro[1];
    if (tabuleiro[2] != 0 &&
        tabuleiro[2] == tabuleiro[5] &&
        tabuleiro[5] == tabuleiro[8]) return tabuleiro[2];

    // Condições de vitória - Diagonais
    if (tabuleiro[0] != 0 &&
        tabuleiro[0] == tabuleiro[4] &&
        tabuleiro[4] == tabuleiro[8]) return tabuleiro[0];
    if (tabuleiro[2] != 0 &&
        tabuleiro[2] == tabuleiro[4] &&
        tabuleiro[4] == tabuleiro[6]) return tabuleiro[2];

    return 0; // Ninguém ganhou ainda
  }

  bool checkPositions() {
    for (int pos in tabuleiro) {
      if (pos == 0) {
        return false; //jogo ainda nao terminou
      }
    }

    return true;
  }

  void reiniciarJogo() {
    vez = 1;
    vencedor = 0;
    tabuleiro = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  }

  void reiniciarPlacar() {
    vitoriasX = 0;
    vitoriasO = 0;
  }
}
