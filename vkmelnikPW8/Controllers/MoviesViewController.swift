//
//  ViewController.swift
//  vkmelnikPW8
//
//  Created by Vsevolod Melnik on 21.03.2022.
//

import UIKit

class MoviesViewController: UIViewController, MoviesViewProtocol {
    
    var moviesView: MoviesListView?
    var movies: [Movie]?
    private let apiKey = "8254e1ec81190a4724ab08c28f6224d3"
    var session: URLSessionDataTask?
    let sessionGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.loadMovies()
        }
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
    
    func search(_ search: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in self?.loadMovies(search.replacingOccurrences(of: " ", with: "+"))
        }
    }
    
    private func loadMovies(_ search: String = "") {
        guard let url = URL(string:
                                search.isEmpty
                                ?"https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ruRu"
                                :"https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=ruRu&query=\(search)") else {
            return assertionFailure("some problems with url")
        }
        sessionGroup.wait()
        sessionGroup.enter()
        session?.cancel()
        session = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, _ in
            guard
                let data = data,
                let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any], // .json5Allowed not available.
                let results = dict["results"] as? [[String: Any]] else { return }
            let movies: [Movie] = results.map { params in
                let title = params["title"] as! String
                let imagePath = params["poster_path"] as? String
                return Movie(title: title, posterPath: imagePath)
            }
            
            self.loadImagesForMovies(movies) { movies in
                self.movies = movies
                DispatchQueue.main.async {
                    self.moviesView?.tableView.reloadData()
                }
            }
        })
        
        session!.resume()
        sessionGroup.leave()
    }
    
    private func loadImagesForMovies(_ movies: [Movie], completion: @escaping ([Movie]) -> Void) {
        let group = DispatchGroup()
        for movie in movies {
            group.enter()
            DispatchQueue.global(qos: .background).async {
                movie.loadPoster { _ in
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            completion(movies)
        }
    }

}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieView.identifier, for: indexPath) as! MovieView
        cell.configure(movie: movies?[indexPath.row] ?? Movie(title: "Ошибка загрузки", posterPath: nil))
        return cell
    }
    
    
}
