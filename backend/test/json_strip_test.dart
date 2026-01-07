import 'package:dslideshow_backend/config.dart';
import 'package:test/test.dart';

void main() {
  group('stripDefaults', () {
    test('Removes simple fields (String, int, bool) if they match defaults', () {
      final json = {
        'name': 'Alex',
        'age': 25,
        'isAdmin': false,
      };
      final defaults = {
        'name': 'Alex', // match -> remove
        'age': 18,      // diff -> keep
        'isAdmin': false, // match -> remove
      };

      final result = stripDefaults(json, defaults);

      expect(result, equals({'age': 25}));
    });

    test('Preserves fields that do not exist in defaults', () {
      final json = {
        'id': 100, // not in defaults
        'name': 'Alex',
      };
      final defaults = {
        'name': 'Alex',
      };

      final result = stripDefaults(json, defaults);

      expect(result, equals({'id': 100}));
    });

    test('Handles null values correctly', () {
      final json = {'desc': null, 'title': 'Test'};
      final defaults = {'desc': null, 'title': null};

      final result = stripDefaults(json, defaults);

      // desc: null == null -> remove
      // title: 'Test' != null -> keep
      expect(result, equals({'title': 'Test'}));
    });

    test('Removes Lists if they are identical', () {
      final json = {
        'tags': ['a', 'b'],
        'ids': [1, 2, 3],
      };
      final defaults = {
        'tags': ['a', 'b'], // match
        'ids': [1, 2],      // diff length
      };

      final result = stripDefaults(json, defaults);

      expect(result, equals({'ids': [1, 2, 3]}));
    });

    test('Recursion: Removes parent key if nested object matches completely', () {
      final json = {
        'settings': {
          'theme': 'dark',
          'sound': true,
        },
        'other': 1
      };
      final defaults = {
        'settings': {
          'theme': 'dark',
          'sound': true,
        },
        'other': 1
      };

      final result = stripDefaults(json, defaults);

      expect(result, isEmpty);
    });

    test('Recursion: Preserves parent key if nested object has differences', () {
      final json = {
        'settings': {
          'theme': 'light', // diff
          'sound': true,    // match
        }
      };
      final defaults = {
        'settings': {
          'theme': 'dark',
          'sound': true,
        }
      };

      final result = stripDefaults(json, defaults);

      // 'sound' removed, 'theme' kept -> 'settings' kept
      expect(result, equals({
        'settings': {'theme': 'light'}
      }));
    });

    test('Complex nested scenario', () {
      final json = {
        'user': {
          'meta': {'v': 1, 'flag': 'A'},
          'data': [1, 2]
        },
        'active': true
      };
      
      final defaults = {
        'user': {
          'meta': {'v': 1, 'flag': 'B'}, // flag diff
          'data': [1, 2] // data match
        },
        'active': true // match
      };

      final result = stripDefaults(json, defaults);

      expect(result, equals({
        'user': {
          'meta': {'flag': 'A'}
        }
      }));
    });
  });
}