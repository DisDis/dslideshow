git clone git@github.com:google/googleapis.dart.git

cd googleapis.dart

dart ./generator/bin/generate.dart run_config download --config-file ./config.yaml

download https://photoslibrary.googleapis.com/$discovery/rest?version=v1 and save photoslibrary__v1.json in ./discovery/googleapis/

dart ./generator/bin/generate.dart run_config generate --config-file ./config.yaml

take new generated/googleapis 