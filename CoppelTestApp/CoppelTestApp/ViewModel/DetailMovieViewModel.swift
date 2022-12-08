//
//  DetailMovieViewModel.swift
//  coppelTestApp
//
//  Created by El Reymon . on 07/12/22.
//

import Foundation

final class DetailMovieViewModel : Decodable{
    typealias CompletionBlock = (NSError) -> Void
    private var serviceManager : Webservice?
    private let URL_GET_DETAIL_MOVIE = "/movie/"
    private let URL_GET_DETAIL_TV = "/tv/"

    init(_ serviceManager : Webservice = Webservice()){
        self.serviceManager = serviceManager
    }
    
    private var detailMovie: detailMovie?
    private var detailTV: detailTV?

    required init(from decoder: Decoder) throws {}

    func getDetailMovie(idMovie: Int,bShowLoader: Bool = false, withCompletionHandler handler: @escaping CompletionBlock){
        var resource = Resource<detailMovie>("\(URL_GET_DETAIL_MOVIE)\(idMovie)",.pageMissing, .moreLanguage, .baseCore)
        resource.httpMethod = .get
        resource.showProgress = bShowLoader
        serviceManager?.load(resource: resource){ [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let detailMovie, let error):
                self.detailMovie = detailMovie
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            case .failure(let error):
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            }
        }
    }

    func getDetailTV(idTV: Int,bShowLoader: Bool = false, withCompletionHandler handler: @escaping CompletionBlock){
        var resource = Resource<detailTV>("\(URL_GET_DETAIL_TV)\(idTV)",.pageMissing, .moreLanguage, .baseCore)
        resource.httpMethod = .get
        resource.showProgress = bShowLoader
        serviceManager?.load(resource: resource){ [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let detailTV, let error):
                self.detailTV = detailTV
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            case .failure(let error):
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            }
        }
    }
    
    func getDetailMovie() -> detailMovie? {
        return self.detailMovie
    }
    
    func getDetailTV() -> detailTV? {
        return self.detailTV
    }
}
