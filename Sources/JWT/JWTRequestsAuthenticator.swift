//
//  JWTAuthenticator.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation

/// An Authenticator for URL Requests which makes use of the RequestAdapter from Alamofire.
final class JWTRequestsAuthenticator {

    private var token: JWT.Token
    
    init(token: JWT.Token) {
        self.token = token
    }
}

extension JWTRequestsAuthenticator {
    struct TokenExpired: Error {}
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard !token.isExpired else {
            throw TokenExpired()
        }
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
