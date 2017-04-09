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
        
        let notificationOldJson = notificationExampleOld.jsonFormat
        let expectedOldJson = notificationExampleOldJson
        XCTAssertEqual(notificationOldJson, expectedOldJson)
        XCTAssertNotNil(try? notificationOldJson?.rawData() as Any)
        
        let notificationJson = notificationExample.jsonFormat
        let expectedJson = notificationExampleJson
        XCTAssertEqual(notificationJson, expectedJson)
		XCTAssertNotNil(try? notificationJson?.rawData() as Any)
    }


    func testMessageJsonFormatWithValues() {
        
        let messageOldJson = messageExampleOld.jsonFormat
        let expectedOldJson = messageExampleOldJson
        XCTAssertEqual(messageOldJson, expectedOldJson)
        XCTAssertNotNil(try? messageOldJson?.rawData() as Any)
        
        let messageJson = messageExample.jsonFormat
        let expectedJson = messageExampleJson
        XCTAssertEqual(messageJson, expectedJson)
		XCTAssertNotNil(try? messageJson?.rawData() as Any)
    }


    func testTargetJsonFormatWithValues() {
        
        let targetoldJson = targetExampleOld.jsonFormat
        let expectedOldJson = targetExampleOldJson
        XCTAssertEqual(targetoldJson, expectedOldJson)
        XCTAssertNotNil(try? targetoldJson?.rawData() as Any)
        
        let targetJson = targetExample.jsonFormat
        let expectedJson = targetExampleJson
        XCTAssertEqual(targetJson, expectedJson)
		XCTAssertNotNil(try? targetJson?.rawData() as Any)
    }


    func testApnsJsonFormatWithValues() {

        let apnsOldJson = apnsExampleOld.jsonFormat
        let expectedOldJson = apnsExampleOldJson
        XCTAssertEqual(apnsOldJson, expectedOldJson)
        XCTAssertNotNil(try? apnsOldJson?.rawData() as Any)
        
        let apnsJson = apnsExample.jsonFormat
        let expectedJson = apnsExampleJson
        XCTAssertEqual(apnsJson, expectedJson)
		XCTAssertNotNil(try? apnsJson?.rawData() as Any)
    }


    func testGcmJsonFormatWithValues() {
        
        let gcmOldJson = gcmExampleOld.jsonFormat
        let expectedOldJson = gcmExampleOldJson
        XCTAssertEqual(gcmOldJson, expectedOldJson)
        XCTAssertNotNil(try? gcmOldJson?.rawData() as Any)
        
        let gcmJson = gcmExample.jsonFormat
        let expectedJson = gcmExampleJson
        XCTAssertEqual(gcmJson, expectedJson)
		// XCTAssertNotNil(try? gcmJson.rawData() as Any)
    }

    func testSafariJsonFormatWithValues() {
        let safariJson = safariExample.jsonFormat
        let expectedJson = safariExampleJson
        XCTAssertEqual(safariJson, expectedJson)
        XCTAssertNotNil(try? safariJson?.rawData() as Any)
    }
    
    func testFirefoxJsonFormatWithValues() {
        let fireFoxJson = firefoxExample.jsonFormat
        let expectedJson = firefoxExampleJson
        XCTAssertEqual(fireFoxJson, expectedJson)
        XCTAssertNotNil(try? fireFoxJson?.rawData() as Any)
    }
    
    func testChromeAppExJsonFormatWithValues() {
        let chromeAppExtJson = chromeAppExtExample.jsonFormat
        let expectedJson = chromeAppExtExampleJson
        XCTAssertEqual(chromeAppExtJson, expectedJson)
        XCTAssertNotNil(try? chromeAppExtJson?.rawData() as Any)
    }
    
    func testChromeJsonFormatWithValues() {
        let chromeJson = chromeExample.jsonFormat
        let expectedJson = chromeExampleJson
        XCTAssertEqual(chromeJson, expectedJson)
        XCTAssertNotNil(try? chromeJson?.rawData() as Any)
    }
    
    // MARK: With Nil


    func testNotificationJsonWithNil() {
        
        
        let emptyMessageOld = Notification.Message(alert: nil, url: nil)
        let notificationOld = Notification(message: emptyMessageOld, target: nil, apnsSettings: nil, gcmSettings: nil)
        XCTAssertNil(notificationOld.jsonFormat)
        
        let messageBuilder = MessageBuilder(build: {
            
            $0.alert = nil
            $0.url =  nil
            
        })
        let emptyMessage = Notification.Message(messageBuilder: messageBuilder)
      
        
        let settingsBuilder = SettingsBuilder(build: {
            
            $0.apns = nil
            $0.gcm = nil
            $0.safari = nil
            $0.firefox = nil
            $0.chromeAppExtension = nil
            $0.chrome = nil
            
        })
        
        let notification = Notification(message: emptyMessage, target: nil, settingsBuilder: settingsBuilder)
        XCTAssertNil(notification.jsonFormat)
    }

    func testMessageJsonWithNil() {
        
        let emptyMessageOld = Notification.Message(alert: nil, url: nil)
        XCTAssertNil(emptyMessageOld.jsonFormat)
        
        let messageBuilder = MessageBuilder(build: {
            
            $0.alert = nil
            $0.url =  nil
            
        })
        let emptyMessage = Notification.Message(messageBuilder: messageBuilder)
        XCTAssertNil(emptyMessage.jsonFormat)
    }


    func testTargetJsonWithNil() {
        
        let emptyTargetOld = Notification.Target(deviceIds: nil, userIds: nil, platforms: nil, tagNames: nil)
        XCTAssertNil(emptyTargetOld.jsonFormat)
        
        let targetBuilder = TargetBuilder(build: {
            
            $0.deviceIds = nil
            $0.userIds =  nil
            $0.platforms = nil
            $0.tagNames = nil
            
        })

        let emptyTarget = Notification.Target(targetBuilder: targetBuilder)
        XCTAssertNil(emptyTarget.jsonFormat)
    }
    

    func testApnsJsonFormatWithNil() {
        
        let emptyApnsOld = Notification.Settings.Apns(badge: nil, category: nil, iosActionKey: nil, sound: nil, type: nil, payload: nil)
        XCTAssertNil(emptyApnsOld.jsonFormat)
        
        let settingsBuilder = SettingsBuilder(build:{
            $0.apnsBuilder = ApnsBuilder(build: {
                
                $0.badge = nil
                $0.interactiveCategory=nil
                $0.iosActionKey=nil
                $0.sound=nil
                $0.type=nil
                $0.payload=nil
                $0.titleLocKey=nil
                $0.locKey=nil
                $0.launchImage=nil
                $0.titleLocArgs = nil
                $0.locArgs=nil
                $0.subtitle=nil
                $0.title=nil
                $0.attachmentUrl=nil
            })
        })

        let emptyApns = Notification.Settings.Apns(apnsBuilder:settingsBuilder.apnsBuilder)
        XCTAssertNil(emptyApns.jsonFormat)
    }


    func testGcmJsonFormatWithNil() {
       
        let emptyGcmOld = Notification.Settings.Gcm(collapseKey: nil, delayWhileIdle: nil, payload: nil, priority: nil, sound: nil, timeToLive: nil)
        XCTAssertNil(emptyGcmOld.jsonFormat)
        
        let settingsBuilder = SettingsBuilder(build: {
            $0.gcmBuilder = GcmBuilder(build: {
                
                $0.collapseKey = nil
                $0.delayWhileIdle = nil
                $0.payload = nil
                $0.priority = nil
                $0.sound = nil
                $0.timeToLive = nil
                $0.icon = nil
                $0.sync = nil
                $0.visibility = nil
                $0.style = nil
                $0.lights = nil
            })
        })
        
        let emptyGcm = Notification.Settings.Gcm(gcmBuilder:settingsBuilder.gcmBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
    
    func testSafariJsonFormatWithNil() {
        
        let settingsBuilder = SettingsBuilder(build: {
            $0.safariBuilder = SafariBuilder(build: {
                
                $0.title = nil
                $0.urlArgs = nil
                $0.action = nil
                
            })
        })
        
        let emptyGcm = Notification.Settings.Safari(safariBuilder:settingsBuilder.safariBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
    
    func testFirefoxJsonFormatWithNil() {
        
        let settingsBuilder = SettingsBuilder(build: {
            $0.firefoxBuilder = FirefoxBuilder(build: {
                
                $0.title = nil
                $0.iconUrl = nil
                $0.timeToLive = nil
                $0.payload = nil
                
            })
        })
        
        let emptyGcm = Notification.Settings.Firefox(firefoxBuilder:settingsBuilder.firefoxBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }

func testChromeAppExtJsonFormatWithNil() {
        
        let settingsBuilder = SettingsBuilder(build: {
            $0.chromeAppExtBuilder = ChromAppExtBuilder(build: {
                
                $0.collapseKey = nil
                $0.delayWhileIdle = nil
                $0.title = nil
                $0.iconUrl = nil
                $0.timeToLive = nil
                $0.payload = nil
                
                
            })
        })
        
        let emptyGcm = Notification.Settings.ChromAppExtension(chromeAppExtBuilder:settingsBuilder.chromeAppExtBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
    
    func testChromeJsonFormatWithNil() {
        
        let settingsBuilder = SettingsBuilder(build: {
            $0.chromeBuilder = ChromeBuilder(build: {
                
                $0.title = nil
                $0.iconUrl = nil
                $0.timeToLive = nil
                $0.payload = nil
                
            })
        })
        
        let emptyGcm = Notification.Settings.Chrome(chromeBuilder:settingsBuilder.chromeBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
}


// MARK: - Notification examples

// MARK: - Old API

let gcmExampleOld = Notification.Settings.Gcm(collapseKey: "a", delayWhileIdle: false, payload: ["c":["d":"e"]], priority: GcmPriority.DEFAULT, sound: "e", timeToLive: 1.0)
let gcmExampleOldJson = JSON(["collapseKey": "a", "delayWhileIdle": "false", "payload": ["c":["d":"e"]], "priority": "DEFAULT", "sound": "e", "timeToLive": 1.0])

let apnsExampleOld = Notification.Settings.Apns(badge: 0, category: "a", iosActionKey: "b", sound: "c", type: ApnsType.DEFAULT, payload: ["c": ["d": "e"]])

let apnsExampleOldJson = JSON(["badge": 0, "category": "a", "iosActionKey": "b", "sound": "c", "type": "DEFAULT", "payload": ["c": ["d": "e"]]])

let targetExampleOld = Notification.Target(deviceIds: ["a"], userIds: ["u"], platforms: [TargetPlatform.Apple, TargetPlatform.Google], tagNames: ["c"])
let targetExampleOldJson = JSON(["deviceIds": ["a"], "userIds": ["u"], "platforms": ["A", "G"], "tagNames": ["c"]])

let messageExampleOld = Notification.Message(alert: "a", url: "b")
let messageExampleOldJson = JSON(["alert": "a", "url": "b"])

let notificationExampleOld = Notification(message: messageExample, target: targetExample, apnsSettings: apnsExample, gcmSettings: gcmExample)
let notificationExampleOldJson = JSON(["message": messageExampleJson, "target": targetExampleJson, "settings": JSON(["apns": apnsExampleJson, "gcm": gcmExampleJson])])


// MARK: - New API



let settingsBuilder = SettingsBuilder(build: {
    $0.gcmBuilder = GcmBuilder(build: {
        
        $0.collapseKey = "a"
        $0.delayWhileIdle = false
        $0.payload = ["c": ["d": "e"]]
        $0.priority = GcmPriority.DEFAULT
        $0.sound = "e"
        $0.timeToLive = 1.0
        $0.icon = "g"
        $0.sync = false
        $0.visibility = Visibility.PUBLIC
        $0.style = Notification.Settings.GcmStyle(gcmStyleBuilder:GcmStyleBuilder(build: {
            
            $0.type = GcmStyleTypes.BIGTEXT_NOTIFICATIION
            $0.title = "title"
            $0.url = "url"
            $0.text = "text"
            $0.lines = ["lines"]
        })).jsonFormat
        $0.lights = Notification.Settings.GcmLights(gcmLightsBuilder: GcmLightsBuilder(build:{
            
            $0.ledArgb = GcmLED.BLACK
            $0.ledOnMs = 2
            $0.ledOffMs = 2
            
        })).jsonFormat
    })
    
    $0.apnsBuilder = ApnsBuilder(build: {
        
        $0.badge = 0
        $0.interactiveCategory = "a"
        $0.iosActionKey = "b"
        $0.sound = "c"
        $0.type = ApnsType.DEFAULT
        $0.payload = ["c":["d":"e"]]
        $0.titleLocKey = "f"
        $0.locKey = "g"
        $0.launchImage = "h"
        $0.titleLocArgs = ["i"]
        $0.locArgs = ["j"]
        $0.subtitle = "k"
        $0.title = "l"
        $0.attachmentUrl = "m"
    })
    
    
        $0.safariBuilder = SafariBuilder(build: {
            
            $0.title = "a"
            $0.urlArgs = ["b"]
            $0.action = "c"
            
        })
    
        $0.firefoxBuilder = FirefoxBuilder(build: {
            
            $0.title = "a"
            $0.iconUrl = "b"
            $0.timeToLive = 1.0
            $0.payload = ["c":["d":"e"]]
            
        })
    
    $0.chromeAppExtBuilder = ChromAppExtBuilder(build: {
        
        $0.collapseKey = "a"
        $0.delayWhileIdle = false
        $0.title = "b"
        $0.iconUrl = "c"
        $0.timeToLive = 1.0
        $0.payload = ["c":["d":"e"]]
        
        
    })
    
    $0.chromeBuilder = ChromeBuilder(build: {
        
        $0.title = "a"
        $0.iconUrl = "b"
        $0.timeToLive = 1.0
        $0.payload = ["c":["d":"e"]]
        
    })
    
})

let safariExample = Notification.Settings.Safari(safariBuilder:settingsBuilder.safariBuilder)
let safariExampleJson = JSON(["title": "a", "urlArgs": ["b"], "action": "c"])

let firefoxExample = Notification.Settings.Firefox(firefoxBuilder:settingsBuilder.firefoxBuilder)
let firefoxExampleJson = JSON(["title": "a", "iconUrl": "b", "timeToLive": 1.0, "payload": ["c":["d":"e"]]])

let chromeAppExtExample = Notification.Settings.ChromAppExtension(chromeAppExtBuilder:settingsBuilder.chromeAppExtBuilder)
let chromeAppExtExampleJson = JSON(["collapseKey": "a", "delayWhileIdle": "false", "title": "b", "iconUrl": "c", "timeToLive": 1.0,"payload": ["c":["d":"e"]]])

let chromeExample = Notification.Settings.Chrome(chromeBuilder:settingsBuilder.chromeBuilder)
let chromeExampleJson = JSON(["title": "a", "iconUrl": "b", "timeToLive": 1.0,"payload": ["c":["d":"e"]]])

let gcmExample = Notification.Settings.Gcm(gcmBuilder:settingsBuilder.gcmBuilder)
let gcmExampleJson = JSON(["collapseKey": "a", "delayWhileIdle": "false", "payload": ["c":["d":"e"]], "priority": "DEFAULT", "sound": "e", "timeToLive": 1.0, "icon": "g", "sync": "false", "visibility": "PUBLIC", "style": ["type": "BIGTEXT_NOTIFICATIION", "title" : "title", "url": "url", "text" : "text", "lines": ["lines"]], "lights":  ["ledArgb": "BLACK", "ledOnMs": 2, "ledOffMs": 2] ])

let apnsExample = Notification.Settings.Apns(apnsBuilder:settingsBuilder.apnsBuilder)

let apnsExampleJson = JSON(["badge": 0, "interactiveCategory": "a", "iosActionKey":"b", "sound": "c", "type": "DEFAULT", "payload": ["c": ["d": "e"]], "titleLocKey": "f", "locKey": "g", "launchImage": "h",
    "titleLocArgs": ["i"], "locArgs": ["j"], "subtitle": "k", "title": "l", "attachmentUrl": "m"])

let targetBuilder = TargetBuilder(build: {
    
    $0.deviceIds = ["a"]
    $0.userIds =  ["u"]
    $0.platforms = [TargetPlatform.Apple, TargetPlatform.Google,TargetPlatform.WebChrome, TargetPlatform.WebFirefox, TargetPlatform.WebSafari, TargetPlatform.AppextChrome, ]
    $0.tagNames = ["c"]
    
})

let targetExample = Notification.Target(targetBuilder: targetBuilder)

let targetExampleJson = JSON(["deviceIds": ["a"], "userIds": ["u"], "platforms": ["A", "G", "WEB_CHROME", "WEB_FIREFOX", "WEB_SAFARI", "APPEXT_CHROME"], "tagNames": ["c"]])

let messageBuilder = MessageBuilder(build: {
    
    $0.alert = "a"
    $0.url =  "b"

})

let messageExample = Notification.Message(messageBuilder: messageBuilder)
let messageExampleJson = JSON(["alert": "a", "url": "b"])


let settingsBuilder1 = SettingsBuilder(build: {
    
    $0.apns = apnsExample
    $0.gcm = gcmExample
    $0.safari = safariExample
    $0.firefox = firefoxExample
    $0.chromeAppExtension = chromeAppExtExample
    $0.chrome = chromeExample
    
})

let notificationExample = Notification(message: messageExample, target: targetExample, settingsBuilder:settingsBuilder1)
let notificationExampleJson = JSON(["message": messageExampleJson, "target": targetExampleJson, "settings": JSON(["apns": apnsExampleJson, "gcm": gcmExampleJson, "safariWeb": safariExampleJson, "firefoxWeb": firefoxExampleJson, "chromeAppExt": chromeAppExtExampleJson, "chromeWeb":chromeExampleJson])])

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
