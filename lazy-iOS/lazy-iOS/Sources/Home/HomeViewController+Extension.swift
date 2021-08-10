//
//  MainViewController+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/20.
//

import UIKit

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        59
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailHabitViewController = DetailHabitViewController()

        navigationController?.pushViewController(detailHabitViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeHabitTableViewCell.identifier, for: indexPath) as? HomeHabitTableViewCell else { return UITableViewCell() }
        cell.checkButtonDelegate = self
        cell.selectionStyle = .none

        if indexPath.row == 1 {
            cell.changeInActive()
        }

        return cell
    }
}

// MARK: - DrawerViewDelegate

extension HomeViewController: DrawerViewDelegate {
    func presentAddHabitView() {
        let addHabitViewController = AddHabitViewController()

        self.present(addHabitViewController, animated: true, completion: nil)
    }
}

// MARK: - HabitCheckButtonDelegate

extension HomeViewController: HabitCheckButtonDelegate {
    func didTapHabitCheckButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
