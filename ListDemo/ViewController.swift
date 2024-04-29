//
//  ViewController.swift
//  ListDemo
//
//  Created by Timur Saidov on 25.04.2024.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Private Structures

    private enum Constants {
        static let estimatedHeight: CGFloat = 44
    }

    // MARK: - Private Properties

    // Step 2.
    private lazy var tableHeaderView: UIView = {
        let view = TableHeaderView()
        view.configure(with: "Альбомы")
        return view
    }()

    // Step 1.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) // Step 3. UITableView() -> UITableView(frame:style:)
        tableView.backgroundColor = .systemBackground
        tableView.tableHeaderView = tableHeaderView // Step 2.
        tableView.estimatedSectionHeaderHeight = Constants.estimatedHeight // Step 3.
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableSectionHeaderViewId") // Step 3.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellId")
        tableView.register(MyAlbumsCell.self, forCellReuseIdentifier: "MyAlbumsCellId") // Step 5.
        tableView.register(PeopleAndPlacesCell.self, forCellReuseIdentifier: "PeopleAndPlacesCellId") // Step 8.
        tableView.register(MultilineCell.self, forCellReuseIdentifier: "MultilineCellId") // Step 9.
        tableView.dataSource = self
        tableView.delegate = self // Step 3.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // Step 2.
    // https://stackoverflow.com/questions/20982558/how-do-i-set-the-height-of-tableheaderview-uitableview-with-autolayout
    // https://stackoverflow.com/questions/5581116/how-to-set-the-height-of-table-header-in-uitableview
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableHeaderViewSizeToFit()
    }

    // MARK: - Private

    private func setupView() {
        view.backgroundColor = .systemBackground
        // Step 1.
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func tableHeaderViewSizeToFit() {
        let targetHeight = tableHeaderView.systemLayoutSizeFitting(
            CGSize(
                width: view.bounds.width,
                height: .greatestFiniteMagnitude
            )
        ).height
        if targetHeight != tableHeaderView.frame.size.height {
            tableHeaderView.frame.size.height = targetHeight
            tableHeaderView.layoutIfNeeded()
        }
    }
}

// MARK: - UITableViewDataSource

// Step 1.
extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if [0, 1].contains(section) {
            return 1
        }

        if section == 2 {
            return 9
        }

        if section == 3 {
            return 3
        }

        if section == 4 {
            return 3
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // Step 5.
            return tableView.dequeueReusableCell(withIdentifier: "MyAlbumsCellId", for: indexPath)
        }

        if indexPath.section == 1 { // Step 8.
            return tableView.dequeueReusableCell(withIdentifier: "PeopleAndPlacesCellId", for: indexPath)
        }

        if indexPath.section == 4 { // Step 9.
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "MultilineCellId", for: indexPath) as? MultilineCell
            else {
                return tableView.dequeueReusableCell(withIdentifier: "DefaultCellId", for: indexPath)
            }

            if indexPath.row == 0 {
                cell.configure(with: "• Многострочный текст\n• Длинный текст\n• Текст")
            } else if indexPath.row == 1 {
                cell.configure(with: "• Длинный текст\n• Текст")
            } else {
                cell.configure(with: "• Текст")
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellId", for: indexPath)
        cell.textLabel?.text = String(describing: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

// Step 3.
extension ViewController: UITableViewDelegate {

    // Step 5.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.bounds.height * 0.5
        }

        if indexPath.section == 1 { // Step 8.
            return (tableView.bounds.height * 0.25) - 5
        }

        return UITableView.automaticDimension
    }

    // Step 5.
    // Значением по умолчанию является automaticDimension, что означает, что table view выбирает приблизительную высоту ячейкам. Установка значения в 0 отключает расчетную высоту, что приводит к тому, что table view запрашивает актуальную высоту для каждой ячейки (или фактическую, используя метод sizeThatFits(_:), при условии, что значение свойства rowHeight - automaticDimension). Если в таблице отображаются ячейки, использующие self-sizing, значение этого свойства не должно быть равно 0. Иными словами, установка значения, отличного от нулевого, например, automaticDimension, приводит к тому, что table view запрашивает у каждой ячейки ее фактическую высоту, позволяя им использовать self-sizing с помощью метода systemLayoutSizeFitting(_:withHorizontalFittingPriority:verticalFittingPriority:).
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if [0, 1].contains(indexPath.section) { // Step 5, 8.
            return 0
        }

        return Constants.estimatedHeight // UITableView.automaticDimension
    }

    // Step 3.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableSectionHeaderViewId") as? TableSectionHeaderView
        else {
            return nil
        }

        switch section {
        case 0:
            view.configure(with: "Мои альбомы")
        case 1:
            view.configure(with: "Люди и места")
        case 2:
            view.configure(with: "Типы медиафайлов")
        case 3:
            view.configure(with: "Другое")
        case 4:
            view.configure(with: "Дополнительно")
        default:
            return nil
        }
        return view
    }

    // Step 4.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
