import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization_example/home_screen.dart';

void main() {
  group('Localization Tests', () {
    testWidgets('Displays English title by default', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home:  HomeScreen(onLocaleChange: (_) {}),
      ));
      await tester.pumpAndSettle();

      final loc = AppLocalizations.of(tester.element(find.byType(HomeScreen)))!;
      expect(find.text(loc.title), findsOneWidget);
    });

    testWidgets('Displays Italian title when locale is set to Italian', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('it'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(onLocaleChange: (_) {}),
      ));
      await tester.pumpAndSettle();

      final loc = AppLocalizations.of(tester.element(find.byType(HomeScreen)))!;
      expect(loc.localeName, 'it');
      expect(find.text(loc.title), findsOneWidget);
    });

    testWidgets('Displays Spanish title when locale is set to Spanish', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home:  HomeScreen(onLocaleChange: (_) {}),
      ));
      await tester.pumpAndSettle();

      final loc = AppLocalizations.of(tester.element(find.byType(HomeScreen)))!;
      expect(loc.localeName, 'es');
      expect(find.text(loc.title), findsOneWidget);
    });
  });

  group('Widget Functionality Tests', () {
    testWidgets('Displays subtitle and body text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home:  HomeScreen(onLocaleChange: (_) {}),
      ));
      await tester.pumpAndSettle();

      final loc = AppLocalizations.of(tester.element(find.byType(HomeScreen)))!;
      expect(find.text(loc.subtitle), findsOneWidget);
      expect(find.text(loc.body), findsOneWidget);
    });

    testWidgets('Submits form and displays entered name', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home:  HomeScreen(onLocaleChange: (_) {}),
      ));
      await tester.pumpAndSettle();

      final loc = AppLocalizations.of(tester.element(find.byType(HomeScreen)))!;

      // Enter a name
      const name = 'Test User';
      await tester.enterText(find.byType(TextFormField), name);

      // Tap submit button
      await tester.tap(find.widgetWithText(ElevatedButton, loc.buttonText));
      await tester.pump();

      // Verify the submitted name is displayed
      expect(find.text(loc.textInput(name.trim())), findsOneWidget);
    });

    testWidgets('Clears text field after submission', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home:  HomeScreen(onLocaleChange: (_) {}),
      ));
      await tester.pumpAndSettle();

      final loc = AppLocalizations.of(tester.element(find.byType(HomeScreen)))!;

      // Enter a name
      const name = 'Test User';
      await tester.enterText(find.byType(TextFormField), name);

      // Tap submit button
      await tester.tap(find.widgetWithText(ElevatedButton, loc.buttonText));
      await tester.pump();

      // Verify that the text field is cleared
      expect(find.widgetWithText(TextFormField, name), findsNothing);
    });

    testWidgets('Updates name dynamically', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home:  HomeScreen(onLocaleChange: (_) {}),
      ));
      await tester.pumpAndSettle();

      final loc = AppLocalizations.of(tester.element(find.byType(HomeScreen)))!;

      // First name submission
      const name1 = 'First Name';
      await tester.enterText(find.byType(TextFormField), name1);
      await tester.tap(find.widgetWithText(ElevatedButton, loc.buttonText));
      await tester.pump();

      expect(find.text(loc.textInput(name1.trim())), findsOneWidget);

      // Second name submission
      const name2 = 'Second Name';
      await tester.enterText(find.byType(TextFormField), name2);
      await tester.tap(find.widgetWithText(ElevatedButton, loc.buttonText));
      await tester.pump();

      // Verify new name is displayed and old name is not
      expect(find.text(loc.textInput(name2.trim())), findsOneWidget);
      expect(find.text(loc.textInput(name1.trim())), findsNothing);
    });
  });
}
