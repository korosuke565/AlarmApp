import UIKit


class TableViewCell3: UITableViewCell {
    
    @IBOutlet weak var mySwitch: UISwitch!
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeSwitch(sender: AnyObject) {
        if mySwitch.on == true {
            delegate.vibeSwitch = true
            print("true")
        } else {
            delegate.vibeSwitch = false
            print("false")
        }

    }

}
