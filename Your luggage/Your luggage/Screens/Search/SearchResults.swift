//
//  SearchResults.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/9/21.
//

import UIKit
import SnapKit

protocol SearchResultCellProtocol: UITableViewCell {
    associatedtype ViewModel
    func configureCell(with viewModel: ViewModel)
}

final class SearchResults<Cell: SearchResultCellProtocol>:
        BaseViewController<SearchResultsViewModel<Cell.ViewModel>>,
        UITableViewDataSource,
        UITableViewDelegate {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .limeGreen
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        viewModel.reloadData = { [weak tableView] in
            tableView?.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.searchResultViewModel(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        cell.configureCell(with: cellModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didDeselectSearchResult(at: indexPath)
    }
}
