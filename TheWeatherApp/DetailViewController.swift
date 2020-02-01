import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTempLabel: UILabel!
    
    @IBOutlet weak var firstDetailLabel: UILabel!
    @IBOutlet weak var secondDetailLabel: UILabel!
    @IBOutlet weak var thirfDetailLabel: UILabel!
    @IBOutlet weak var fourthDetailLabel: UILabel!
    
    var detailTemp : Double?
    var firstDetail : Int?
    var secondDetail : String?
    var thirdDetail : String?
    var fourthDetail : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        detailTempLabel.text = "\(detailTemp ?? 0)"
        firstDetailLabel.text = "\(firstDetail ?? 0)"
        secondDetailLabel.text = "\(secondDetail ?? "Loading")"
        thirfDetailLabel.text = "\(thirdDetail ?? "Loading")"
        fourthDetailLabel.text = "\(fourthDetail ?? "Loading")"
    }
}
