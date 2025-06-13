import SwiftUI
import SwiftData

struct ContentView: View {
    //ahora hacemos que los datos que estamos trabajando sean visible en nuestras vistas
    //esto nos permite ademas de leer datos, agregar y eliminar los datos
    @Environment(\.modelContext) private var modelContext
    
    //el query está atento a nuevos cambios que se puedan hacer en la base de datos
    //ademas carga todos los datos a la vista de tipo clase Wish
    @Query private var wishes: [Wish]
    @State private var isAlertShowing: Bool = false
    @State private var title: String = ""
    
    var body: some View {
        
        NavigationStack {
            List{
                ForEach(wishes) { wish in
                    Text(wish.wishName)
                        .italic() //ponemos tipo de fuente del texto de wish
                        .padding(.vertical, 4) //agregamos padding solo verticalmente
                        .swipeActions{
                            Button("Delete", role: .destructive){
                                modelContext.delete(wish)
                            }
                        }
                }
            }.navigationTitle("Wishlist")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){ //placement indica la posicion del toolbarItem (topBarTrailing == barra superior final (izquierda))
                        Button{
                            isAlertShowing.toggle()
                        }label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                    if wishes.isEmpty != true{
                        ToolbarItem(placement: .bottomBar){
                            Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                        }
                    }
                }.alert("Create a new wish", isPresented: $isAlertShowing){
                    TextField("Enter wish name", text: $title)
                    Button{
                        modelContext.insert(Wish(wishName: title))
                        title = ""
                    }label: {
                        Text("Save")
                    }
                }
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

#Preview ("List with simple data to try app") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    //ModelContainer = es de swift data y es lo que habilita a la vista a poder leer, guardar y manejar los datos
    //for: Wish.self = por cada Wish creado acontinuacion (self)
    //isStoredInMemoryOnly = esto indica que se guarden los datos solo en la RAM ya que esto es solo un test, no necesito los datos
    
    
    container.mainContext.insert(Wish(wishName: "Buy a new phone")) //insertamos un wish de clase Wish que contiene wishName
    container.mainContext.insert(Wish(wishName: "Buy a book"))
    container.mainContext.insert(Wish(wishName: "Learn SwiftUI"))
    
    return ContentView()
        .modelContainer(container)
}

//en el preview de arriba se cargan los datos en el mismo preview, por eso el return ya que es un test

#Preview ("Empty list") {
    ContentView()
    //ahora necesitamos conectar el ContentView con swiftData
        .modelContainer(for: Wish.self, inMemory: true)
}
