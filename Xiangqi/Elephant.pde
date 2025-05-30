public class Elephant extends Piece {

  public Elephant(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(3);
  }
  
  @Override
  public String getPiece() {
    return "Elephant";
  }
  
}
