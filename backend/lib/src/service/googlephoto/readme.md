git clone git@github.com:dart-lang/googleapis.git
copy photoslibrary__v1.json ./googleapis/discovery/googleapis/
cd googleapis/discoveryapis_generator
dart pub get
dart ./bin/generate.dart package -i ../discovery/googleapis
# copy package googleapis
copy ./googleapis