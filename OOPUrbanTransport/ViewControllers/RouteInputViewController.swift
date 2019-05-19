import Cocoa
import RealmSwift

class RouteInputViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var lengthTextField: NSTextField!
    @IBOutlet weak var lapsPerDayTextField: NSTextField!
    
    var points: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear() {
        tableView.reloadData()
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.dismiss(nil)
    }
    @IBAction func addButtonTap(_ sender: Any) {
        let name = nameTextField.stringValue
        guard let length = Double(lengthTextField.stringValue) else { return }
        guard let lapsPerDay = Int(lapsPerDayTextField.stringValue) else { return }
        let points = self.points.joined(separator: "->")
        let route = Route(name: name, points: points, length: length, lapsPerDay: lapsPerDay)
        let realm = try? Realm()
        try! realm?.write {
            realm?.add(route)
        }
        self.dismiss(nil)
    }
    
    
    @IBAction func plusButtonTap(_ sender: Any) {
        points.append("Road")
        tableView.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        var result:NSTableCellView
        result = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
//        result.textField?.stringValue = points[row]
        result.textField?.isEditable = true
        result.textField?.objectValue = points[row]
        NotificationCenter.default.addObserver(self, selector: #selector(controlTextDidEndEditing(_:)), name:NSTextField.textDidEndEditingNotification, object: nil)
        return result
    }
    
//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        return points[row]
//    }
//
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        points[row] = (object as! String)
    }
    
    @objc func controlTextDidEndEditing(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else { return }
        let row = self.tableView.row(for: textField)
        guard row != -1 && row < points.count else { return }
        points[row] = textField.stringValue
    }
    
}
