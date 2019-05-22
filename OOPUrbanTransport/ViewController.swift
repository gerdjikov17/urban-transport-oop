import Cocoa
import RealmSwift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try? Realm()
        FileRepository.shared().writeToFile(fileName: "data.txt")
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func insertButtonTap(_ sender: Any) {
        guard let inputVC = storyboard?.instantiateController(withIdentifier: "inputVC") as? NSViewController else { return }
        self.presentAsSheet(inputVC)
    }
    
    @IBAction func addCarButtonTap(_ sender: Any) {
        guard let carVC = storyboard?.instantiateController(withIdentifier: "addCarVC") as? NSViewController else { return }
        self.presentAsSheet(carVC)
    }
    @IBAction func mainPanelButtonTap(_ sender: Any) {
        guard let carVC = storyboard?.instantiateController(withIdentifier: "carRouteVC") as? NSViewController else { return }
        self.presentAsSheet(carVC)
    }
}

