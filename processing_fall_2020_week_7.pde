void setup() {
  Board game = new Board();
  println(game.currentShape.getShape());
  game.newPiece();
  println(game.currentShape.getShape());
  game.drawBoard();
}

void draw() {
  
}

public class Board {
  private final int BOARD_WIDTH = 10;
  private final int BOARD_HEIGHT = 22;
  
  private int currentX = 0;
  private int currentY = 0;
  private Shape currentShape;
  
  private Tetrominoes[] board;
  
  public Board() {
    currentShape = new Shape();
    board = new Tetrominoes[BOARD_WIDTH * BOARD_HEIGHT];
    clearBoard();
  }
  
  public int squareWidth() {
    return (int) width / BOARD_WIDTH;
  }
  
  public int squareHeight() {
    return (int) height / BOARD_HEIGHT;
  }
  
  public Tetrominoes shapeAt(int x, int y) {
    return board[y * BOARD_WIDTH + x];
  }
  
  private void clearBoard() {
    for (int i = 0; i < BOARD_HEIGHT * BOARD_WIDTH; i++) {
      board[i] = Tetrominoes.NoShape;
    }
  }
  
  public void newPiece() {
    currentShape.setRandomShape();
    currentX = BOARD_WIDTH / 2 + 1;
    currentY = -1 + currentShape.minY();
  }
  
  private void drawSquare(int x, int y, Tetrominoes shape) {
    fill(shape.c.getRed(), shape.c.getGreen(), shape.c.getBlue());
    rect(x, y, squareWidth(), squareHeight(), 7);
  }
  
  public void drawBoard() {
    int boardTop = (int) BOARD_HEIGHT * squareHeight();
    for (int row = 0; row < BOARD_HEIGHT; row++) {
      for (int col = 0; col < BOARD_WIDTH; col++) {
        Tetrominoes shape = shapeAt(col, BOARD_HEIGHT - row - 1);
        
        if (shape != Tetrominoes.NoShape) {
          drawSquare(col * squareWidth(), boardTop + row * squareHeight(), shape);
        }
      }
    }
    
    if (currentShape.getShape() != Tetrominoes.NoShape) {
      for (int i = 0; i < 4; i++) {
        int x = currentX + currentShape.x(i);
        int y = currentY + currentShape.y(i);
        drawSquare(x * squareWidth(), boardTop + (BOARD_HEIGHT - y - 1) * squareHeight(), currentShape.getShape());
      }
    }
  }
}
