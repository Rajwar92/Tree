
Run the following script in Powershell to encode a password/secret. The resulting value can be stored in source control and will be decrypted by DAT during deployment.

`$plaintext = (Read-Host -Prompt "Enter text to encrypt"); $plaintextBytes = [System.Text.Encoding]::UTF8.GetBytes($plaintext); $crypto = [System.Security.Cryptography.RSACryptoServiceProvider]::new(); try { $crypto.FromXmlString("<RSAKeyValue><Modulus>uJFr8lEdDZ6fUXQTiwKRVMrhS7t4oR6/eCuajCQARwIjO3v46HPefEgyMFC6uxGyQg+S7n4xAIfN5a4Ax5yimn5XQNamxgNRQpBQ5mcrGx7r/vRfLqUtt54N4pgwq77arJEMJDEtU+B3wjF+5bMUE1gHmc3Cs5XzGwWbFLHMmWk=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>"); $encrypted = $crypto.Encrypt($plaintextBytes, $true); Write-Host ([Convert]::ToBase64String($encrypted)) } finally { $crypto.Dispose() }`

Contact your team lead to store the original password/secret in https://safe.wisetechglobal.com/