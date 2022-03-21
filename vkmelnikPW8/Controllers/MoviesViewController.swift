//
//  ViewController.swift
//  vkmelnikPW8
//
//  Created by Vsevolod Melnik on 21.03.2022.
//

import UIKit

class MoviesViewController: UIViewController, MoviesViewProtocol {
    
    var moviesView: MoviesListView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    private func configureUI() {
        let moviesView = MoviesListView(frame: view.frame, controller: self)
        view.addSubview(moviesView)
        moviesView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        moviesView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        moviesView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor)
        moviesView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor)
        self.moviesView = moviesView
        moviesView.tableView.reloadData()
    }

}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MovieView()
    }
    
    
}
