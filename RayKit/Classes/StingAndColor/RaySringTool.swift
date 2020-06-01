//
//  SringMD5.swift
//  contract
//
//  Created by admin on 2020/5/23.
//  Copyright © 2020 hjdj. All rights reserved.
//

import UIKit

public extension String{

    var md5Str: String {

        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    // 原始的url编码为合法的url
    func urlEncoded() -> String {
        
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        return encodeUrlString ?? ""
    }

    // 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        
        return self.removingPercentEncoding ?? ""
    }
}
