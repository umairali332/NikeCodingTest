//
//  AlbumViewController.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 21/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit
import Combine

final class AlbumViewController: UITableViewController {
    private lazy var dataSource = makeDataSource()
    private var cancellable: [AnyCancellable] = []
    private let appear = PassthroughSubject<Void, Never>()
    private let selection = PassthroughSubject<Int, Never>()
    private let viewModel: AlbumViewModel
    
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        appear.send(())
    }

    private func configureUI() {
        definesPresentationContext = true
        title = "Albums"

        tableView.tableFooterView = UIView()
        tableView.registerClass(cellClass: AlbumTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        refreshControl = .init()
        refreshControl?.addTarget(self, action: #selector(refreshControlDidStart), for: .valueChanged)
    }
    
    @objc func refreshControlDidStart() {
        appear.send(())
    }
    private func bindViewModel() {
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
        
        let input = AlbumViewModelInput(appear: appear.eraseToAnyPublisher(),
                                               selection: selection.eraseToAnyPublisher())

        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellable)
    }

    private func render(_ state: AlbumViewModelState) {
        switch state {
        case .loading:
            tableView.refreshControl?.beginRefreshing()
            update(with: [], animate: true)
        case .noResults:
            tableView.refreshControl?.endRefreshing()
            update(with: [], animate: true)
        case .show(let albums):
            tableView.refreshControl?.endRefreshing()
            update(with: albums, animate: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection.send(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

fileprivate extension AlbumViewController {
    enum Section: CaseIterable {
        case albums
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, AlbumRowViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, albumRowViewModel in
                let cell: AlbumTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(with: albumRowViewModel)
                return cell
            }
        )
    }
    
    func update(with movies: [AlbumRowViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, AlbumRowViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(movies, toSection: .albums)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
