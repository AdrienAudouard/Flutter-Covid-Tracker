// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:covid_tracker/app/app.dart';
import 'package:covid_tracker/app/resources/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  testWidgets('Display covid page', (WidgetTester tester) async {
    final repository = MockRepository();

    when(repository.fetchTodayData()).thenAnswer((_) => Future.value({
      'actualPositive': {
        'today': {
          'cas': 100,
          'date': '10/01'
        },
        'lastWeek': {
          'cas': 50,
          'date': '03/01'
        },
        'evolution': 10.0
      },
      'mainData': {
        'positivite': {
          '_label': 'label',
          '_value': 10
        },
        'incidence': {
          '_label': 'label',
          '_value': 10
        },
        'saturationRea': {
          '_label': 'label',
          '_value': 10
        },
        'reffectif': {
          '_label': 'label',
          '_value': 10
        },
        'newHospitalisation': {
          'date': 'label',
          'value': 10
        },
        'newReanimation': {
          'date': 'label',
          'value': 10
        },
        'deces': {
          'date': 'label',
          'value': 10
        }
      },
      'dailyCases': {
        'cas': {
          'dates': [],
          'values': [],
        },
        'reanimation': {
          'dates': [],
          'values': [],
        }
      }
    }));

    await tester.pumpWidget(App());

    // Verify that our counter starts at 0.
    expect(find.text('En France'), findsOneWidget);
  });
}
