//
//  CreateActivityView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 20.02.2025.
//

import SwiftUI
import MapKit

struct CreateActivityView: View {
    @State private var activityName: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    @State private var activityStartingDate: Date = Date()
    @State private var activityStartingTime: Date = Date()
    @State private var activityDurationEstimate: Int32 = 0
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var errorMessage: String?
    @State private var categoryList: [String] = []
    @State private var isCreateSuccess : Bool = false



    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Etkinlik Bilgileri")) {
                    TextField("Etkinlik Adı", text: $activityName)
                    TextField("Açıklama", text: $description)
                    Picker("Kategori", selection: $category) {

                        if categoryList.isEmpty {
                            Text("Yükleniyor...").tag("")
                        } else {
                            ForEach(categoryList, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                    }
                }
                
                Section(header: Text("Zaman Bilgileri")) {
                    DatePicker("Başlangıç Tarihi", selection: $activityStartingDate, displayedComponents: .date)
                    DatePicker("Başlangıç Saati", selection: $activityStartingTime, displayedComponents: .hourAndMinute)
                    TextField("Tahmini Süre (saat)", text: Binding(
                        get: { String(activityDurationEstimate) },
                        set: { newValue in
                            if let value = Int32(newValue) {
                                activityDurationEstimate = value
                            }
                        }
                    ))
                }
                
                Section(header: Text("Konum Seçimi")) {
                    MapReader { proxy in
                        Map(position: $position){
                            if let coordinate = selectedCoordinate {
                                Marker("Seçilen Konum", coordinate: coordinate)
                            }
                        }
                            .mapStyle(.standard(pointsOfInterest: .excludingAll))
                            .mapControls {
                                MapCompass()
                            }
                            .frame(height: 300)
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onEnded { gesture in
                                        let tappedCoordinate = proxy.convert(gesture.location, from: .local)
                                        selectedCoordinate = tappedCoordinate
                                        latitude = tappedCoordinate.unsafelyUnwrapped.latitude
                                        longitude = tappedCoordinate.unsafelyUnwrapped.longitude
                                    }
                            )
                    }
                    
                    if let coordinate = selectedCoordinate {
                        Text("Seçilen Konum: \(coordinate.latitude), \(coordinate.longitude)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    Button(action: submitForm) {
                        Text("Gönder")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Etkinlik Oluştur")
            .onAppear() {
                fetchCategories()
            }
            .navigationDestination(isPresented: $isCreateSuccess, destination: {SuccesView()})
        }
    }
    
    
    func fetchCategories() {
        getCategories { categories, error in
            DispatchQueue.main.async {
                if let data = categories {
                    print("Fetched Categories: \(data)")
                    self.categoryList = data
                    
                    if categoryList.isEmpty {
                        print("Category list is still empty!")
                    }
                } else if let error = error {
                    print("Error fetching categories: \(error)")
                }
            }
        }
    }
    
    func submitForm() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: activityStartingDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        let formattedTime = timeFormatter.string(from: activityStartingTime)
        
        if let coordinate = selectedCoordinate {
            latitude = coordinate.latitude
            longitude = coordinate.longitude
        }
        
        createActivity(activityName: activityName, description: description, category: category, activityStartingDate: formattedDate, activityStartingTime: formattedTime, activityDurationEstimate: activityDurationEstimate, latitude: latitude, longitude: longitude) { response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = "ACTIVITY_CREATE_FAILED \(error)"
                    return
                }
                
                if let response = response{
                    isCreateSuccess = true
                    print(response)
                }
            }
        }

        print("Etkinlik Adı: \(activityName)")
        print("Açıklama: \(description)")
        print("Kategori: \(category)")
        print("Başlangıç Tarihi: \(activityStartingDate)")
        print("Başlangıç Saati: \(activityStartingTime)")
        print("Tahmini Süre: \(activityDurationEstimate)")
        print("Latitude: \(latitude), Longitude: \(longitude)")
    }
}

#Preview {
    CreateActivityView()
}
