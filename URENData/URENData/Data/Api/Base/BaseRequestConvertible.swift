//
//  BaseRequestConvertible.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import Foundation
import URENDomain

public class BaseRequestConvertible<T: Model> {
    private let environment: Environment
    private let method: HttpMethod
    private let path: Endpoints.Paths?
    private let data: T?
    
    private var params: Parameters? {
        return data.asDictionary()
    }
    
    private var headers: Headers? {
        let httpHeaders: [HttpHeader] = []
//        httpHeaders.append(HttpHeader(key: HTTPHeaderFields.contentType.rawValue, value: "application/json; charset=utf-8"))

        let keysAndValues = httpHeaders.map { ($0.key, $0.value) }
        
        return Dictionary(uniqueKeysWithValues: keysAndValues)
    }
    
    public init(environment: Environment,
                method: HttpMethod = .get,
                path: Endpoints.Paths? = nil,
                data: T? = nil) {
        self.environment = environment
        self.method = method
        self.path = path
        self.data = data
    }
    
}

extension BaseRequestConvertible {
    enum HTTPHeaderFields: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
    }
}

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

public protocol UrlRequestConvertible {
    func asURLRequest() -> URLRequest
}

extension BaseRequestConvertible: UrlRequestConvertible {
    public func asURLRequest() -> URLRequest {
        var url = URL(string: environment.host)!
        
        if let path = path {
            url = url.appendingPathComponent(path.path)
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.httpMethod = method.rawValue
        
        if let params = params, !params.isEmpty {
            let isUrlEncodable = [HttpMethod.get].contains(method)
            
            if isUrlEncodable, let urlComponents = generateUrlComponents(from: url, with: params) {
                request.url = urlComponents.url
            } else {
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        
        return request
    }
    
    private func generateUrlComponents(from url: URL, with params: Parameters) -> URLComponents? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        let seperator = "&"
        let queryString = params.map { "\($0)=\($1)" }.joined(separator: seperator)
        let encodedQuery = (urlComponents.percentEncodedQuery.map { $0 + seperator } ?? "") + queryString
        urlComponents.percentEncodedQuery = encodedQuery
        return urlComponents
    }
}

public struct HttpHeader {
    public let key: String
    public let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}


public struct HttpMethod: RawRepresentable, Equatable {
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension HttpMethod {
    public static let get = HttpMethod(rawValue: "GET")
    
    public static let post = HttpMethod(rawValue: "POST")
}

fileprivate extension Encodable {
    func asDictionary() -> Parameters {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)

            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }
}
