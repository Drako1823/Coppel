//
//  ViewController.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import UIKit

class MoviesHomeViewController: UIViewController {
    @IBOutlet weak var sgMovies: UISegmentedControl!
    @IBOutlet weak var cllMovies: UICollectionView! {
        didSet {
            cllMovies.register(UINib(nibName: "MoviesCollectionViewCell", bundle: Bundle(for: MoviesCollectionViewCell.self)), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnProfile(_ sender: UIButton) {
        print("Send to profile")
    }
    
    @IBAction func sgTapMovies(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Popular")
            break
        case 1:
            print("Top Rated")
            break
        case 2:
            print("OnTv")
            break
        case 3:
            print("AiringToday")
            break
        default:
            break
        }
    }
    
}

extension MoviesHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        cell.customCell(name: "Prueba")
        cell.backgroundColor = UIColor.rgb(red: 0, green: 102, blue: 102)
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



