
import UIKit

class TextTableViewCell: UITableViewCell {
    
    let nameLabe : UILabel = {
        let lable = UILabel()
        lable.text = ""
        lable.font = UIFont.init(name: "Songti Tc", size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        // we should use a custom imageView, but this will do for demonstrational purposes
        imageView?.frame = bounds
        imageView?.contentMode = .scaleAspectFit

        //resetSeparators()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabe)
        nameLabe.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        nameLabe.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        nameLabe.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameLabe.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        //nameLabe.heightAnchor.con
        nameLabe.numberOfLines = 0
        nameLabe.sizeToFit()
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(viewData: TextCellViewData) {
        
        nameLabe.text = viewData.title
        backgroundColor = UIColor.white
        //textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
    }
}

extension TextTableViewCell: Updatable {
    typealias ViewData = TextCellViewData
}
