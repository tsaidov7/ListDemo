//
//  ViewController.swift
//  UITableViewDemo
//
//  Created by Timur Saidov on 02.05.2024.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Private Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44 // The default value is automaticDimension, which means that the table view selects an estimated height to use on your behalf. Setting the value to 0 disables estimated heights, which causes the table view to request the actual height for each cell. If your table uses self-sizing cells, the value of this property must not be 0.
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 34, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderViewId")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCellId")
        tableView.register(CustomTableViewCellV2.self, forCellReuseIdentifier: "CustomTableViewCellV2Id")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellId")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var dataSource: [String] = []
    private var timer: Timer?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createTimer()
    }

    // MARK: - Private

    private func setupView() {
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func createTimer() {
        let timer = Timer(
            timeInterval: 3.0,
            target: self,
            selector: #selector(handleTimer),
            userInfo: nil,
            repeats: false
        )
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }

    private func makeTitledImage(
        image: UIImage?,
        title: String,
        textColor: UIColor = .white,
        font: UIFont = .systemFont(ofSize: 14, weight: .medium)
    ) -> UIImage? {
        let img = image?.withTintColor(textColor, renderingMode: .alwaysOriginal)

        // Create attributed string attachment with image.
        let attachment = NSTextAttachment()
        attachment.image = img
        let imageString = NSAttributedString(attachment: attachment)
//        print("🍏", img?.size)

        // Create attributed string with title.
        let text = NSAttributedString(
            string: "\n\(title)",
            attributes: [
                .foregroundColor: textColor,
                .font: font
            ]
        )

        // Merge two attributed strings.
        let mergedText = NSMutableAttributedString()
        mergedText.append(imageString)
        mergedText.append(text)
//        print("🍏", imageString.size(), text.size(), mergedText.size(), mergedText.string)

        // Create label and append that merged attributed string.
        let size = mergedText.size()
        let label = UILabel(frame: .init(x: 0, y: 0, width: size.width, height: size.height))
        label.textAlignment = .center
        label.numberOfLines = 3
        label.attributedText = mergedText
        label.sizeToFit() // Изменение размера лейбла таким образом, чтобы он занимал наиболее подходящее пространство.  Размер изменяется в соответствии со своим контентом согласно свойству intrinsicContentSize.
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.5
//        print("🍏", label.bounds.size, label.intrinsicContentSize)

        // Create image from that label.
        let renderer = UIGraphicsImageRenderer(bounds: label.bounds)
        let image = renderer.image { rendererContext in
            label.layer.render(in: rendererContext.cgContext)
        }
//        print("🍏", image.size)

        // Convert it to UIImage and return.
        if let cgImage = image.cgImage {
            return UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        }

        return nil
    }

    @objc private func handleTimer() {
        dataSource = [
            "Медведев провалился в полуфинале Уимблдона. Соперник нагло улыбался и много себе позволял",
            "13 российских сериалов, которые вы будете ждать в новом сезоне",
            "Посмотрите на первое в истории сверхдетальное сканирование «Титаника»",
            "Турция остановила весь экспорт и импорт с Израилем",
            "Стоит ли ехать на Кубу летом?",
            "10 фактов об Audi, которые вы могли не знать",
            "Чем отличается IP адрес компьютера от IP адреса сети? Вопрос простой, но многие путаются",
        ]
        tableView.reloadData()
        button.isEnabled = true
    }

    @objc private func didTapButton() {
        dataSource.insert(String.random(length: Int.random(in: 0..<500)), at: 0)
        CATransaction.begin()
//        CATransaction.setDisableActions(true)
        CATransaction.setCompletionBlock {
//            print("🍎 smth to do upon completion")
        }
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .right)
        tableView.endUpdates()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        CATransaction.commit()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty {
            return 0
        }

        if section == 0 {
            return 1
        }

        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCellV2Id", for: indexPath)
        }

        guard 
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellId", for: indexPath) as? CustomTableViewCell
        else {
            return tableView.dequeueReusableCell(withIdentifier: "DefaultCellId", for: indexPath)
        }

        cell.setup(withText: self.dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if dataSource.isEmpty {
            return nil
        }

        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderViewId")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
            self.dataSource.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .right)
            self.tableView.endUpdates()
            completion(true)
        }
        removeAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [removeAction])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(
            style: .normal,
            title: nil,
            handler: { _, _, completion in
                completion(true)
            }
        )
        shareAction.image = makeTitledImage(
            image: UIImage(systemName: "arrowshape.turn.up.right.fill"),
            title: "Поделиться"
        )
        shareAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [shareAction])

//        let shareAction = UIContextualAction(style: .normal, title: "Поделиться") { _, _, completion in
//            completion(true)
//        }
//        shareAction.image = UIImage(systemName: "arrowshape.turn.up.right.fill")
//        shareAction.backgroundColor = .systemBlue
//        return UISwipeActionsConfiguration(actions: [shareAction])
    }
}
