//
//  Network.swift
//  
//
//  Created by H G on 2023/05/21.
//

import Foundation

public class Network {
    public static let shared = Network()
    private let decoder: JSONDecoder
    private let urlSession = URLSession.shared

    init() {
        let decoder = JSONDecoder()
        self.decoder = decoder
    }
    
    public func GET<JSONModel: Codable>(method: Method, params: [Param]? = nil) async throws -> JSONModel {
        var request = buildRequest(method, params: params)
        request.httpMethod = "GET"
        let (data, _) = try await urlSession.data(for: request, delegate: nil)
        let object = try decoder.decode(JSONModel.self, from: data)
        return object
    }
    
    private func buildRequest(_ method: Method, params: [Param]?) -> URLRequest {
        let url = Constants.BASE_URL
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "method", value: method.build()),
            URLQueryItem(name: "api_key", value: Constants.API_KEY),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]
        if let params = params {
            components.queryItems?.append(contentsOf: params.map{
                $0.build()
            })
        }
        return URLRequest(url: components.url!)
    }
}
