//
//  RayKeychainTool.swift
//  contract
//
//  Created by admin on 2020/5/23.
//  Copyright © 2020 hjdj. All rights reserved.
//

import UIKit
import KeychainSwift

public class RayKeychainTool: NSObject {
    
    public class func getValue(_ key: String) -> String? {
        
        let keychain = KeychainSwift.init()
        return keychain.get(key)
    }
    
    public class func set(_ value: String, _ key: String) {
        
        let keychain = KeychainSwift.init()
        keychain.set(value, forKey: key)
    }

}
