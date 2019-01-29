# 2019-01-28
# 374
# Easy
# Additive Persistence
# https://www.reddit.com/r/dailyprogrammer/comments/akv6z4/20190128_challenge_374_easy_additive_persistence/

function Get-AdditivePersistence { 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, [int]::MaxValue)]
        [int]$Number
    )
    begin {
        Set-StrictMode -Version Latest
        $ErrorActionPreference = "Stop"
        $Iterations = 0

        function Convert-IntToArray ([int]$x) {
            [int[]][string[]][char[]][string]$x
        }

        function Add-Digits ($x) {
            $Sum = 0
            $x = Convert-IntToArray $x
            foreach ($n in $x) {
                $y = [int]$n
                $Sum = $Sum + [int]$y
            }
            Write-Output $Sum
        }
    }
    
    process {
        while ($Number / 10 -ge 1) {
            $Iterations += 1
            $Number = Add-Digits $Number
        }
    }

    end {
        Write-Output $Iterations
    }
}

Get-AdditivePersistence 13
Get-AdditivePersistence 1234
Get-AdditivePersistence 9876
Get-AdditivePersistence 199