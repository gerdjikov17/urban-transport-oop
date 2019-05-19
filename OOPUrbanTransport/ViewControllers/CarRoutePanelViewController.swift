import Cocoa
import RealmSwift

class CarRoutePanelViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var tableView: NSTableView!
    private var cars: [Car]!
    private var routes: [Route]!
    private var selectedRoutes: [Int: Route] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cars = Array(RealmRepository.allCars())
        routes = Array(RealmRepository.allRoutes())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.dismiss(nil)
    }
    
    @IBAction func calculateButtonTap(_ sender: Any) {
        guard self.tableView.selectedRow >= 0 && self.tableView.selectedRow < cars.count else {
            dialogOKCancel(question: "Error", text: "Please select a row")
            return
        }
        let car = cars[self.tableView.selectedRow]
        guard let route = selectedRoutes[self.tableView.selectedRow] else { return }
        let fuelNeeded = (car.getFuelConsumption() * route.getLength() / 100) * Double(route.getLaps())
        let fuelString = String(format:"%.1f", fuelNeeded)
        dialogOKCancel(question: "Fuel needed", text: "For car: \(car)\nRoute: \(route)\nYou need \(fuelString) l of fuel.")
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result: NSTableCellView
        guard let tableColumn = tableColumn else {return NSView() }
        if tableColumn.identifier.rawValue == "Car" {
            result = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("carCell"), owner: self) as! NSTableCellView
            result.textField?.stringValue = cars[row].description
        }
        else if tableColumn.identifier.rawValue == "Route" {
            result = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("routeCell"), owner: self) as! RouteTableViewCell
            let indexOfSelectedItem = (result as! RouteTableViewCell).popUpButton.indexOfSelectedItem != -1 ? (result as! RouteTableViewCell).popUpButton.indexOfSelectedItem : 0
            selectedRoutes[row] = routes[indexOfSelectedItem]
        }
        else {
            return NSView()
        }
        return result
    }
    
    
    func dialogOKCancel(question: String, text: String){
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @IBAction func popupSelected(_ sender: Any) {
        guard let popUpButton = sender as? NSPopUpButton else { return }
        let indexOfRoute = popUpButton.indexOfSelectedItem
        let selectedRoute = routes[indexOfRoute]
        let selectedRow = self.tableView.row(for: popUpButton)
        selectedRoutes[selectedRow] = selectedRoute
    }
    
}
