import Cocoa
import RealmSwift

class RealmRepository: NSObject {
    static let config = Realm.Configuration.defaultConfiguration
    
    static func allCars() -> Results<Car> {
        let realm = try! Realm()
        return realm.objects(Car.self)
    }
    
    static func allRoutes() -> Results<Route> {
        let realm = try! Realm()
        return realm.objects(Route.self)
    }
    
    static func addCar(car: Car) {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(car)
        try? realm.commitWrite()        
    }
    
    static func addRoute(route: Route) {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(route)
        try? realm.commitWrite()
    }
    
    static func setRoute(route:Route ,forCar car: Car) {
        let realm = try! Realm()
        realm.beginWrite()
        car.setRoute(route: route)
        try? realm.commitWrite()
    }
}
