<cfscript>
    // Загрузка драйвера
    driverPath = "/opt/lucee/server/lucee-server/bundles/org.postgresql.jdbc-42.7.3.jar"; // Укажите путь к вашему jar файлу
    createObject("java", "org.postgresql.Driver").new();
    createObject("java", "java.sql.DriverManager").registerDriver(createObject("java", "org.postgresql.Driver").new());
    
    // Чтение переменных окружения для подключения к БД
    dbHost = createObject("java", "java.lang.System").getenv("DB_HOST") ?: "";
    dbPort = createObject("java", "java.lang.System").getenv("DB_PORT") ?: "5432";
    dbName = createObject("java", "java.lang.System").getenv("DB_NAME") ?: "";
    dbUser = createObject("java", "java.lang.System").getenv("DB_USER") ?: "";
    dbPassword = createObject("java", "java.lang.System").getenv("DB_PASSWORD") ?: "";
    
    // Строка подключения к базе данных
    jdbcUrl = "jdbc:postgresql://" & dbHost & ":" & dbPort & "/" & dbName;

    // Создание объекта соединения
    dbConnection = createObject("java", "java.sql.DriverManager").getConnection(jdbcUrl, dbUser, dbPassword);
    
    // Создание запроса
    stmt = dbConnection.createStatement();
    rs = stmt.executeQuery("SELECT id, name, email FROM users");
</cfscript>

<cfoutput>
    <h2>Hello, Lucee! Today's date is #dateFormat(now(), 'yyyy-mm-dd')#.</h2>
    <h3>Users List:</h3>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
        <cfloop>
            <cfif rs.next()>
                <tr>
                    <td>#rs.getInt("id")#</td>
                    <td>#rs.getString("name")#</td>
                    <td>#rs.getString("email")#</td>
                </tr>
            </cfif>
        </cfloop>
    </table>
</cfoutput>

<cfscript>
    // Закрытие ресурсов
    rs.close();
    stmt.close();
    dbConnection.close();
</cfscript>
