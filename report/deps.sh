#sudo apt install graphviz
#dart pub global activate lakos
#dart pub global activate pubviz
#dart pub global activate layerlens

PATH_REPORT=../report
PUBVIZ_IGNORE=path_provider_android,material_color_utilities,http_multi_server,connectivity_plus_platform_interface,url_launcher_windows,url_launcher_macos,url_launcher_web,url_launcher_linux,url_launcher_ios,url_launcher_android,nm,super_text_layout,attributed_text,dbus,args,characters,xml,petitparser,cached_network_image_platform_interface,shelf_web_socket,web_socket_channel,typed_data,boolean_selector,test_api,path_provider_foundation,path_provider_linux,path_provider_windows,protobuf,path_provider_platform_interface,win32,ffi,plugin_platform_interface,webkit_inspection_protocol,stream_transform,source_map_stack_trace,coverage,source_gen,cached_network_image_web,flutter_web_plugins,dart_code_metrics_presets,frontend_server_client,fast_immutable_collections,bloc,analyzer_plugin,analyzer,_fe_analyzer_shared,test,bloc_test,meta,collection,crypto,html,path,test_core,async,source_span,string_scanner,stack_trace,flutter_test,logging,dio,ansicolor,build,build_config,build_runner,build_runner_core,build_resolvers,build_daemon,flutter,built_value,url_launcher_platform_interface,flutter_cache_manager,flutter_localizations,intl,wa_api_gen,cupertino_icons,flutter_bloc,get_it,bloc,equatable,flutter_chat_ui,uuid,shelf_packages_handler,json_serializable,dart_code_metrics,go_router_builder,go_router,flutter_link_previewer,path_provider,pub_updater,super_editor,url_launcher,dio_cookie_manager,centrifuge,fake_async,built_value_generator,freezed_annotation,built_collection,http,connectivity_plus,cached_network_image,freezed,flutter_lints,shelf_static,cookie_jar,pretty_dio_logger,formz
PUBVIZ_PARAMS="-p"
LAKOS_IGNORE="{lib/injection_container.*,test/**,bin/**}"
LAKOS_PARAMS="--metrics --no-cycles-allowed"
DOT_PARAMS=-Gsplines=ortho
#-Tpng -Gdpi=200
#lakos --metrics . dot -Tpdf -o ../report/deps_lakos.pdf

rm *.pdf
rm *.dot

function createReport {
    REPORT_POSTFIX=$1
    lakos $LAKOS_PARAMS -i $LAKOS_IGNORE . -o $PATH_REPORT/lakos_output_$REPORT_POSTFIX.dot
    dot -Tpdf $DOT_PARAMS $PATH_REPORT/lakos_output_$REPORT_POSTFIX.dot -o $PATH_REPORT/deps_lakos_$REPORT_POSTFIX.pdf&
    pubviz $PUBVIZ_PARAMS --format=dot -i $PUBVIZ_IGNORE print > $PATH_REPORT/pubviz_output_$REPORT_POSTFIX.dot
    dot  -Tpdf $DOT_PARAMS $PATH_REPORT/pubviz_output_$REPORT_POSTFIX.dot -o $PATH_REPORT/deps_pubviz_$REPORT_POSTFIX.pdf&
}

## declare an array variable
declare -a arr=("backend" "common" "config_app" "dslideshow_flutter")

## now loop through the above array
for i in "${arr[@]}"
do
    echo "Parsing '$i'"
    cd ../$i
    createReport $i
done
echo "Done"

# You can access them using echo "${arr[0]}", "${arr[1]}" also

#layerlens
# pubviz -i $PUBVIZ_IGNORE open