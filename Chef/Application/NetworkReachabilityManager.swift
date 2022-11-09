//
//  NetworkReachabilityManager.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 06/05/22.
//

import Foundation
import Reachability

//MARK:- Notification Name Prefix
fileprivate let notificationKey = "com.chef.utilities.notification.name."


//MARK:- Reachability Notification Name
public extension NSNotification.Name {
    class Network {
        public class var isReachable: NSNotification.Name {
            return NSNotification.Name(rawValue: "\(notificationKey).reachability.isReachable")
        }
        
        public class var isNotReachable: NSNotification.Name {
            return NSNotification.Name(rawValue: "\(notificationKey).reachability.isNotReachable")
        }
    }
}


//MARK:- NetworkReachabilityManager
public class NetworkReachabilityManager {
    
    //MARK:- Public Properties
    public let reachability: Reachability
    public var reachabilityType: Reachability.Connection {
        return self.reachability.connection
    }
    public var isReachable: Bool {
        return self.reachability.connection != .unavailable
    }


    //MARK:- Initializer
    init() throws {
        reachability = try Reachability(hostname: "www.chef.com")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: NSNotification.Name.reachabilityChanged,
            object: reachability
        )
        
        try reachability.startNotifier()
    }

    //MARK:- Private Methods
    @objc
    private func networkStatusChanged(_ notification: NSNotification) {
        // Do something globally here!
        guard let reachability = notification.object as? Reachability else { return }
        if reachability.connection == .unavailable {
            NotificationCenter.default.post(name: NSNotification.Name.Network.isNotReachable, object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.Network.isReachable, object: nil)
        }
    }
}
