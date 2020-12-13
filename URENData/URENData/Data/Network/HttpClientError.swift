//
//  HttpClientError.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation

public enum HttpClientError: Error {
    case server(Error)
    case missingResponseData
    case deserialization(Error)
    case unknown(Error)
}

extension HttpClientError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .server(let error):
            return "Connection error: \(error)"
        case .missingResponseData:
            return "No valid HTTP response from server"
        case .deserialization(let error):
            return "Error during deserialization of the response: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unknown error occurred: \(error.localizedDescription)"
        }
    }
}

extension HttpClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .server(let error):
            return "Oops!. Someting went wrong. Make sure your device is connected to the internet. \(error.localizedDescription)"
        case .missingResponseData:
            return "Oops!. Someting went wrong. Can't receive data from server."
        case .deserialization(_):
            return "Oops!. Someting went wrong. Can't receive valid data from server."
        case .unknown(let error):
            return "Oops!. Someting went wrong. \(error.localizedDescription)"
        }
    }
}
