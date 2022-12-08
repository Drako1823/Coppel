//
//  DetailMovieViewController.swift
//  coppelTestApp
//
//  Created by El Reymon . on 07/12/22.
//

import UIKit

class DetailMovieViewController: UIViewController {
    @IBOutlet weak var imgMovie: UIImageView!{
        didSet{
            imgMovie.contentMode = .redraw
            imgMovie.translatesAutoresizingMaskIntoConstraints = false
            imgMovie.layer.cornerRadius = 10
            imgMovie.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnHomePage: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblLanguajes: UILabel!
    @IBOutlet weak var cllCompanies: UICollectionView!{
        didSet {
            cllCompanies.delegate = self
            cllCompanies.dataSource = self
            cllCompanies.register(UINib(nibName: "MovieDetailCollectionViewCell", bundle: Bundle(for: MovieDetailCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieDetailCollectionViewCell")
        }
    }
    @IBOutlet weak var lblProduction: UILabel!
    
    @IBOutlet weak var nslBottom: NSLayoutConstraint!
    
    @IBOutlet weak var ds: UIImageView!
    
    lazy var iId :Int = 0
    lazy var vmDetailMovie = DetailMovieViewModel()
    lazy var typeDetailMovies : typeDetail = .movie
    lazy var homePage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgb(red: 28, green: 39, blue: 44)
    }
    
    func loadMovie() {
        self.vmDetailMovie.getDetailMovie(idMovie: iId, bShowLoader: true) { [weak self] error in
            guard let self = self else { return }
            if error.code.isSuccess{
                self.typeDetailMovies = .movie
                self.loadInfoMovie()
                self.cllCompanies.reloadData()
            }else{
                self.present(AlertGeneric.simpleWith(message: "Se genero un error en el token: \(error.code.description) "), animated: true, completion: nil)
            }
        }
    }
    
    func loadTV() {
        self.vmDetailMovie.getDetailTV(idTV: iId, bShowLoader: true ) { [weak self] error in
            guard let self = self else { return }
            if error.code.isSuccess{
                self.typeDetailMovies = .tv
                self.loadInfoTV()
                self.cllCompanies.reloadData()
            }else{
                self.present(AlertGeneric.simpleWith(message: "Se genero un error en el token: \(error.code.description) "), animated: true, completion: nil)
            }
        }
    }
    
    func loadInfoTV() {
        let tvDetail = vmDetailMovie.getDetailTV()
        self.imgMovie.loadImage(withName: tvDetail?.strImage ?? "")
        lblTitle.text = "Nombre: \(tvDetail?.strTitle ?? "")"
        lblCategory.text = tvDetail?.bAdult ?? false ? "Adultos":"Publico en General"
        lblDescription.text = ((tvDetail?.strOverview?.count ?? 0) != 0) ? "Descripcion: \(tvDetail?.strOverview ?? "")": ""
        if tvDetail?.strHomepage == "" {
            btnHomePage.isHidden = true
        }
        homePage = tvDetail?.strHomepage ?? ""
        lblDate.text = "Primera emision al aire: \(tvDetail?.strDate ?? "")"
        
        var genreText = ""
        tvDetail?.arrGenres?.forEach({
            genreText = "\(genreText)\($0.strName ?? ""), "
        })
        genreText = String(genreText.dropLast(2))
        lblGenres.text = "\(lblGenres.text ?? ""): \(genreText)"
        var languajeText = ""
        tvDetail?.arrLanguajes?.forEach({
            languajeText = "\(languajeText)\($0.strEnglishName ?? ""), "
        })
        languajeText = String(languajeText.dropLast(2))
        lblLanguajes.text = "\(lblLanguajes.text ?? ""): \(languajeText)"
        
        if tvDetail?.arrCompanies?.count == 0{
            lblProduction.isHidden = true
            nslBottom.constant = 10
        }
    }
    
    
    func loadInfoMovie() {
        let movieDetail = vmDetailMovie.getDetailMovie()
        self.imgMovie.loadImage(withName: movieDetail?.strImage ?? "")
        lblTitle.text = "Nombre: \(movieDetail?.strTitle ?? "")"
        lblCategory.text = movieDetail?.bAdult ?? false ? "Adultos":"Publico en General"
        lblDescription.text = ((movieDetail?.strOverview?.count ?? 0) != 0) ? "Descripcion: \(movieDetail?.strOverview ?? "")": ""
        if movieDetail?.strHomepage == "" {
            btnHomePage.isHidden = true
        }
        homePage = movieDetail?.strHomepage ?? ""
        lblDate.text = "Fecha de lanzamiento: \(movieDetail?.strDate ?? "")"
        
        var genreText = ""
        movieDetail?.arrGenres?.forEach({
            genreText = "\(genreText)\($0.strName ?? ""), "
        })
        genreText = String(genreText.dropLast(2))
        lblGenres.text = "\(lblGenres.text ?? ""): \(genreText)"
        var languajeText = ""
        movieDetail?.arrLanguajes?.forEach({
            languajeText = "\(languajeText)\($0.strEnglishName ?? ""), "
        })
        languajeText = String(languajeText.dropLast(2))
        lblLanguajes.text = "\(lblLanguajes.text ?? ""): \(languajeText)"
        
        if movieDetail?.arrCompanies?.count == 0{
            lblProduction.isHidden = true
            nslBottom.constant = 10
        }
    }
    
    @IBAction func btnHomePage(_ sender: UIButton) {
        let vcWebSite = WebSiteViewController()
        vcWebSite.strTitle = "WebSite"
        vcWebSite.urlLoad = homePage
        self.navigationController?.present(vcWebSite, animated: true, completion: nil)
    }
    
}

extension DetailMovieViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch typeDetailMovies {
        case .movie:
            let movieDetail = vmDetailMovie.getDetailMovie()

            return movieDetail?.arrCompanies?.count ?? 0
        
        case .tv:
            let tvDetail = vmDetailMovie.getDetailTV()

            return tvDetail?.arrCompanies?.count ?? 0 //vmMovies.getNumberRowsMovies()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCollectionViewCell", for: indexPath) as? MovieDetailCollectionViewCell else { return UICollectionViewCell() }
        switch typeDetailMovies {
            
        case .movie:
            let movieDetail = vmDetailMovie.getDetailMovie()
            cell.createCard(name: movieDetail?.arrCompanies?[indexPath.row].strName ?? "", imagen: movieDetail?.arrCompanies?[indexPath.row].aLogo ?? "")
            cell.backgroundColor = UIColor.rgb(red: 28, green: 39, blue: 44)
            return cell
            
        case .tv:
            let tvDetail = vmDetailMovie.getDetailTV()
            cell.createCard(name: tvDetail?.arrCompanies?[indexPath.row].strName ?? "", imagen: tvDetail?.arrCompanies?[indexPath.row].aLogo ?? "")
            cell.backgroundColor = UIColor.rgb(red: 28, green: 39, blue: 44)
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:150, height: 100)
    }
}
