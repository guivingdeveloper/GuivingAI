//
//  CityCell.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/08/13.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    var cityInfo:cityInfo!

    func initCell(cityInfo:cityInfo){
        let cityName = cityInfo.name
        if !cityInfo.isActive{
            self.nameLabel.text = cityName.appendingFormat("%@", "(준비중)")
            self.nameLabel.textColor = UIColor.gray
        }else{
            self.nameLabel.text = cityName
            self.nameLabel.textColor = UIColor.black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
