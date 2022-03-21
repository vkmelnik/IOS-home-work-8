//
//  MoviesListView.swift
//  vkmelnikPW8
//
//  Created by Vsevolod Melnik on 21.03.2022.
//

import UIKit

class MoviesListView: UIView {
    
    var tableView = UITableView()
    var searchField = UITextField()
    private let controller: MoviesViewProtocol!
    
    private func configureSearchField() {
        addSubview(searchField)
        searchField.pinTop(to: self)
        searchField.pinLeft(to: self)
        searchField.pinRight(to: self)
        searchField.delegate = self
        searchField.textColor = .black
        searchField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.pinTop(to: searchField.bottomAnchor)
        tableView.pinLeft(to: self)
        tableView.pinRight(to: self)
        tableView.pinBottom(to: self)
        tableView.backgroundColor = .clear
        tableView.dataSource = controller
        tableView.delegate = controller
        tableView.register(MovieView.self, forCellReuseIdentifier: MovieView.identifier)
    }

    init(frame: CGRect, controller: MoviesViewProtocol) {
        self.controller = controller
        super.init(frame: frame)
        self.backgroundColor = .white
        configureSearchField()
        configureTableView()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        controller.search(textField.text ?? "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MoviesListView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        controller.search(textField.text ?? "")
    }
}
