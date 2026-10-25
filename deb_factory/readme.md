# Сборка финального DEB

Точка входа — `./build.sh` из этого каталога. Синхронизация frontend/backend,
автоматическое увеличение build-номера и оформление `changelog.md` описаны в
[руководстве выпуска](../doc/releasing.md).

* install md5deep, dpkg-deb
* Create 'source_arm64'
* Create 'source_arm64/flutter-pi/'
* Put special 'flutter-pi' in 'source_arm64/flutter-pi/'
    with dpms support
* Run build.sh
