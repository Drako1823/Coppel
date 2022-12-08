//
//  ViewController.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import UIKit

class MoviesHomeViewController: UIViewController {
    @IBOutlet weak var sgMovies: UISegmentedControl!{
        didSet{
            sgMovies.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        }
    }
    @IBOutlet weak var cllMovies: UICollectionView! {
        didSet {
            cllMovies.register(UINib(nibName: "MoviesCollectionViewCell", bundle: Bundle(for: MoviesCollectionViewCell.self)), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        }
    }
    
    lazy var vmMovies = MoviesViewModel()
    lazy var vmToken = TokenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovies(option: .popular, withLoader: true)
        //        getToken()
    }
    
    func getToken() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.vmToken.getTokenKey(option: .apiKey, bShowLoader: true) { [weak self] error in
                guard let self = self else { return }
                if error.code.isSuccess{
                    self.present(AlertGeneric.simpleWith(message: "Se genero un token correcto: \(error.code.description) "), animated: true, completion: nil)
                    
                }else{
                    self.present(AlertGeneric.simpleWith(message: "Se genero un error en el token: \(error.code.description) "), animated: true, completion: nil)
                }
            }
        }
    }
    
    func loadMovies(option: typeMovies, withLoader: Bool){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.vmMovies.loadAllMovies(option: option,bShowLoader: withLoader) { [weak self] error in
                guard let self = self else { return }
                if error.code.isSuccess{
                    self.cllMovies.reloadData()
                }else{
                    self.present(AlertGeneric.simpleWith(message: "Se genero un error: \(error.code.description) "), animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func btnProfile(_ sender: UIButton) {
        print("Send to profile")
    }
    
    @IBAction func sgTapMovies(_ sender: UISegmentedControl) {
        var selection: typeMovies = .popular
        switch sender.selectedSegmentIndex {
        case 0:
            selection = .popular
            break
        case 1:
            selection = .topRated
            break
        case 2:
            selection = .onTv
            break
        case 3:
            selection = .airingToday
            break
        default:
            break
        }
        loadMovies(option: selection, withLoader: true)
    }
    
}

extension MoviesHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vmMovies.getNumberRowsMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        cell.customCell(movie: vmMovies.getSelectedMovie(movieSelected: indexPath.row))
        cell.backgroundColor = UIColor.rgb(red: 28, green: 39, blue: 44)
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.size.width / 2.3, height: 370)
    }
}
