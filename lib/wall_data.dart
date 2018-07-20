// hardcoded some walls
List<WallViewModel> demoWalls = [
  new WallViewModel(
    backdropAssetPath: 'assets/wall1.jpg',
    minGrade: '6A',
    maxGrade: '7C+',
    name: '25 degree wall',
    location: 'Athletica Blindern',
    numBoulders: 45,
    numNewBoulders: 4,
  ),
  new WallViewModel(
    backdropAssetPath: 'assets/wall5.jpeg',
    minGrade: '6B+',
    maxGrade: '8A+',
    name: 'Konkurranseveggen',
    location: 'Klatreverket Torshov',
    numBoulders: 9,
    numNewBoulders: 2,
  ),
  new WallViewModel(
    backdropAssetPath: 'assets/wall6.jpg',
    minGrade: '6A+',
    maxGrade: '8B+',
    name: 'MoonWall',
    location: 'Buldreverket Bryn',
    numBoulders: 130,
    numNewBoulders: 11,
  ),
  new WallViewModel(
    backdropAssetPath: 'assets/wall4.jpg',
    minGrade: '6B',
    maxGrade: '8B',
    name: 'Langveggen',
    location: 'Oslo Klatresenter',
    numBoulders: 36,
    numNewBoulders: 0,
  ),

];




class WallViewModel {
  final String backdropAssetPath;
  final String name;
  final String location;
  final String minGrade;
  final String maxGrade;
  final int numBoulders;
  final int numNewBoulders;

  WallViewModel({
    this.backdropAssetPath,
    this.name,
    this.location,
    this.minGrade,
    this.maxGrade,
    this.numBoulders,
    this.numNewBoulders,
});
}