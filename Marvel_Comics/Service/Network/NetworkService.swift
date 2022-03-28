//
//  NetworkService.swift
//  Marvel_Comics
//
//  Created by Richardier on 22/03/2022.
//

import Alamofire

class NetworkService {
    
    // MARK: - Properties
    
    private let session: Session
    private let baseUrl = "https://gateway.marvel.com/v1/public/comics?"
    private let timeStamp = "ts=1&"
    private let apiKey = "apikey=\(APIKeys.publicKey)&"
    private let hash = "hash=\(APIKeys.hash)&"
    private let limit = "limit=100"
    
    // MARK: - Methods
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func fetchData(completion: @escaping (Result<ComicsInfo, AFError>) -> Void) {
        let url = baseUrl + timeStamp + apiKey + hash + limit
        print(url)
        session.request(url).validate().responseDecodable(of: ComicsInfo.self) { (response) in // creating a data request from the encoded url
            completion(response.result)
        }
    }
}

