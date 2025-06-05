import SwiftUI
import SwiftData

struct ContentView: View {
    //ahora hacemos que los datos que estamos trabajando sean visible en nuestras vistas
    //esto nos permite ademas de leer datos, agregar y eliminar los datos
    @Environment(\.modelContext) private var modelContext
    
    //el query está atento a nuevos cambios que se puedan hacer en la base de datos
    //ademas carga todos los datos a la vista de tipo clase Wish
    @Query private var wishes: [Wish]
    
    var body: some View {
        
        NavigationStack {
            List{
                ForEach(wishes) { wish in
                    Text(wish.wishName)
                }
            }.navigationTitle("Wishlist")
                .overlay{
                    if wishes .isEmpty{
                        //esto se muestra cuando la vista principal no esta disponible
                        //es decir, if wishes isEmpty (si no hay wishes)
                        //se recomienda usar para cuando hay problemas de red, lista vacia, busqueda sin resultados...
                        ContentUnavailableView("My Wishlist", systemImage: "heart.circle", description: Text("No wishes yet. Add one!"))
                    }
                }
        }
    }
}

#Preview {
    ContentView()
    //ahora necesitamos conectar el ContentView con swiftData
        .modelContainer(for: Wish.self, inMemory: true)
}
