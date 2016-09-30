function Get-ShannonEntropy ([string]$str)
{
    $frequency = New-Object System.Collections.Hashtable
    foreach ($x in $str.ToCharArray())
    {
        $frequency.$x += 1
        $sumOfValues += 1
    }
    foreach ($p in $frequency.GetEnumerator())
    {
        $h = $h + -1 * ($p.Value / $sumOfValues) * ([Math]::Log($p.Value / $sumOfValues) / [Math]::Log(2))
    }
    $h
}