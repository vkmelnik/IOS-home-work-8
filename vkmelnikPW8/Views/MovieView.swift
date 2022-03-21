//
//  MovieView.swift
//  vkmelnikPW8
//
//  Created by Vsevolod Melnik on 21.03.2022.
//

import UIKit

class MovieView: UITableViewCell {
    
    static let identifier = "MovieCell"
    private let poster = UIImageView()
    private let title = UILabel()
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.identifier)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(poster)
        addSubview(title)
        poster.pinTop(to: self)
        poster.pinLeft(to: self)
        poster.pinRight(to: self)
        poster.setHeight(to: 200)
        
        title.pinTop(to: poster.bottomAnchor, 10)
        title.pinLeft(to: self)
        title.pinRight(to: self)
        title.setHeight(to: 20)
        title.textAlignment = .center
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
