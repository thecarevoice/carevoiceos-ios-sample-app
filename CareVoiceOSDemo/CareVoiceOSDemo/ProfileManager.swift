//
//  ProfileManager.swift
//  CareVoiceOSDemo
//
//  Created by way on 2025/9/28.
//

import Foundation
import Defaults

typealias DefaultStorage = Defaults

extension Defaults.Keys {
    static let authRes = Key<TokenData?>("authRes")
}

class ProfileManager {
    
    public static let shared = ProfileManager()
    
    public var authRes: TokenData? {
        didSet {
            DefaultStorage[.authRes] = authRes
        }
    }
    
    private init() {
        authRes = DefaultStorage[.authRes]
    }
    
    func isLogin() -> Bool {
        if let accessToken = authRes?.sdk?.accessToken, !accessToken.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func logout() {
        authRes = nil
    }
}
