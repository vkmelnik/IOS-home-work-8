//
//  MoviesListView.swift
//  vkmelnikPW8
//
//  Created by Vsevolod Melnik on 21.03.2022.
//

import UIKit

class MoviesListView: UIView {
    
    var tableView = UITableView()
    private let controller: MoviesViewProtocol!

    init(frame: CGRect, controller: MoviesViewProtocol) {
        self.controller = controller
        
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(tableView)
        tableView.pin(to: self)
        tableView.backgroundColor = .clear
        tableView.dataSource = controller
        tableView.delegate = controller
        tableView.register(MovieView.self, forCellReuseIdentifier: MovieView.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
