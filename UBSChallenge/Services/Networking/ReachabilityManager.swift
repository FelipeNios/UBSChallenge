//
//  ReachabilityManager.swift
//  UBSChallenge
//
//  Created by Felipe Nunez on 5/18/18.
//  Copyright © 2018 FelipeNunez. All rights reserved.
//

import Foundation
import Reachability

/**
 Helper class to determine if the phone have a network connection
 */
class ReachabilityManager {
    
    private let hostnamePing : String = "www.google.com"
    private var reachability: Reachability?
    private var isMonitoring:Bool = false
    
    var isOnline : Bool = true
    static let shared = ReachabilityManager()
    
    private init() {
        self.reachability = Reachability(hostname: hostnamePing)
        
        self.reachability?.whenReachable = { reach in
            self.isOnline = true
        }
        
        self.reachability?.whenUnreachable = { reach in
            self.isOnline = false
        }
    }
    
    func startMonitoring() {
        do {
            if !self.isMonitoring {
                try self.reachability?.startNotifier()
                debugPrint("Monitoring network!")
                self.isMonitoring = true
            }
        } catch {
            debugPrint("Is not posible to start monitoring network.")
        }
    }
    
    func stopMonitoring() {
        self.reachability?.stopNotifier()
        self.isMonitoring = false
        debugPrint("Stop monitoring network!")
    }
}
