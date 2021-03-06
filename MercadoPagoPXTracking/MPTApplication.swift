//
//  MPTApplication.swift
//  MercadoPagoPXTracking
//
//  Created by Eden Torres on 3/12/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import Foundation
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
