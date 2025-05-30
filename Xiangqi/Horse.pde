public class Horse extends Piece {

  public Horse(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(5);
  }
  
  @Override
  public String getPiece() {
    return "Horse";
  }
  
}
