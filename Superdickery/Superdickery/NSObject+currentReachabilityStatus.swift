//
//  NSObject+currentReachabilityStatus.swift
//  Superdickery
//
//  Created by Mike Miksch on 10/16/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import Foundation
import SystemConfiguration

// Code by Jad on StackOverflow (https://stackoverflow.com/users/3953581/jad)
// Original work can be found in answer to this question: https://stackoverflow.com/questions/39558868/check-internet-connection-ios-10

protocol Utilities {
}

extension NSObject : Utilities {
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            return .notReachable
        } else if flags.contains(.isWWAN) == true {
            return .reachableViaWWAN
        }         else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            return .reachableViaWiFi
        } else {
            return .notReachable
        }
    }
    
}
