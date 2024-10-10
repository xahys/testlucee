<cfscript>
    // Чтение переменных окружения для подключения к БД
    dbHost = System.getenv("DB_HOST");
    dbPort = System.getenv("DB_PORT") ?: "5432";
    dbName = System.getenv("DB_NAME");
    dbUser = System.getenv("DB_USER");
    dbPassword = System.getenv("DB_PASSWORD");
    
    // Строка подключения к базе данных
    datasource = "postgresDSN";
    
    // Создаем и настраиваем источников данных, если он еще не существует
    if (!datasourceExists(datasource)) {
        datasourceCreate(
            dsn = datasource, 
            database = dbName, 
            username = dbUser, 
            password = dbPassword, 
            class = "org.postgresql.Driver",
            url = "jdbc:postgresql://" & dbHost & ":" & dbPort & "/" & dbName
        );
    }
</cfscript>

<cfquery name="userData" datasource="#datasource#">
    SELECT id, name, email FROM users
</cfquery>

<cfoutput>
    <h2>Hello, Lucee! Today's date is #dateFormat(now(), 'yyyy-mm-dd')#.</h2>
    <h3>Users List:</h3>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
        <cfloop query="userData">
            <tr>
                <td>#id#</td>
                <td>#name#</td>
                <td>#email#</td>
            </tr>
        </cfloop>
    </table>
</cfoutput>
