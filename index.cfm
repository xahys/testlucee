<cfoutput>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Users List</title>
        <style>
            table {
                width: 50%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <h2>Hello, Lucee! Today's date is #dateFormat(now(), 'yyyy-mm-dd')#.</h2>
        <h3>Users List:</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
            </tr>
            <cfquery name="getUsers" datasource="pg">
                SELECT id, name, email FROM users
            </cfquery>
            
            <cfloop query="getUsers">
                <tr>
                    <td>#getUsers.id#</td>
                    <td>#getUsers.name#</td>
                    <td>#getUsers.email#</td>
                </tr>
            </cfloop>
        </table>
    </body>
    </html>
</cfoutput>
