1. Find user email and org code
2. Edit and run this code (replace `originalString`) (in https://dotnetfiddle.net/ for example):
(based on https://devops.wisetechglobal.com/wtg/BorderWise/_git/UMP?path=%2FBackend%2FUmp%2FHelpers%2FCryptoServiceProviders%2FCw1CryptoServiceProvider.cs&_a=contents&version=GBmaster)
```
using System;
using System.Security.Cryptography;
using System.Text;

public class SimpleEncryptor
{
    private TripleDESCryptoServiceProvider CryptoServiceProvider;

    public SimpleEncryptor()
    {
        CryptoServiceProvider = new TripleDESCryptoServiceProvider();
        // Disable warning for weak cryptographic algorithm
        // Set the key
        CryptoServiceProvider.Key = MD5.HashData(Encoding.ASCII.GetBytes("w;lerhpoihpOIYO&)(*&LKJ%$#%$TDFGLKJ;lwkjer;tlkwh"));
        CryptoServiceProvider.IV = new byte[8] { 240, 3, 45, 29, 0, 76, 173, 59 };
    }

    public string Encode(string data)
    {
        var buffer = Encoding.ASCII.GetBytes(data);
        var encryptor = CryptoServiceProvider.CreateEncryptor();
        var encryptedBuffer = encryptor.TransformFinalBlock(buffer, 0, buffer.Length);
        return Convert.ToBase64String(encryptedBuffer);
    }

    static void Main(string[] args)
    {
        var simpleEncryptor = new SimpleEncryptor();
        string originalString = "UserEmail=carol@atoshipping.com&OrgCode=ACROCEMEL2";
        string encryptedString = simpleEncryptor.Encode(originalString);

        Console.WriteLine(originalString);
	Console.WriteLine(encryptedString);
    }
}
```
3. Urlencode the encrypted string and make request: `curl -X 'GET'   'https://ump.borderwise.com/api/v1/auth/autoLogin/url?securedQueryString=xVFTBNulvHlQQgZJHe3KtPprlrsli1qGPeQFTD0/ZPiVeWl7YNdJ8aXuGkNSlpo3ki/g9sYd7nY='   -H 'accept: */*'`
4. You get URL, use it for logging in: `{"Url":"https://app.borderwise.com/?authtoken=uIirYxlnicd4I%2bqoQpcbqnx8ZLoeBl2SU3812C1wzDhmIIMv06ph8McHt69h%2fOF4","`
5. It will also work on local for debugging, just make sure to use prod API in `.env`

Happy debugging!