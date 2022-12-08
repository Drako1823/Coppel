//
//  ServiceManager.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import Foundation

enum ProviderName : String{
    case baseCore = "BASE_URL"
}
enum TypeApiKey : String{
    case normal = "API_KEY"
    case moreLanguage = "API_KEY_LANGUAGE"
}
enum TypePage : String{
    case pageNormal = "&page=1"
    case pageMissing = ""
}

enum HTTPMethod:String{
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}
struct Resource<T : Codable>{
    let url             : URL?
    var httpMethod      : HTTPMethod = .get
    var showProgress    : Bool = false
    var provider        : ProviderName?
    var params          :[String:Any]?
    var domain          : String?
    
    init(_ endpoint : String?,_ page : TypePage = .pageMissing, _ apikeyType: TypeApiKey = .moreLanguage, _ provider: ProviderName = .baseCore){
        guard let serverStringURL = Bundle(for: Webservice.self).object(forInfoDictionaryKey: provider.rawValue) as? String else {
            self.url = nil
            return
        }
        //        ?api_key=c2c11bcd4f8c88a26a997312f05ec5ea&language=en-US
        guard let serverApiKey = Bundle(for: Webservice.self).object(forInfoDictionaryKey: apikeyType.rawValue) as? String else {
            self.url = nil
            return
        }
        let finalURLString = (page.rawValue.count >= 1) ? "\(serverStringURL)\(endpoint ?? "")\(serverApiKey)\(page))" : "\(serverStringURL)\(endpoint ?? "")\(serverApiKey)"
        self.url = URL(string: finalURLString) ?? nil
        self.provider = provider
    }
}
enum GenericResult<T, U: NSError> {
    case success(T, U?)
    case failure(U?)
}

final class Webservice {
    private var serviceError : NSError = NSError(domain: "Recetas", code: -999, userInfo: nil)
    func load<T>(resource: Resource<T>, completion: @escaping (GenericResult<T, NSError>) -> ()) {
        
        if resource.showProgress{
            DispatchQueue.main.async{
                ProgressView.showHUDAddedToWindow()
            }
        }
        
        if !UTReachability.isConnectedToNetwork() {
            DispatchQueue.main.async{
                ProgressView.hideHUDAddedToWindow()
                completion(.failure(NSError(domain: resource.domain ?? "", code: -999, userInfo: ["mensaje" : "No hay conexión a internet"])))
            }
            return
        }
        
        if let url = resource.url{
            var request = URLRequest(url: url)
            request.httpMethod = resource.httpMethod.rawValue
            if let params = resource.params {
                let bodyData = try? JSONSerialization.data(
                    withJSONObject: params,
                    options: []
                )
                request.httpBody = bodyData
            }
            switch resource.provider {
            case .baseCore:
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            case .none:
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else{
                    DispatchQueue.main.async{
                        ProgressView.hideHUDAddedToWindow()
                        completion(.failure(.none))
                    }
                    return
                }
                self.serviceError = self.validateResponseError(response as? HTTPURLResponse ?? nil, resource.domain ?? "", data)
                if let result = try? JSONDecoder().decode(T.self, from: data){
                    DispatchQueue.main.async{
                        ProgressView.hideHUDAddedToWindow()
                        completion(.success(result, self.serviceError))
                    }
                    return
                }else{
                    DispatchQueue.main.async {
                        ProgressView.hideHUDAddedToWindow()
                        completion(.failure(self.serviceError))
                    }
                    return
                }
            }.resume()
        }
    }
    private func validateResponseError(_ response: HTTPURLResponse?, _ domain: String, _ data: Data)-> NSError{
        let dctResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        if let response = response{
            let usrInfo = ["codigo"     : dctResponse?["codigo"],
                           "mensaje"    : dctResponse?["mensaje"],
                           "folio"      : dctResponse?["folio"]]
            return NSError(domain: domain, code: response.statusCode, userInfo: usrInfo as [String : Any])
        }
        return NSError(domain: domain, code: -999, userInfo: nil)
    }
}
