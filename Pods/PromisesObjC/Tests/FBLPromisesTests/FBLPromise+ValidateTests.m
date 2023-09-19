/**
 Copyright 2018 Google Inc. All rights reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at:

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "FBLPromise+Validate.h"

#import <XCTest/XCTest.h>

#import "FBLPromise+Async.h"
#import "FBLPromise+Catch.h"
#import "FBLPromise+Testing.h"
#import "FBLPromise+Then.h"
#import "FBLPromisesTestHelpers.h"

@interface FBLPromiseValidateTests : XCTestCase
@end

@implementation FBLPromiseValidateTests

- (void)testPromiseValidateTrue {
  // Act.
  FBLPromise<NSNumber *> *promise =
      [[[[FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock __unused _) {
        FBLDelay(0.1, ^{
          fulfill(@42);
        });
      }] validate:^BOOL(NSNumber *value) {
        return value.integerValue == 42;
      }] catch:^(NSError __unused *_) {
        XCTFail();
      }] then:^id(NSNumber *value) {
        XCTAssertEqualObjects(value, @42);
        return value;
      }];

  // Assert.
  XCTAssert(FBLWaitForPromisesWithTimeout(10));
  XCTAssertEqualObjects(promise.value, @42);
  XCTAssertNil(promise.error);
}

- (void)testPromiseValidateFalse {
  // Act.
  FBLPromise<NSNumber *> *promise =
      [[[[FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock __unused _) {
        FBLDelay(0.1, ^{
          fulfill(@42);
        });
      }] validate:^BOOL(NSNumber *value) {
        return value.integerValue != 42;
      }] then:^id(NSNumber __unused *_) {
        XCTFail();
        return nil;
      }] catch:^(NSError *error) {
        XCTAssertTrue(FBLPromiseErrorIsValidationFailure(error));
      }];

  // Assert.
  XCTAssert(FBLWaitForPromisesWithTimeout(10));
  XCTAssertTrue(FBLPromiseErrorIsValidationFailure(promise.error));
  XCTAssertNil(promise.value);
}

/**
 Promise created with `validate` should not deallocate until it gets resolved.
 */
- (void)testPromiseValidateNoDeallocUntilResolved {
  // Arrange.
  FBLPromise *promise = [FBLPromise pendingPromise];
  FBLPromise __weak *weakExtendedPromise1;
  FBLPromise __weak *weakExtendedPromise2;

  // Act.
  @autoreleasepool {
    XCTAssertNil(weakExtendedPromise1);
    XCTAssertNil(weakExtendedPromise2);
    weakExtendedPromise1 = [promise validate:^BOOL(id __unused _) {
      return YES;
    }];
    weakExtendedPromise2 = [promise validate:^BOOL(id __unused _) {
      return YES;
    }];
    XCTAssertNotNil(weakExtendedPromise1);
    XCTAssertNotNil(weakExtendedPromise2);
  }

  // Assert.
  XCTAssertNotNil(weakExtendedPromise1);
  XCTAssertNotNil(weakExtendedPromise2);

  [promise fulfill:@42];
  XCTAssert(FBLWaitForPromisesWithTimeout(10));

  XCTAssertNil(weakExtendedPromise1);
  XCTAssertNil(weakExtendedPromise2);
}

@end
