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
    @State private var activityDurationEstimate: Date = Calendar.current.startOfDay(for: Date())
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
                Section(header: Text("ACTIVITY_CREATE_INFO")) {
                    TextField("ACTIVITY_CREATE_NAME", text: $activityName)
                    TextField("ACTIVITY_CREATE_DESCRIPTION", text: $description)
                    Picker("ACTIVITY_CREATE_CATEGORY", selection: $category) {

                        if categoryList.isEmpty {
                            Text("ACTIVITY_CREATE_LOADING").tag("")
                        } else {
                            ForEach(categoryList, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                    }
                }
                
                Section(header: Text("ACTIVITY_CREATE_TIME_DETAIL")) {
                    DatePicker("ACTIVITY_CREATE_STARTING_DATE", selection: $activityStartingDate, displayedComponents: .date)
                    DatePicker("ACTIVITY_CREATE_STARTING_TIME", selection: $activityStartingTime, displayedComponents: .hourAndMinute)
                    DatePicker("ACTIVITY_CREATE_ESTIMATED_TIME", selection: $activityDurationEstimate, displayedComponents: .hourAndMinute)
                }
                
                Section(header: Text("ACTIVITY_CREATE_CHOOSE_LOCATION")) {
                    MapReader { proxy in
                        Map(position: $position){
                            if let coordinate = selectedCoordinate {
                                Marker("ACTIVITY_CREATE_CHOOSEN_LOCATION", coordinate: coordinate)
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
                        Text("ACTIVITY_CREATE_CHOOSEN_LOCATION: \(coordinate.latitude), \(coordinate.longitude)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    Button(action: submitForm) {
                        Text("ACTIVITY_CREATE_SUBMIT")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("ACTIVITY_CREATE_TITLE")
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
    
    func minuteConverter(date: Date) -> Int32 {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let formattedTime = timeFormatter.string(from: date)
        let components = formattedTime.components(separatedBy: ":")
        
        guard let hours = Int32(components[0]), let minutes = Int32(components[1]) else {
            return 0
        }
        
        return (hours*60)+minutes
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
        
        createActivity(activityName: activityName, description: description, category: category, activityStartingDate: formattedDate, activityStartingTime: formattedTime, activityDurationEstimate: minuteConverter(date: activityDurationEstimate), latitude: latitude, longitude: longitude) { response, error in
            
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
