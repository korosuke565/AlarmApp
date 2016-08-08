import UIKit

class TableViewCell1: UITableViewCell {

    @IBOutlet weak var mySwitch: UISwitch!
    //AppDelegateのvibeSwitchの準備
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
            delegate.vibeSwitch = "ON"
        } else {
            delegate.vibeSwitch = "OFF"

        }
    }

}
