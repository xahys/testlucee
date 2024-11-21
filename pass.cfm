<cfscript>
    // Получаем экземпляр PasswordManager
    passwordManager = getInstance('PasswordManager@lucee-password-util');
    
    // Шифруем строку
    encryptedValue = passwordManager.encryptDataSource('password12345');
    
    // Выводим зашифрованное значение
    writeOutput("Encrypted Value: " & encryptedValue);
</cfscript>
