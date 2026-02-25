//
//  LoginAPI.swift
//  CareVoiceOSDemo
//
//  Created by way on 2025/9/28.
//

import Foundation
import JWTDecode
import CVWellness

struct LoginRes: Codable {
    let success: Bool
    let code: Int
    let message: String?
    let data: TokenData?
}

struct TokenData: Codable {
    let sdk: AuthRes?
}

struct AuthRes: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed
}

class AuthService {
    
    static func login(email: String, password: String, completion: @escaping (Result<LoginRes, NetworkError>) -> Void) {
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        guard let url = URL(string: "\(Config.baseURL)/api/app/auth/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
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
                let loginResponse = try JSONDecoder().decode(LoginRes.self, from: data)
                completion(.success(loginResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        
        task.resume()
    }
    
    static func signup(email: String, password: String, completion: @escaping (Result<LoginRes, NetworkError>) -> Void) {
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        guard let url = URL(string: "\(Config.baseURL)/api/app/auth/register") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
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
                let loginResponse = try JSONDecoder().decode(LoginRes.self, from: data)
                completion(.success(loginResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        
        task.resume()
    }
}

extension AuthService {
    
    static func initSDK(_ completion: @escaping (_ success: Bool) -> Void) {
        guard let accessToken = ProfileManager.shared.authRes?.accessToken,
              let refreshToken = ProfileManager.shared.authRes?.refreshToken,
              let expiresIn = ProfileManager.shared.authRes?.expiresIn,
              let jwt = try? decode(jwt: accessToken),
              let tenant = jwt.body["tenant"] as? String else { return }
                
        let convertExpirationTime = Date().addingTimeInterval(TimeInterval(expiresIn)).timeIntervalSince1970
        CVWellness.configureBaseURL("https://apis.carevoiceos.com")
        CVWellness.setupTenantCode(tenantCode: tenant)
        CVWellness.setupAuthorization(token: accessToken, refreshToken: refreshToken, expirationTime: Int(convertExpirationTime))
        CVWellness.initializeSDK { viewController in
            completion(true)
        }
    }
}
