/*
 *     Copyright 2016 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */


import XCTest
import SimpleHttpClient
import SwiftyJSON
@testable import BluemixPushNotifications


class BluemixPushNotificationsTests: XCTestCase {


    override func setUp() {
        super.setUp()
    }


    override func tearDown() {
        super.tearDown()
    }


    // MARK: - PushNotifications tests


    func testPushNotificationsInitializer(){

        let pushExample = PushNotifications(bluemixRegion: PushNotifications.Region.US_SOUTH, bluemixAppGuid: "abcd", bluemixAppSecret: "1234")

        XCTAssertEqual(pushExample.headers["Content-Type"], "application/json")
        XCTAssertEqual(pushExample.headers["appSecret"], "1234")

        // Note: The HttpResource cannot be checked for validity since none of its properties can be accessed (they are all internal to SimpleHttpClient)
    }


    // MARK: - Notification tests


    // MARK: With values


    func testNotificationJsonFormatWithValues() {
        let notificationJson = notificationExample.jsonFormat
        let expectedJson = notificationExampleJson
        XCTAssertEqual(notificationJson, expectedJson)
		XCTAssertNotNil(try? notificationJson?.rawData())
    }


    func testMessageJsonFormatWithValues() {
        let messageJson = messageExample.jsonFormat
        let expectedJson = messageExampleJson
        XCTAssertEqual(messageJson, expectedJson)
		XCTAssertNotNil(try? messageJson?.rawData())
    }


    func testTargetJsonFormatWithValues() {
        let targetJson = targetExample.jsonFormat
        let expectedJson = targetExampleJson
        XCTAssertEqual(targetJson, expectedJson)
		XCTAssertNotNil(try? targetJson?.rawData())
    }


    func testApnsJsonFormatWithValues() {
        let apnsJson = apnsExample.jsonFormat
        let expectedJson = apnsExampleJson
        XCTAssertEqual(apnsJson, expectedJson)
		XCTAssertNotNil(try? apnsJson?.rawData())
    }


    func testGcmJsonFormatWithValues() {
        let gcmJson = gcmExample.jsonFormat
        let expectedJson = gcmExampleJson
        XCTAssertEqual(gcmJson, expectedJson)
		XCTAssertNotNil(try? gcmJson?.rawData())
    }

    // MARK: With Nil


    func testNotificationJsonWithNil() {
        let emptyMessage = Notification.Message(alert: nil, url: nil)
        let notification = Notification(message: emptyMessage, target: nil, apnsSettings: nil, gcmSettings: nil)
        XCTAssertNil(notification.jsonFormat)
    }

    func testMessageJsonWithNil() {
        let emptyMessage = Notification.Message(alert: nil, url: nil)
        XCTAssertNil(emptyMessage.jsonFormat)
    }


    func testTargetJsonWithNil() {
        let emptyTarget = Notification.Target(deviceIds: nil, userIds: nil, platforms: nil, tagNames: nil)
        XCTAssertNil(emptyTarget.jsonFormat)
    }


    func testApnsJsonFormatWithNil() {

        let emptyApns = Notification.Settings.Apns(badge: nil, category: nil, iosActionKey: nil, sound: nil, type: nil, payload: nil)
        XCTAssertNil(emptyApns.jsonFormat)
    }


    func testGcmJsonFormatWithNil() {

        let emptyGcm = Notification.Settings.Gcm(collapseKey: nil, delayWhileIdle: nil, payload: nil, priority: nil, sound: nil, timeToLive: nil)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
	
}


// MARK: - Notification examples

let gcmExample = Notification.Settings.Gcm(collapseKey: "a", delayWhileIdle: false, payload: "c", priority: GcmPriority.DEFAULT, sound: "e", timeToLive: 1.0)
let gcmExampleJson = JSON(["collapseKey": "a", "delayWhileIdle": "false", "payload": "c", "priority": "DEFAULT", "sound": "e", "timeToLive": 1.0])

let apnsExample = Notification.Settings.Apns(badge: 0, category: "a", iosActionKey: "b", sound: "c", type: ApnsType.DEFAULT, payload: ["c": ["d": "e"]])
#if os(Linux)
    let apnsExampleJson = JSON(["badge": 0, "category": "a", "iosActionKey": "b", "sound": "c", "type": "DEFAULT", "payload": ["c": ["d": "e"]]] as [String: Any])
#else
    let apnsExampleJson = JSON(["badge": 0, "category": "a", "iosActionKey": "b", "sound": "c", "type": "DEFAULT", "payload": ["c": ["d": "e"]]])
#endif

let targetExample = Notification.Target(deviceIds: ["a"], userIds: ["u"], platforms: [TargetPlatform.Apple, TargetPlatform.Google], tagNames: ["c"])
let targetExampleJson = JSON(["deviceIds": ["a"], "userIds": ["u"], "platforms": ["A", "G"], "tagNames": ["c"]])

let messageExample = Notification.Message(alert: "a", url: "b")
let messageExampleJson = JSON(["alert": "a", "url": "b"])

let notificationExample = Notification(message: messageExample, target: targetExample, apnsSettings: apnsExample, gcmSettings: gcmExample)
let notificationExampleJson = JSON(["message": messageExampleJson, "target": targetExampleJson, "settings": JSON(["apns": apnsExampleJson, "gcm": gcmExampleJson])])



// MARK: - Linux requirement

extension BluemixPushNotificationsTests {
    static var allTests : [(String, (BluemixPushNotificationsTests) -> () throws -> Void)] {
        return [
			("testPushNotificationsInitializer", testPushNotificationsInitializer),
			("testApnsJsonFormatWithValues", testApnsJsonFormatWithValues),
			("testGcmJsonFormatWithValues", testGcmJsonFormatWithValues),
			("testMessageJsonFormatWithValues", testMessageJsonFormatWithValues),
            ("testTargetJsonFormatWithValues", testTargetJsonFormatWithValues),
            ("testNotificationJsonFormatWithValues", testNotificationJsonFormatWithValues),
            ("testNotificationJsonWithNil", testNotificationJsonWithNil),
            ("testMessageJsonWithNil", testMessageJsonWithNil),
            ("testTargetJsonWithNil", testTargetJsonWithNil),
            ("testApnsJsonFormatWithNil", testApnsJsonFormatWithNil),
            ("testGcmJsonFormatWithNil", testGcmJsonFormatWithNil),
        ]
    }
}
