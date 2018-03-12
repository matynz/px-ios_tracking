//
//  MPTDevice.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 6/1/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class MPTDevice: NSObject {
    let model: String
    let os: String
    let systemVersion: String
    let screenSize: String
    let resolution: String
    var uuid: String
    override init() {
        self.model = UIDevice.current.model
        self.os =  "iOS"
        self.systemVersion = UIDevice.current.systemVersion
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.screenSize = String(describing: screenWidth) + "x" + String(describing: screenHeight)
        self.resolution = String(describing: UIScreen.main.scale)
        self.uuid = ""
    }
    
    open func toJSON() -> [String:Any] {
        
        if let targetUuid = UIDevice.current.identifierForVendor?.uuidString {
            self.uuid = targetUuid
        }
        
        let obj: [String:Any] = [
            "model": model,
            "os": os,
            "system_version": systemVersion,
            "screen_size": screenSize,
            "resolution": resolution,
            "uuid": uuid
        ]
        return obj
    }
    open func toJSONString() -> String {
        return JSONHandler.jsonCoding(self.toJSON())
    }
}

class MPTApplication: NSObject {
    let checkoutVersion: String
    let platform: String
    let flowId: String
    let environment: String
    init(checkoutVersion: String, platform: String, flowId: String, environment: String) {
        self.checkoutVersion = checkoutVersion
        self.platform = platform
        self.flowId = flowId
        self.environment = environment
    }
    open func toJSON() -> [String:Any] {
        let obj: [String:Any] = [
            FlowService.FLOW_ID_KEY: flowId,
            "version": checkoutVersion,
            "platform": platform,
            "environment": environment
        ]
        return obj
    }
    open func toJSONString() -> String {
        return JSONHandler.jsonCoding(self.toJSON())
    }
}

class ScreenTrackInfo {

    var screenName: String
    var screenId: String
    var timestamp: Int64
    var type: String
    var metadata: [String:Any]
    init(screenName: String, screenId: String, metadata: [String:Any]) {
        self.screenName = screenName
        self.screenId = screenId
        self.metadata = metadata
        for key in metadata.keys {
            if metadata[key] == nil {
                self.metadata.removeValue(forKey: key)
            }
        }

        let date = Date()
        self.timestamp = Date().getCurrentMillis()
        self.type = "screenview"
    }
    func toJSON() -> [String:Any] {
        var obj: [String:Any] = [
            "timestamp": self.timestamp,
            "type": self.type,
            "screen_id": self.screenId,
            "screen_name": self.screenName,
            "metadata": self.metadata
        ]
        return obj
    }
    init(from json: [String:Any]) {

        self.screenName = json["screen_name"] as! String
        self.screenId = json["screen_id"] as! String
        self.timestamp = json["timestamp"] as! Int64
        self.type = json["type"] as! String
        self.metadata = json["metadata"] as! [String:Any]
    }
    func toJSONString() -> String {
        return JSONHandler.jsonCoding(self.toJSON())
    }
}

extension Date {
    public func getCurrentMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }

    static public func from(millis: Int64) -> Date {
        let timeInterval: TimeInterval = Double(millis) / 1000
        return Date(timeIntervalSince1970: timeInterval)
    }
}
