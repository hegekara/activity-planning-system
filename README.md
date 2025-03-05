
# ActivityPlanning-System

Bu proje, kullanıcıların aktivite oluşturup, oluşturulan aktiviteleri harita üzerinde görüntüleyebilme ve aktiviteye katılmasını bildirmesini sağlamasını amaçlamıştır.

## Kullanılan Teknolojiler
Front-End: Swift, SwiftUI

Back-End: Java, Spring Framework, Spring Cloud Netflix-Eureka, Spring Cloud Gateway, OpenFeign, JWT

DB : PostgreSql

## Back-End

Projenin backend kısmı Java Spring Framework kullanılarak mikroservis mimarisini öğrenmek ve anlamak amacıyla mikroservis mimarisi ile geliştirilmiştir. Backend; login, register, aktivite işlemleri ve aktivite-katılım işlemlerinden sorumludur.

API güvenliğinin sağlanması için JSON Web Token (JWT) kullanılmıştır. Kullanıcı giriş yaptıktan sonra, bir JWT token oluşturulur ve sonraki işlemlerde gateway kısmında bu token kontrol edilerek endpointlere erişim sağlanmasına izin verilir.

Proje'nin backend kısmında kullanılan mikroservis mimarisi şu şekilde işlemektedir.

![ER Diagram](https://github.com/user-attachments/assets/f46ccc5b-605b-4cfc-b0d6-0a92d0bb4419)


Servisler, Controller-Service-Repository katmanları ile katmanlı bir mimari kullanılarak oluşturulmuştur.

- Controller Katmanı, istemciden gelen istekleri alır ve ilgili işlevleri çağırır.

- Service Katmanı, iş kurallarını uygular ve veritabanı işlemlerini koordine eder.

- Repository Katmanı, Hibernate/JPA kullanarak veritabanı CRUD ve veri tabanı sorgu işlemlerini gerçekleştirir.

Veri tabanı yönetim sistemi olarak ise PostgreSql kullanılmıştır. Aşağıdaki ER diyagramı, uygulamada kullanılan veri modelini detaylandırmaktadır.

![ER Diagram](https://github.com/user-attachments/assets/d22321de-6964-4d83-8dbc-c868c1ae095c)



## Front-End

Frontend kısmı, iOS ve mobil programlamayı anlamak ve öğrenmek amacıyla Swift dilinde geliştirilmiştir. Uygulama, kullanıcıların aktivite oluşturup, oluşturulan aktiviteleri harita üzerinde görüntüleyebilme ve aktiviteye katılmasını sağlamaktadır. Localizasyon sayesinde Türkçe ve İngilizce dil desteği bulunmaktadır.

Ana uygulama bileşeninde, `Mapkit` frameworkü ile harita özelliklerinin, `Security` frameworkü ile Keychain özelliklerinin ve `Combine` ile asenkron işlemlerin kullanılması sağlanmıştır.

## Screenshots
![Login-screen](https://github.com/user-attachments/assets/362068ff-96a7-49d1-9e93-7f9869398296)
---
![Map-view](https://github.com/user-attachments/assets/ed2354ce-d459-4029-bf56-9c52cbae7264)
---
![Activity-Screen](https://github.com/user-attachments/assets/ad2a0069-7f00-41bf-81ac-ecbf50333ff5)
---
![Create-Activity](https://github.com/user-attachments/assets/53ee0119-ede5-4cfb-993b-b646e6321172)
---


## Run Locally

Clone the project

```bash
  git clone https://github.com/hegekara/activity-planning-system.git
```

Go to the project directory

```bash
  cd activity-planning-system
```

Start the all services

```bash
  ./mvnw spring-boot:run
```
