import UIKit
import AVFoundation
import MediaPlayer

class TableViewCell2: UITableViewCell {

    
    //AppDelegate変数を呼び出す準備
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let volumeView = MPVolumeView()
    @IBOutlet weak var slider: UISlider!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeSlider(sender: AnyObject) {
        print(slider.value)
 
        if delegate.selectedMusic == "iphone" {
            (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(slider.value, animated: false)
        } else {
            guard delegate.selectedMusic == "test" else {
                return delegate.audioPlayer.volume = slider.value
            }
        }
    }
}
