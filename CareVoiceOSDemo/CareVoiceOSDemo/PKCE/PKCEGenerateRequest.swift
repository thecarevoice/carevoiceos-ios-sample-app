//
//  SSORequest.swift
//  iOSClient
//
//  Created by way on 2025/11/19.
//

import Foundation

struct PKCEGenerateParam: Codable {
    let redirectUri: String
    let cvUserUniqueId: String
    let codeChallenge: String
    let codeChallengeMethod: String // "S256", "PLAIN"
    let state: String
}

struct PKCEGenerateRes: Codable {
    let success: Bool
    let code: Int
    let message: String?
    let data: PKCEGenerateDataRes?
}

struct PKCEGenerateDataRes: Codable {
    let deepLink: String
    let expiresAtEpochMilli: Int
    let expiresInSeconds: Int
}

class PKCEGenerateRequest {
    
    static func generateDeepLink(params: PKCEGenerateParam, completion: @escaping (Result<PKCEGenerateRes, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(Config.baseURL)/api/app/auth/deep-link") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch {
            completion(.failure(.requestFailed(error)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(PKCEGenerateRes.self, from: data)
                completion(.success(loginResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        
        task.resume()
    }
}
