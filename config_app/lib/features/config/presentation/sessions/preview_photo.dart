/// Fixed, bundled sources for the offline slideshow preview.
enum PreviewPhoto {
  mountainLake('assets/preview/mountain_lake.jpg'),
  forestTrail('assets/preview/forest_trail.jpg'),
  coastalCliffs('assets/preview/coastal_cliffs.jpg');

  final String assetPath;

  const PreviewPhoto(this.assetPath);
}
