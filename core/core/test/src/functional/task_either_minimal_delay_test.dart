import 'package:core/core.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  const Duration minimal = Duration(seconds: 1);

  Option<Either<String, int>> runFor(TaskEither<String, int> task, Duration elapsed) {
    Option<Either<String, int>> result = none();
    fakeAsync((FakeAsync async) {
      task.run().then((Either<String, int> value) => result = some(value));
      async.elapse(elapsed);
    });
    return result;
  }

  test('waits for the minimal duration before completing', () {
    final TaskEither<String, int> task = TaskEither<String, int>.right(42).withMinimalDelay(minimal);

    expect(runFor(task, const Duration(milliseconds: 999)), none<Either<String, int>>());
    expect(runFor(task, minimal), some(right<String, int>(42)));
  });

  test('keeps a failure for the minimal duration too', () {
    final TaskEither<String, int> task = TaskEither<String, int>.left('oups').withMinimalDelay(minimal);

    expect(runFor(task, const Duration(milliseconds: 999)), none<Either<String, int>>());
    expect(runFor(task, minimal), some(left<String, int>('oups')));
  });

  test('does not slow down an operation longer than the minimal duration', () {
    final TaskEither<String, int> task = TaskEither<String, int>(
      () => Future<Either<String, int>>.delayed(const Duration(seconds: 3), () => right(42)),
    ).withMinimalDelay(minimal);

    expect(runFor(task, const Duration(seconds: 3)), some(right<String, int>(42)));
  });

  test('lets a failure through right away on the right-only variant', () {
    final TaskEither<String, int> task = TaskEither<String, int>.left('oups').withMinimalDelayOnRight(minimal);

    expect(runFor(task, Duration.zero), some(left<String, int>('oups')));
  });
}
