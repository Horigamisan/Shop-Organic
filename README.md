# Shop-Organic
# How to run this program?
Trang web được xây dựng trên nền tảng ASP.NET MVC và database sử dụng là SQL Server. 

Bước 1: Mở file SQL, excute file SQL để tạo database.

Bước 2: Mở WebDemo.sln để mở solution của project.

Bước 3: Mở file Web.config và tìm đoạn code sau:
```cs
<connectionStrings>
    <add name="ShopOnlineContext" connectionString="data source=NGUYENPHUC\TRONGPHUC;initial catalog=FinalProject_NET;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework" providerName="System.Data.SqlClient" />

  <add name="ShopOnlineEntities" connectionString="metadata=res://*/Models.Model1.csdl|res://*/Models.Model1.ssdl|res://*/Models.Model1.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=NGUYENPHUC\TRONGPHUC;initial catalog=FinalProject_NET;integrated security=True;multipleactiveresultsets=True;application name=EntityFramework&quot;" providerName="System.Data.EntityClient" />

</connectionStrings>
```
Bước 4: Trong 2 đoạn code, thay data source thành tên server trong SQL Server của bạn và lưu file (Lưu ý là chúng ta phải thay ở cả hai đoạn code trên).

Bước 5: Build project và hiển thị web.
