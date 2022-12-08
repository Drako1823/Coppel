//
//  moviesCollectionViewCell.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!{
        didSet{
            imgMovie.contentMode = .redraw
            imgMovie.translatesAutoresizingMaskIntoConstraints = false
            imgMovie.layer.cornerRadius = 10
            imgMovie.layer.masksToBounds = true

        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
        
    override func awakeFromNib() { super.awakeFromNib() }
    
    func customCell(movie:movieSection?) {
        self.imgMovie.loadImage(withName: movie?.strBackdrop ?? "")
        layer.cornerRadius = 10
        layer.masksToBounds = true
        self.lblName.text = movie?.strTitle ?? movie?.strOriginalTitle ?? movie?.strName ?? movie?.strOriginalName
        self.lblDate.text = movie?.strDate ?? movie?.strfirstAirDate
        self.lblScore.text = "★ \(movie?.iVoteAverage ?? 0.0)"
        self.lblDescription.text = movie?.strOverview
        lblName.textColor = UIColor.rgb(red: 0, green: 255, blue: 0)
        lblDate.textColor = UIColor.rgb(red: 0, green: 255, blue: 0)
        lblScore.textColor = UIColor.rgb(red: 0, green: 255, blue: 0)
        lblDescription.textColor = UIColor.rgb(red: 255, green: 255, blue: 255)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgMovie.image = nil
    }
}
