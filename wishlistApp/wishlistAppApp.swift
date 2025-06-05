import SwiftUI
import SwiftData

@main
struct wishlistAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            //model container crea y configura un almacenamiento para el wish (for: wish)
                .modelContainer(for: Wish.self)//indica que la clase Wish será el modelo de datos que debe de seguir
        }
    }
}
