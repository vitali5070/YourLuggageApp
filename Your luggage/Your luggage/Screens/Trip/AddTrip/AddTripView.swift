//
//  AddTripView.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/8/21.
//

import UIKit
import UIComponents
import SnapKit
import FSCalendar

final class AddTripView: BaseViewController<AddTripViewModelProtocol> {
    private enum Constants {
        static let searchBarOffset: CGFloat = 20
        static let backButtonSize: CGSize = CGSize(width: 36, height: 36)
        static let addTripButtonConstant: CGFloat = 20
        static let addTripButtonHeightConstant: CGFloat = 48
        static let addTripButtonBottomOffset: CGFloat = -20
        static let titleTopOffset: CGFloat = 32
        static let buttonStackSize: CGSize = CGSize(width: 260, height: 120)
        static let buttonStackSpacing: CGFloat = 20
    }
    
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = PlaceSearchView(viewModel: viewModel.placeSearchViewModel)
        navigationItem.searchController = searchController
        setupNavigation()
        setupView()
    }
    
    private func setupNavigation() {
        navigationItem.hidesSearchBarWhenScrolling = false
        let backButton = ButtonView(viewModel: viewModel.backButton)
        backButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.backButtonSize.height)
            make.width.equalTo(Constants.backButtonSize.width)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupView() {
        let calendar: FSCalendar = { 
            let calendar = FSCalendar()
            calendar.backgroundColor = .backgroundColor
            calendar.layer.cornerRadius = 10
            calendar.layer.borderWidth = 1
            calendar.layer.borderColor = UIColor.limeGreen.cgColor
            calendar.locale = NSLocale.current
            calendar.allowsMultipleSelection = true
            calendar.appearance.headerTitleFont = UIFont.bold(20)
            calendar.appearance.titleFont = UIFont.default(16)
            calendar.appearance.todayColor = .redOrange
            calendar.appearance.selectionColor = .fireOrange
            calendar.appearance.headerTitleColor = .fireOrange
            calendar.appearance.weekdayTextColor = .limeGreen
            calendar.appearance.titleDefaultColor = .fireOrange
            calendar.appearance.titlePlaceholderColor = .limeGreen
            return calendar
        }()
        calendar.delegate = self
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(Constants.searchBarOffset)
            make.leading.equalToSuperview().offset(Constants.searchBarOffset)
            make.trailing.equalToSuperview().inset(Constants.searchBarOffset)
            make.height.equalTo(view.frame.width - (Constants.searchBarOffset * 2))
        }
        
        let addTripButton = ButtonView(viewModel: viewModel.addTripButton)
        view.addSubview(addTripButton)
        addTripButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp_bottomMargin).offset(Constants.addTripButtonBottomOffset)
            make.leading.equalToSuperview().offset(Constants.addTripButtonConstant)
            make.trailing.equalToSuperview().inset(Constants.addTripButtonConstant)
            make.height.equalTo(Constants.addTripButtonHeightConstant)
        }
        
//        let titleLabel = LabelView(viewModel: viewModel.titleLabel)
//        view.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(calendar.snp_bottomMargin).offset(Constants.titleTopOffset)
//            make.centerX.equalToSuperview()
//        }
        
//        let travelButton = ButtonView(viewModel: viewModel.travelButton)
//        let businessButton = ButtonView(viewModel: viewModel.businessButton)
//
//        let buttonStack = UIStackView().with(travelButton, businessButton)
//        buttonStack.distribution = .fillEqually
//        buttonStack.spacing = Constants.buttonStackSpacing
//        view.addSubview(buttonStack)
//        buttonStack.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp_bottomMargin).offset(Constants.titleTopOffset)
//            make.height.equalTo(Constants.buttonStackSize.height)
//            make.width.equalTo(Constants.buttonStackSize.width)
//            make.centerX.equalToSuperview()
//        }
    }
}

// MARK: - FSCalendar Delegate

extension AddTripView: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let newDate = date.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: date)))
        
        if firstDate == nil {
            viewModel.getDates(newDate, nil)
            firstDate = newDate
            datesRange = [firstDate!]
            return
        }
        
        if firstDate != nil && lastDate == nil {
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = newDate
                datesRange = [firstDate!]
                return
            }
            
            let range = datesRange(from: firstDate!, to: newDate)
            lastDate = range.last
            
            for day in range {
                calendar.select(day)
            }
            viewModel.getDates(firstDate!, range.last)
            datesRange = range
            return
        }
        
        if firstDate != nil && lastDate != nil {
            for day in calendar.selectedDates {
                calendar.deselect(day)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
        }
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
}

