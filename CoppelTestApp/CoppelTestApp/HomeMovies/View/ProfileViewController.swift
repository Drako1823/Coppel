//
//  ProfileViewController.swift
//  coppelTestApp
//
//  Created by El Reymon . on 08/12/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var cllProfileFav: UICollectionView!{
        didSet {
//            cllProfileFav.delegate = self
//            cllProfileFav.dataSource = self
//            cllProfileFav.register(UINib(nibName: "MoviesCollectionViewCell", bundle: Bundle(for: MoviesCollectionViewCell.self)), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        }
    }
    
//    lazy var vmMovies = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height / 2
        lblName.text = "Bienvenido: \(UserDefaults.standard.string(forKey: "userName") ?? "")"
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        if let vc = segue.destination as? DetailMovieViewController, let iRowSelected = sender as? Int {
//            let movieSelected = vmMovies.getSelectedMovieLocal(movieSelected: iRowSelected)
//            vc.iId = movieSelected?.iId ?? 0
//
//                vc.loadMovie()
//                vc.loadTV()
//        }
//    }
    
}

//extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        vmMovies.getNumberRowsMoviesLocal()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
//        cell.customCell(movie: vmMovies.getSelectedMovieLocal(movieSelected: indexPath.row))
//        cell.backgroundColor = UIColor.rgb(red: 28, green: 39, blue: 44)
//        cell.layer.shouldRasterize = true
//        cell.layer.rasterizationScale = UIScreen.main.scale
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width:self.view.frame.size.width / 2.3, height: 370)
//    }
//
//    
//}
