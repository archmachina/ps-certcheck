
# Global settings
$ErrorActionPreference = "Stop"
$InformationPreference = "Continue"
Set-StrictMode -Version 2

Remove-Module CertCheck -EA Ignore
Import-Module ./CertCheck/CertCheck.psm1

@(
    "www.yahoo.com/garbage",
    [PSCustomObject]@{
        Connection = "https://www.google.com.au"
        Sni = "elsewhere.local"
    }, @{
        Connection = "https://www.microsoft.com"
        Sni = "tester.microsoft.com"
    }, @{
        Connection = "https://www.yahoo.com"
        SNI = "Shouldwork"
    }, "https://www.news.com.au",
    [Uri]"https://toggl.com",
    "https://toggl.com",
    "https://www.news.com.au",
    "www.news.com.au:443"
) | Test-EndpointCertificate | Format-List Connection, Sni, Subject, ErrorMsg

Test-EndpointCertificate -Connection "https://www.google.com.au" | Format-Table Connection, Sni, Subject
"https://www.google.com.au" | Test-EndpointCertificate | Format-Table Connection, Sni, Subject
"https://www.google.com.au" | Test-EndpointCertificate -Sni test | Format-Table Connection, Sni, Subject
Test-EndpointCertificate -Connection "https://www.google.com.au" -Sni test | Format-Table Connection, Sni, Subject

Test-EndpointCertificate "https://www.google.com.au" -AsHashTable

@("https://www.google.com.au", "https://www.microsoft.com") | Test-EndpointCertificate -AsHashTable
