//
//  Networking.swift
//  githubviewer
//
//  Created by Luiz Vasconcellos on 25/06/21.
//

import Foundation
import Alamofire

enum ErrorType: Error {
    case requestError
    case notFound
}

final class Networking {
    
    private let baseUrl = "https://api.github.com/users/"
    private let repoEndPoint = "/repos"
    private let cacher = ResponseCacher(behavior: .cache)
    
    internal func getUserRepo(userName: String, completion: @escaping (Result<[Repository], ErrorType>) -> Void) {
        
        AF.request("\(baseUrl)\(userName)\(repoEndPoint)").cacheResponse(using: cacher).validate().responseDecodable(of: [Repository].self) { (response) in
            
            switch response.result {
            case .success:
                guard let repos = response.value else { return }
                completion(.success(repos))
            case .failure( _):
                if response.error?.responseCode == 404 {
                    completion(.failure(.notFound))
                }else {
                    completion(.failure(.requestError))
                }
                return
            }
        }
    }
}
