//
//  ContentView.swift
//  Note
//
//  Created by students on 04/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // Used to perform CRUD operations
    @Environment(\.modelContext) private var modelContext
    
    
    @Query private var lists: [Listt]
    
    @State private var title: String = ""
    @State private var isAlertShowing: Bool = false
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(lists) { list in
                    Text(list.title)
                        .font(.title2)
                        .fontWeight(.light)
                        .padding(.vertical, 2)
                        .swipeActions{
                            Button("Delete", role: .destructive){
                                modelContext.delete(list)
                            }
                        }
                }
            }
            .navigationTitle("My Lists")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        // Add button action here
                        isAlertShowing.toggle()
                    } label:{
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                
            }
            .alert("Create a new list", isPresented: $isAlertShowing){
                TextField("Enter a list",text: $title )
                
                Button(){
                    modelContext.insert(Listt(title: title))
                    title = ""
                }label: {
                    Text("Save")
                }
                .disabled(title.isEmpty)
            }
            .overlay{
                if lists.isEmpty {
                    ContentUnavailableView(
                        "My lists are not available",
                        systemImage: "plus.circle.fill",
                        description: Text("No lists yet. Add one to get started.")
                    )
                }
            }
        }
    }
}

#Preview("Second List"){
    
    do {
        let container = try! ModelContainer(
            for: Listt.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        let ctx = container.mainContext
        ctx.insert(Listt(title: "Swift Coding Club"))
        ctx.insert(Listt(title: "Good Morning"))
        ctx.insert(Listt(title: "Good Afternoon"))
        
        // Return the view for this preview
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create a ModelContainer: \(error)")
    }
}

#Preview("Main List") {
    ContentView()
        .modelContainer(for: Listt.self, inMemory: true)
}
