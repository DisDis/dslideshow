# Генератор RPC-сериализаторов

Локальный Dart-пакет рядом с `backend/`. Создаёт реализацию общего интерфейса
`Serializers` из единственного списка `@RpcSerializers`. Работает через
`source_gen` и `build_runner`; не участвует в runtime и не создаёт isolate.

## Использование в backend

В `backend/pubspec.yaml` builder подключён только для разработки:

```yaml
dev_dependencies:
  rpc_serializers_generator:
    path: ../rpc_serializers_generator
```

Аннотация находится рядом с runtime-интерфейсом в
`common/lib/serializers.dart`, поэтому потребителям готового реестра
не нужна runtime-зависимость от генератора. Исходник `backend/lib/serializers.dart`:

```dart
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart' show ErrorResult;
import 'package:dslideshow_common/serializers.dart';

part 'serializers.g.dart';

@RpcSerializers([
  EchoCommand,
  EchoCommandResult,
  ErrorResult,
  // Остальные типы протокола.
])
final Serializers serializers = _$serializers;
```

Это сокращённый пример; рабочая аннотация содержит все 57 типов прежнего
реестра. В `backend/build.yaml` область генерации ограничена `lib/serializers.dart`.
Builder автоматически подключает `source_gen:combining_builder` и выполняется
после Freezed, чтобы видеть сгенерированный `toJson`.

Из `backend/`:

```bash
dart pub get
dart run build_runner build
# Непрерывная генерация:
dart run build_runner watch
```

Команда создаёт `serializers.g.dart` вместе с остальными моделями. Этот файл
хранится в Git и обновляется только генератором. Старый
`backend/bin/gen_serializers.dart` больше не используется и удалён.

## Имя класса и протокол

`EchoCommand` в аннотации — ссылка на тип, проверяемая analyzer.
Builder читает объявленное имя класса и записывает строковый литерал
`"EchoCommand"` в сгенерированные ветки кодирования и декодирования:

```dart
if (object is EchoCommand) return ["EchoCommand", object.toJson()];
// При декодировании:
case "EchoCommand": return EchoCommand.fromJson(object);
```

Формат сообщения остаётся `[имяКласса, JSON-объект]`. Проверка `is` поддерживает
Freezed-модели с приватными реализациями и значения, переданные как `Object`.
Префикс импорта (`commands.EchoCommand`) не входит в wire tag.
Ни `Type.toString()`, ни `runtimeType.toString()` во время выполнения не нужны.
Переименование класса **меняет протокол**: согласуйте его со всеми клиентами.
Отдельные alias-теги в этой версии не поддерживаются.

Вложенные модели сериализуются через `toJson`/`fromJson` своих владельцев;
их нужно включать в реестр лишь при самостоятельной передаче в RPC-конверте.
Генератор не заменяет json_serializable или Freezed для отдельных моделей.

## Проверки при генерации

Аннотация применяется к top-level `final`/`const` переменной типа `Serializers`,
инициализированной `_$имяПеременной`. Каждый тип должен быть классом без
параметров типа и typedef, доступным в библиотеке реестра напрямую или через
префикс импорта. Nullable-типы не допускаются.

Класс предоставляет instance `toJson()` с результатом `Map<String, dynamic>`
и конструктор/factory либо статический метод
`fromJson(Map<String, dynamic>)`, возвращающий этот класс. Дополнительные
обязательные аргументы не допускаются. Унаследованный `toJson` поддерживается.

Генерация завершается ошибкой при повторной регистрации, совпадении имён
классов из разных библиотек, отсутствии подходящих JSON-методов или одновременной
регистрации базового класса и его подтипа: проверки `is` для них пересекались бы.
Неизвестный тип при кодировании или неизвестный строковый tag при декодировании
по-прежнему приводит к `ArgumentError`. Проверки входного конверта сохраняют
прежнее поведение backend; изменения валидации протокола в этот builder не входят.

## Локальные проверки

Из `rpc_serializers_generator/`:

```bash
dart pub get
dart analyze
dart test
```

Тесты запускают настоящий builder с combining_builder, компилируют и выполняют
полученный Dart-код. Проверяют строковые имена, префиксы импортов, символ `$`
в имени, redirecting factory, унаследованный `toJson`, пустой реестр,
изменение списка и диагностику некорректных регистраций.

Из `backend/`:

```bash
dart run build_runner build
dart analyze
dart test --concurrency=1
```

`test/serializers_test.dart` закрепляет все 57 прежних wire tags и проверяет
JSON round-trip каждого сообщения, вложенные payload и обработку ошибок.
Существующие RPC/WebSocket-тесты используют этот же сгенерированный реестр.
Тесты генератора также включены в `deb_factory/run_tests.sh` перед backend.
Аппаратная проверка для этого этапа по решению пользователя не выполняется.
