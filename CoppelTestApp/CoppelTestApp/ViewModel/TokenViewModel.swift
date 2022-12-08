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
    private var sessionNew: sessionNew?
    private var userName:String = ""
    private var drowssap:String = ""
    
    
    required init(from decoder: Decoder) throws {}
    
    func getTokenKey(option: typeMovies, username:String, drowssap:String, bShowLoader: Bool = false, withCompletionHandler handler: @escaping CompletionBlock){
        
                var resource = Resource<apiKey>("\(option.rawValue)",.pageMissing, .normal, .baseCore)
                resource.httpMethod = .get
                resource.showProgress = bShowLoader
                serviceManager?.load(resource: resource){ [weak self] result in
                    guard let self = self else { return }
                    switch result{
                    case .success(let apiKey, let error):
                        self.apiKey = apiKey
                        UserDefaults.standard.set(apiKey.strToken ?? "", forKey: "apikey")
                        handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
                    case .failure(let error):
                        handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
                    }
                }
        
//        if username == "Ramon" && drowssap == "Coppel1029" {
//            handler(NSError(domain: "Movies", code: 200,userInfo: [
//                NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Bienvenido!!!", comment: "")]))
//        }else {
//            handler(NSError(domain: "Movies", code: 400,userInfo: [
//                NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Invalid username and/or password: You did not provide a valid login", comment: "") ]))
//        }
    }
    
    func getSession(option: typeMovies,bShowLoader: Bool = false, withCompletionHandler handler: @escaping CompletionBlock){
        
        var resource = Resource<sessionNew>("\(option.rawValue)",.pageMissing, .normal, .baseCore)
        resource.httpMethod = .post
        resource.params = ["request_token":"\(UserDefaults.standard.string(forKey: "apikey") ?? "")"]
        resource.showProgress = bShowLoader
        serviceManager?.load(resource: resource){ [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let sessionNew, let error):
                self.sessionNew = sessionNew
                UserDefaults.standard.set(sessionNew.strSession ?? "", forKey: "sessionID")
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            case .failure(let error):
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            }
        }
    }
    
    func loadSessionLocal(username:String, drowssap:String,withCompletionHandler handler: @escaping CompletionBlock) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if username == "Ramon" && drowssap == "Coppel1029" {
                handler(NSError(domain: "Movies", code: 200,userInfo: [
                    NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Bienvenido!!!", comment: "")]))
            }else {
                handler(NSError(domain: "Movies", code: 400,userInfo: [
                    NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Invalid username and/or password: You did not provide a valid login", comment: "") ]))
            }
        }
    }
    
}
