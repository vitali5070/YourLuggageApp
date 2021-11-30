//
//  TripView.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/1/21.
//

import UIKit
import UIComponents
import SnapKit

final class TripListView: BaseViewController<TripListViewModelProtocol> {
    private enum Constants {
        static let addTripButtonSize = CGSize(width: 150, height: 150)
        static let titleLabelBottomOffsetConstant: CGFloat = -20
        static let barButtonSize = CGSize(width: 36, height: 36)
    }
    
    let tableView = UITableView()
    var navigationTitleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.itemsCount > 0 {
            setupNavigationBarRightButton()
            setupTableView()
        } else {
            setupView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationTitleView.snp.removeConstraints()
        navigationTitleView.removeFromSuperview()
    }
    
    private func setupNavigationBar() {
        let accountButton = ButtonView(viewModel: viewModel.accountNavigationBarButton)
        accountButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.barButtonSize.height)
            make.width.equalTo(Constants.barButtonSize.width)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: accountButton)
        
        navigationTitleView = UIView().setNavigationTitle(title: viewModel.header,
                                                              subTitle: viewModel.headerSubTitle,
                                                              titleTypography: .navigationTitle,
                                                              subTitleTypography: .navigationSubtitle)
    
        navigationTitleView.autoresizingMask = [.flexibleLeftMargin,
                                                .flexibleRightMargin,
                                                .flexibleTopMargin,
                                                .flexibleBottomMargin]
        navigationController?.navigationBar.addSubview(navigationTitleView)
        navigationTitleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
        }
    }
    
    private func setupNavigationBarRightButton() {
        let addTripButton = ButtonView(viewModel: viewModel.addTripButton)
        addTripButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.barButtonSize.height)
            make.width.equalTo(Constants.barButtonSize.width)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addTripButton)
    }
    
    private func setupView() {
        let addTripButton = ButtonView(viewModel: viewModel.addTripButton)
        view.addSubview(addTripButton)
        addTripButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(Constants.addTripButtonSize.height)
            make.width.equalTo(Constants.addTripButtonSize.width)
        }

        let titleLabel = LabelView(viewModel: viewModel.title)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addTripButton.snp_topMargin).offset(Constants.titleLabelBottomOffsetConstant)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.register(TripCellView.self, forCellReuseIdentifier: TripCellView.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin)
            make.leading.equalTo(self.view.snp_leadingMargin)
            make.trailing.equalTo(self.view.snp_trailingMargin)
            make.bottom.equalTo(self.view.snp_bottomMargin)
        }
    }
    
}

// MARK:  - UITableViewDelegate
extension TripListView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension TripListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tripCellViewModel = viewModel.tripCellViewModel(at: indexPath)
        let tripCell = tableView.dequeueReusableCell(withIdentifier: TripCellView.reuseIdentifier, for: indexPath) as! TripCellView
        tripCell.configureCell(with: tripCellViewModel)
        tripCell.selectionStyle = .none
        return tripCell
    }
}
