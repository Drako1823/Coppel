//
//  TokenViewModel.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import Foundation

final class TokenViewModel : Decodable{
    typealias CompletionBlock = (NSError) -> Void
    private var serviceManager : Webservice?
    
    init(_ serviceManager : Webservice = Webservice()){
        self.serviceManager = serviceManager
    }
    
    private var apiKey: apiKey?
    
    required init(from decoder: Decoder) throws {}

    func getTokenKey(option: typeMovies,bShowLoader: Bool = false, withCompletionHandler handler: @escaping CompletionBlock){
        
        var resource = Resource<apiKey>("\(option.rawValue)","", .baseCore)
        resource.httpMethod = .get
        resource.showProgress = bShowLoader
        serviceManager?.load(resource: resource){ [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let apiKey, let error):
                self.apiKey = apiKey
                print(apiKey)
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            case .failure(let error):
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            }
        }
    }

}
