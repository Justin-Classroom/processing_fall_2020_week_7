Board game;
int timer;
int interval = 1500; // milliseconds

void setup() {
  size(200, 400);
  game = new Board();
  timer = millis();
}

void draw() {
  background(255);
  game.drawBoard(); //<>//
  if (millis() - timer >= interval) {
    // create the game loop
    println("The game loop should occur here");
    timer = millis();
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    game.moveLeft();
  }
  
  // use the functions in the Board class for the following actions
  // move block right / left
  // move block all the way down
  // rotate block left / right
  if (key == 'd' || key == 'D') {
  }
  
  if (key == 'w' || key == 'W') {
  }
  
  if (key == 'e' || key == 'E') {
  }
  
  if (key == 's' || key == 'S') {
  }
  
  if (key == ' ') {
  }
}

public class Board {
  // ==========================================================
  //            Class Fields
  // ==========================================================
  private final int BOARD_WIDTH = 10;
  private final int BOARD_HEIGHT = 22;
  
  private boolean isFallingFinished = false;
  private int currentX = 0;
  private int currentY = 0;
  private Shape currentShape;
  
  private Tetrominoes[] board;
  
  // Constructor
  public Board() {
    currentShape = new Shape();
    board = new Tetrominoes[BOARD_WIDTH * BOARD_HEIGHT];
    clearBoard();
    newPiece();
  }
  
  // ==========================================================
  //            PUBLIC FUNCTIONS
  // ==========================================================
  
  public int squareWidth() {
    return (int) width / BOARD_WIDTH;
  }
  
  public int squareHeight() {
    return (int) height / BOARD_HEIGHT;
  }
  
  public Tetrominoes shapeAt(int x, int y) {
    return board[(y * BOARD_WIDTH) + x];
  }
  
  // used with timer to create game loop
  public void update() {
    if (isFallingFinished) {
      isFallingFinished = false; //<>//
      newPiece();
    } else {
      oneLineDown();
    }
  }
  
  // renders graphics - draws game objects
  public void drawBoard() {
    int boardTop = (int) height - BOARD_HEIGHT * squareHeight();
    for (int row = 0; row < BOARD_HEIGHT; row++) {
      for (int col = 0; col < BOARD_WIDTH; col++) {
        Tetrominoes shape = shapeAt(col, row);
        
        if (shape != Tetrominoes.NoShape) {
          drawSquare(col * squareWidth(), boardTop + row * squareHeight(), shape);
        }
      }
    }
    
    if (currentShape.getShape() != Tetrominoes.NoShape) {
      for (int i = 0; i < 4; i++) {
        int x = currentX + currentShape.x(i);
        int y = currentY + currentShape.y(i);
        drawSquare(x * squareWidth(), boardTop + y *  squareHeight(), currentShape.getShape());
      }
    }
  }
  
  // COMMAND FUNCTIONS
  public void oneLineDown() {
    if (!tryMove(currentShape, currentX, currentY + 1)) {
      pieceDropped();
    }
  }
  
  public void dropDown() {
    int newY = currentY;
    while(newY < BOARD_HEIGHT) {
      if (!tryMove(currentShape, currentX, currentY + 1)) {
        break;
      }
      newY--;
    }
    pieceDropped();
  }
  
  public void moveLeft() {
    tryMove(currentShape, currentX - 1, currentY);
  }
  
  public void moveRight() {
    tryMove(currentShape, currentX + 1, currentY);
  }
  
  public void rotateLeft() {
    tryMove(currentShape.rotateLeft(), currentX + 1, currentY);
  }
  
  public void rotateRight() {
    tryMove(currentShape.rotateRight(), currentX + 1, currentY);
  }
  
  // ==========================================================
  //            END OF PUBLIC FUNCTIONS
  // ==========================================================
  
  
  
  // ==========================================================
  //            PRIVATE FUNCTIONS
  // ==========================================================
        
  public void newPiece() {
    currentShape.setRandomShape();
    currentX = BOARD_WIDTH / 2 + 1;
    currentY = 1 + currentShape.minY();
    println(currentShape.getShape());
  }
  
  private void clearBoard() {
    for (int i = 0; i < BOARD_HEIGHT * BOARD_WIDTH; i++) {
      board[i] = Tetrominoes.NoShape;
    }
  }
    
  private void drawSquare(int x, int y, Tetrominoes shape) {
    fill(shape.c.getRed(), shape.c.getGreen(), shape.c.getBlue());
    rect(x, y, squareWidth(), squareHeight(), 7);
  }
  
  private void pieceDropped() {
    for (int i = 0; i < 4; i++) {
      int x = currentX + currentShape.x(i);
      int y = currentY + currentShape.y(i);
      board[(y * BOARD_WIDTH) + x] = currentShape.getShape();
    }
    
    removeFullLines();
    
    if (!isFallingFinished) {
      // spawn a new tetris block here
    }
  }
  
  private boolean tryMove(Shape newPiece, int newX, int newY) {
    for (int i = 0; i < 4; i++) {
      int x = newX + newPiece.x(i);
      int y = newY + newPiece.y(i);
      
      if (x < 0 || x >= BOARD_WIDTH || y < 0 || y >= BOARD_HEIGHT) {
        return false;
      }
      
      if (shapeAt(x, y) != Tetrominoes.NoShape) {
        return false;
      }
    }
    
    currentShape = newPiece;
    currentX = newX;
    currentY = newY;
    
    return true;
  }
  
  private void removeFullLines() {
    
    int numFullLines = 0;
    
    for (int row = 0; row < BOARD_HEIGHT; row++) {
      boolean lineIsFull = true;
      for (int col = 0; col < BOARD_WIDTH; col++) {
        if (shapeAt(col, row) == Tetrominoes.NoShape) {
          lineIsFull = false;
          break;
        }
      }
      
      if (lineIsFull) {
        numFullLines++;
        
        for (int y = row; y > 0; y--) {
          for (int x = 0; x < BOARD_WIDTH; x++) {
            board[(y * BOARD_WIDTH) + x] = shapeAt(x, y - 1);
          }
        }
      }
    }
      
    if (numFullLines > 0) {
      isFallingFinished = true;
      currentShape.setShape(Tetrominoes.NoShape);
    }
  }
  
}
