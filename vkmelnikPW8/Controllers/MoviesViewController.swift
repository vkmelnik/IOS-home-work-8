//
//  ViewController.swift
//  vkmelnikPW8
//
//  Created by Vsevolod Melnik on 21.03.2022.
//

import UIKit

class MoviesViewController: UIViewController, MoviesViewProtocol {
    
    var moviesView: MoviesListView?
    private let apiKey = "8254e1ec81190a4724ab08c28f6224d3"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        DispatchQueue.global(qos: .background).async { [weak self] in self?.loadMovies() }
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
    
    private func loadMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ruRu") else {
            return assertionFailure("some problems with url")
        }
        let session = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, _ in
            
        })
        
        session.resume()
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
