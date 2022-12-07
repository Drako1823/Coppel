//
//  moviesCollectionViewCell.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() { super.awakeFromNib() }
    
    func customCell(name:String) {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        self.imgMovie.image = UIImage(named: "imgPlaceHolder")
        self.imgStar.image = UIImage(named: "imgPlaceHolder")

        self.lblName.text = name
        lblDescription.text = "dasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdas"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgMovie.image = nil
        imgStar.image = nil
    }
}
