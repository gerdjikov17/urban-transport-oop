import Cocoa
import Realm
import RealmSwift

class Car: Object {
    //Данните за колите са марка, модел, години, колко местна е, с каква товароподемност и колко разход на гориво иска.
    dynamic private var brand: String = ""
    dynamic private var model: String = ""
    dynamic private var yearsOld: Int = -1
    dynamic private var seats: Int = -1
    dynamic private var loadCapability: Double = -1
    dynamic private var fuelConsumption: Double = -1
    dynamic private var route = Route()
    
    init(brand: String, model: String, yearsOld: Int, seats: Int, loadCapability: Double, fuelConsumption: Double, route: Route) {
        super.init()
        self.brand = brand
        self.model = model
        self.yearsOld = yearsOld
        self.seats = seats
        self.loadCapability = loadCapability
        self.fuelConsumption = fuelConsumption
        self.route = route
    }
    
    required init() {
        super.init()
//        self.brand = "brand"
//        self.model = "model"
//        self.yearsOld = -1
//        self.seats = -1
//        self.loadCapability = -1
//        self.fuelConsumption = -1
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
}
