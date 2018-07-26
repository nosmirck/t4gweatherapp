import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Automated UI Tests', () {
    FlutterDriver driver;

    setUpAll(
      () async {
        // Connects to the app
        driver = await FlutterDriver.connect();
      },
    );

    tearDownAll(
      () async {
        if (driver != null) {
          // Closes the connection
          driver.close();
        }
      },
    );

    test(
      'Change Temperature',
      () async {
        // Record the performance timeline of things that happen inside the closure
        Timeline timeline = await driver.traceAction(
          () async {
            await driver.waitFor(find.byValueKey('temp-scale-button'));
            expect(find.byValueKey('temp-scale-button'), isNotNull);
            expect(find.byValueKey('celsius-icon'), isNotNull);
            await driver.tap(find.byValueKey('temp-scale-button'));
            expect(find.byValueKey('fahrenheit-icon'), isNotNull);
            await driver.screenshot(timeout: const Duration(seconds: 5));
            await driver.tap(find.byValueKey('temp-scale-button'));
            expect(find.byValueKey('celsius-icon'), isNotNull);
            await driver.screenshot(timeout: const Duration(seconds: 5));
          },
        );

        // The `timeline` object contains all the performance data recorded during
        // the scrolling session. It can be digested into a handful of useful
        // aggregate numbers, such as "average frame build time".
        TimelineSummary summary = new TimelineSummary.summarize(timeline);

        // The following line saves the timeline summary to a JSON file.
        summary.writeSummaryToFile('change_temp_scale', pretty: true);

        // The following line saves the raw timeline data as JSON.
        summary.writeTimelineToFile('change_temp_scale', pretty: true);
      },
    );
  });
}
