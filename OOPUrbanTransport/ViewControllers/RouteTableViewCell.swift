import Cocoa
import RealmSwift

class RouteTableViewCell: NSTableCellView {

    @IBOutlet weak var popUpButton: NSPopUpButton!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let routes = Array(RealmRepository.allRoutes())
        popUpButton.addItems(withTitles: routes.map({ (route) -> String in
            return route.getName()
        }))
    }
}
