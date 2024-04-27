//import CoreData
//import UIKit
//import Foundation
//
//class FavoriteRepository {
//    // Storage for Core Data
//    let container: NSPersistentContainer
//
//    init() {
//        container = NSPersistentContainer(name: "BusRoute")
//
//        container.loadPersistentStores { _, error in
//            
//        }
//    }
//
//    static func saveBusFavorite(route: BusRoute, delegate: UIApplicationDelegate) {
//        let context = delegate.persistentContainer.viewContext
//        let entity = BusRouteEntity(context: context)
//        newData.name = name
//        newData.image = image
//        do {
//            try context.save()
//        } catch {
//            print("error-Saving data")
//        }
//    }
//    
//    func getFavorites() {
//        let favoritesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
//         
//        do {
//            let fetchedEmployees = try moc.executeFetchRequest(employeesFetch) as! [EmployeeMO]
//        } catch {
//            fatalError("Failed to fetch employees: \(error)")
//        }
//    }
//
//    func setFavorites(_ settings: [String]) {
//        
//    }
//}
