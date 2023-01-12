//
//  CurrencyListViewController.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 11.01.2023.
//

import UIKit

final class CurrencyListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let cellIdentifier = "cell"
    
    var presenter: CurrencyListPresenter?
    
    override func loadView() {
        super.loadView()
        presenter?.loadView(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func tappedCrossButton(_ sender: Any) {
        presenter?.dismiss()
    }
    
}

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.pairCount ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = presenter?.getPair(by: indexPath.row)
        return cell
    }
    
}

extension CurrencyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectPair(by: indexPath.row)
    }
}
