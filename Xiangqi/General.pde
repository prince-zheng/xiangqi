public class General extends Piece {

  public General(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(4);
  }
  
  @Override
  public String getPiece() {
    return "General";
  }
  
}
