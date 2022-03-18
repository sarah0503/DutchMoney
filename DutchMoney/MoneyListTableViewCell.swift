//
//  MoneyListTableViewCell.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/03/16.
//

import UIKit

class MoneyListTableViewCell: UITableViewCell {

    @IBOutlet var moneyNameLabel: UILabel!
    @IBOutlet var momeyMomeyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
