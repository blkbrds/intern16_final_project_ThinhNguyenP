//
//  Error.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import Foundation
import Alamofire

typealias Network = NetworkReachabilityManager

// MARK: - Network
extension Network {

    static let shared: Network = {
        guard let manager = Network() else {
            fatalError("Cannot alloc network reachability manager!")
        }
        return manager
    }()
}

extension Api {

    struct Error {
        static let network = NSError(domain: NSCocoaErrorDomain, code: -999, message: "Occurred network connection error. Please check your network connection and try again.")
        static let json = NSError(domain: NSCocoaErrorDomain, code: 3_840, message: "The operation couldn’t be completed.")
        static let cancelRequest = NSError(domain: Api.Path.baseURL, code: 999, message: "Server returns no information and closes the connection.")
        static let noResponse = NSError(status: .noResponse)
        static let connectionAbort: NSError = NSError(domain: NSPOSIXErrorDomain, code: 53, message: "Software caused connection abort.")
        static let connectionWasLost: NSError = NSError(domain: NSURLErrorDomain, code: -1_005, message: "The network connection was lost.")
        static let requestTimeOut = NSError(domain: NSCocoaErrorDomain, code: -1001, message: "The request is time out")
    }
}

extension Error {

    func show() {
        let `self` = self as NSError
        self.show()
    }

    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
}

extension NSError {

    func show() { }
}
