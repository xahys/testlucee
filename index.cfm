<cfscript>
    system = createObject("java", "java.lang.System");
    
    // Чтение переменных окружения для подключения к БД
    dbHost = system.getenv("DB_HOST") ?: "";
    dbPort = system.getenv("DB_PORT") ?: "5432";
    dbName = system.getenv("DB_NAME") ?: "";
    dbUser = system.getenv("DB_USER") ?: "";
    dbPassword = system.getenv("DB_PASSWORD") ?: "";
    
    // Определение источника данных
    datasource = "postgresDSN";
</cfscript>

<cftry>
    <!--- Пробуем выполнить запрос --->
    <cfquery name="userData" datasource="#datasource#">
        SELECT id, name, email FROM users
    </cfquery>

    <cfcatch type="database">
        <!--- Если ошибка базы данных, создаем источник данных --->
        <cfscript>
            datasourceCreate(
                dsn = datasource, 
                database = dbName, 
                username = dbUser, 
                password = dbPassword, 
                class = "org.postgresql.Driver",
                url = "jdbc:postgresql://" & dbHost & ":" & dbPort & "/" & dbName
            );
        </cfscript>
        
        <!--- Повторное выполнение запроса после создания источника --->
        <cfquery name="userData" datasource="#datasource#">
            SELECT id, name, email FROM users
        </cfquery>
    </cfcatch>
</cftry>

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
