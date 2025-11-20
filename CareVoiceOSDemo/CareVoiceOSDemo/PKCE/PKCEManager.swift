//
//  asd.swift
//  iOSClient
//
//  Created by way on 2025/11/19.
//

import Foundation
import CryptoKit
import Security

class PKCEManager {
    static let shared = PKCEManager()
    
    // 生成随机的code_verifier（符合PKCE规范）
    func generateCodeVerifier() -> String {
        var buffer = [UInt8](repeating: 0, count: 32)
        _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer)
        
        let verifier = Data(buffer).base64URLEncodedString()
        
        // 确保长度在43-128字符之间（PKCE规范）
        let length = max(43, min(verifier.count, 128))
        return String(verifier.prefix(length))
    }
    
    // 计算code_challenge（SHA256哈希 + Base64URL编码）
    func generateCodeChallenge(from verifier: String) -> String? {
        guard let verifierData = verifier.data(using: .utf8) else { return nil }
        
        let hash = SHA256.hash(data: verifierData)
        let challengeData = Data(hash)
        
        return challengeData.base64URLEncodedString()
    }
    
    // 生成随机state参数（防CSRF攻击）
    func generateState() -> String {
        var buffer = [UInt8](repeating: 0, count: 16)
        _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer)
        return Data(buffer).base64URLEncodedString()
    }
}

extension Data {
    // Base64URL编码（PKCE规范要求）
    func base64URLEncodedString() -> String {
        return self.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)
    }
}
