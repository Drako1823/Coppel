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
    lazy var selection: typeMovies = .popular

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovies(option: .popular, withLoader: true)
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
    
    
    @IBAction func btnProfile(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let viewProfile = UIAlertAction(title: "View Profile", style: .default) { (action) in
            print("didPress report abuse")
            self.performSegue(withIdentifier: "SHOWPROFILEVC", sender: nil)
        }
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            print("didPress block")
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("didPress cancel")
        }
        actionSheet.addAction(viewProfile)
        actionSheet.addAction(logOut)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func sgTapMovies(_ sender: UISegmentedControl) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? DetailMovieViewController, let iRowSelected = sender as? Int {
            let movieSelected = vmMovies.getSelectedMovie(movieSelected: iRowSelected)
            vc.iId = movieSelected?.iId ?? 0
            if selection == .popular || selection == .topRated{
                vc.typeDetailMovies = .movie
                vc.loadMovie()
            }else {
                vc.typeDetailMovies = .tv
                vc.loadTV()
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SENDDETAILMOVIEWVC", sender: indexPath.row)
        
    }
}
