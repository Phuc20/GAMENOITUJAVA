# Cấu hình kết nối database cho Java ứng dụng (ví dụ dùng MySQL)

db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/your_database_name?useSSL=false&serverTimezone=UTC
db.username=your_db_username
db.password=your_db_password

# Pool size (nếu dùng connection pool, ví dụ HikariCP, DBCP...)
db.initialSize=5
db.maxTotal=20

# Nếu dùng Hibernate/JPA, có thể cấu hình thêm
hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
hibernate.show_sql=true
hibernate.hbm2ddl.auto=update