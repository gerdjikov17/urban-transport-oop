import Cocoa
import RealmSwift

class ChooseRouteViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var tableView: NSTableView!
    private var routes: [Route] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let realm = try? Realm()
        if let routes = realm?.objects(Route.self) {
            self.routes = Array(routes)
        } else {
            self.routes = Array()
        }
        self.tableView.reloadData()
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.dismiss(nil)
    }
    
    @IBAction func chooseSelectedButtonTap(_ sender: Any) {
        guard self.tableView.selectedRow != -1 && self.routes.count >= self.tableView.selectedRow else { return }
        let route = self.routes[self.tableView.selectedRow]
        guard let carInputVC = self.presentingViewController as? CarInputViewController else { return }
        carInputVC.setChosenRoute(route: route)
        carInputVC.dismiss(self)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.routes.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result: NSTableCellView
        guard let tableColumn = tableColumn else {return NSView() }
        if tableColumn.identifier.rawValue == "Name" {
            result = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Name"), owner: self) as! NSTableCellView
            result.textField?.stringValue = routes[row].getName()
        }
        else if tableColumn.identifier.rawValue == "Points" {
            result = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Points"), owner: self) as! NSTableCellView
            result.textField?.stringValue = routes[row].getPoints()
        }
        else if tableColumn.identifier.rawValue == "Length" {
            result = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier("Length"), owner: self) as! NSTableCellView
            result.textField?.stringValue = String(routes[row].getLength())
        }
        else if tableColumn.identifier.rawValue == "Laps" {
            result = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier("Laps"), owner: self) as! NSTableCellView
            result.textField?.stringValue = String(routes[row].getLaps())
        }
        else {
            return NSView()
        }
        return result
    }
}
