//
//  HttpClient.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/1/20.
//

import Foundation
import URENCombine
import URENDomain

public final class HttpClient: HttpClientProvider {
    
    public static let shared = HttpClient()
    
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    
    public init() {
        session = URLSession(configuration: .default)
        jsonDecoder = JSONDecoder()
    }
    
    public func execute<T>(convertible: UrlRequestConvertible) -> Future<T, Error> where T : Model {
        return Future { [unowned self] (promise) in
            
            let request = convertible.asURLRequest()
            
            let task = self.session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    promise(.failure(HttpClientError.server(error)))
                }
                
                guard let data = data,
                      let urlResponse = response as? HTTPURLResponse,
                      (200...299).contains(urlResponse.statusCode) else {
                    promise(.failure(HttpClientError.missingResponseData))
                    return
                }
                
                do {
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    promise(.success(responseModel))
                } catch let parseError {
                    promise(.failure(HttpClientError.deserialization(parseError)))
                }
            }
            
            task.resume()
        }
    }
}
