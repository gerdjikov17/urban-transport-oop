import Cocoa
import Realm
import RealmSwift

class Car: Object {
    //Данните за колите са марка, модел, години, колко местна е, с каква товароподемност и колко разход на гориво иска.
    @objc dynamic private var brand: String = ""
    @objc dynamic private var model: String = ""
    @objc dynamic private var yearsOld: Int = -1
    @objc dynamic private var seats: Int = -1
    @objc dynamic private var loadCapability: Double = -1
    @objc dynamic private var fuelConsumption: Double = -1
    @objc dynamic private var route: Route?
    
    convenience init(brand: String, model: String, yearsOld: Int, seats: Int, loadCapability: Double, fuelConsumption: Double, route: Route?) {
        self.init()
        self.brand = brand
        self.model = model
        self.yearsOld = yearsOld
        self.seats = seats
        self.loadCapability = loadCapability
        self.fuelConsumption = fuelConsumption
        self.route = route
    }
    
    func getBrand() -> String { return brand }
    func getModel() -> String { return model }
    func getYearsOld() -> Int { return yearsOld}
    func getSeats() -> Int { return seats }
    func getLoadCapability() -> Double { return loadCapability }
    func getFuelConsumption() -> Double { return fuelConsumption }
    func getRoute() -> Route? { return route }
    
    func setRoute(route: Route) {
        self.route = route
    }
    
    override var description: String {
        return "\(brand), \(model), \(yearsOld), \(seats), \(loadCapability), \(fuelConsumption)"
    }
}
