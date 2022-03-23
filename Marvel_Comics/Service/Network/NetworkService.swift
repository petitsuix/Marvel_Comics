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
    
    // MARK: - Methods
    init(session: Session = .default) { // Session is .default here but value is changed for API tests
        self.session = session
    }
    
    func fetchData(completion: @escaping (Result<ComicsInfo, AFError>) -> Void) {
        let url = "\(baseUrl)ts=1&apikey=\(APIKeys.publicKey)&hash=\(APIKeys.hash)&limit=100"
        print(url)
        session.request(url).validate().responseDecodable(of: ComicsInfo.self) { (response) in // creating a data request from the encoded url
            completion(response.result)
        }
    }
}

