//
//  ViewController.swift
//  ListDemo
//
//  Created by Timur Saidov on 25.04.2024.
//

import UIKit

class ViewController: UIViewController {

    // Step 2.
    private lazy var tableHeaderView: UIView = {
        let view = TableHeaderView()
        view.setup(wth: "Альбомы")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Step 1.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) // Step 3. UITableView() -> UITableView(frame:style:)
        tableView.backgroundColor = .systemBackground
        tableView.tableHeaderView = tableHeaderView // Step 2.
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableSectionHeaderViewId") // Step 3.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellId")
        tableView.register(MyAlbumsCell.self, forCellReuseIdentifier: "MyAlbumsCellId") // Step 5.
        tableView.register(PeopleAndPlacesCell.self, forCellReuseIdentifier: "PeopleAndPlacesCellId") // Step 8.
        tableView.dataSource = self
        tableView.delegate = self // Step 3.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

    // Step 2.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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

// Step 1.
extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        4
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

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // Step 5.
            return tableView.dequeueReusableCell(withIdentifier: "MyAlbumsCellId", for: indexPath)
        }

        if indexPath.section == 1 { // Step 8.
            return tableView.dequeueReusableCell(withIdentifier: "PeopleAndPlacesCellId", for: indexPath)
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellId", for: indexPath)
        cell.textLabel?.text = String(describing: indexPath)
        return cell
    }
}

// Step 3.
extension ViewController: UITableViewDelegate {

    // Step 6.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.bounds.height * 0.5
        }

        if indexPath.section == 1 { // Step 8.
            return (tableView.bounds.height * 0.25) - 5
        }

        return 44
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
            view.setup(with: "Мои альбомы")
        case 1:
            view.setup(with: "Люди и места")
        case 2:
            view.setup(with: "Типы медиафайлов")
        case 3:
            view.setup(with: "Другое")
        default:
            return nil
        }
        return view
    }

    // Step 4.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
//        if [0, 1].contains(indexPath.section) {
        if indexPath.section == 1 { // Step 5.
            cell?.selectionStyle = .none
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
