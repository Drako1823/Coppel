//
//  MovieDetailCollectionViewCell.swift
//  coppelTestApp
//
//  Created by El Reymon . on 07/12/22.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCompanie: UIImageView!{
        didSet{
            imgCompanie.contentMode = .redraw
            imgCompanie.translatesAutoresizingMaskIntoConstraints = false
            imgCompanie.layer.cornerRadius = 10
            imgCompanie.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() { super.awakeFromNib() }
    
    func createCard(name:String,imagen:String) {
        self.lblName.text = name
        self.imgCompanie.loadImage(withName: imagen, withPlaceHolder: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgCompanie.image = nil
    }

}
