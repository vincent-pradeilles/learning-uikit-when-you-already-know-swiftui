//
//  MovieDetailsViewController.swift
//  LearningUIKit
//
//  Created by Vincent on 04/03/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    let viewModel: MovieDetailsViewModel
    
    init(with movie: Movie) {
        self.viewModel = MovieDetailsViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var overViewLabel: UILabel = {
        let overViewLabel = UILabel()
        overViewLabel.translatesAutoresizingMaskIntoConstraints = false
        overViewLabel.numberOfLines = 0
        return overViewLabel
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var creditsTableView: UITableView = {
        let creditsTableView = UITableView()
        creditsTableView.translatesAutoresizingMaskIntoConstraints = false
        creditsTableView.dataSource = self
        creditsTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "MovieCast"
        )
        creditsTableView.tableHeaderView = headerView
        return creditsTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.poster.onUpdate = { [weak self] posterImage in
            self?.posterImageView.image = posterImage
        }
        
        viewModel.cast.onUpdate = { [weak self] _ in
            self?.creditsTableView.reloadData()
        }
        
        overViewLabel.text = viewModel.movie.overview
        
        viewModel.fetchData()
    }
    
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.navigationItem.title = viewModel.movie.title
        
        NSLayoutConstraint.activate(
            [
                headerView.heightAnchor.constraint(
                    equalToConstant: 230
                ),
                headerView.widthAnchor.constraint(
                    equalTo: creditsTableView.widthAnchor
                )
            ]
        )
        
        self.headerView.addSubview(posterImageView)
        NSLayoutConstraint.activate(
            [
                posterImageView.leadingAnchor.constraint(
                    equalTo: headerView.safeAreaLayoutGuide.leadingAnchor,
                    constant: 8
                ),
                posterImageView.topAnchor.constraint(
                    equalTo: headerView.safeAreaLayoutGuide.topAnchor
                ),
                posterImageView.widthAnchor.constraint(
                    equalToConstant: 155
                ),
                posterImageView.heightAnchor.constraint(
                    equalToConstant: 220
                ),
            ]
        )
        
        self.headerView.addSubview(overViewLabel)
        NSLayoutConstraint.activate(
            [
                overViewLabel.leadingAnchor.constraint(
                    equalTo: posterImageView.trailingAnchor,
                    constant: 8
                ),
                overViewLabel.topAnchor.constraint(
                    equalTo: posterImageView.topAnchor
                ),
                overViewLabel.trailingAnchor.constraint(
                    equalTo: headerView.trailingAnchor,
                    constant: -8
                ),
                overViewLabel.bottomAnchor.constraint(
                    lessThanOrEqualTo: posterImageView.bottomAnchor
                )
            ]
        )
        
        self.view.addSubview(creditsTableView)
        NSLayoutConstraint.activate(
            [
                creditsTableView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor
                ),
                creditsTableView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor
                ),
                creditsTableView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor
                ),
                creditsTableView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor
                )
            ]
        )
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.cast.value.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieCast",
            for: indexPath
        )
        let castMember = viewModel.cast.value[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = castMember.name
        content.textProperties.font = .preferredFont(forTextStyle: .headline)
        content.secondaryText = castMember.character
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = content
        
        return cell
    }
}
