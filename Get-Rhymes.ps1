function Get-Rhymes ([string]$word)
{
    $dictionary = New-Object System.IO.StreamReader -Arg "c:\cmudict-0.7b"
    while ($line = $dictionary.ReadLine())
    {
        $wordToMatch = $line -split " "
        if ($word.ToUpper() -eq $wordToMatch[0])
        {
            break
        }
    }
    $dictionary.Close()
    $originalWord = $wordToMatch
    $wordToMatch = Remove-StressIndicator($wordToMatch)
    $phonemesToMatch = Get-PhonemesToMatch($wordToMatch)
    [array]::Reverse($wordToMatch)
    $rhymingWords = @()
    $dictionary = New-Object System.IO.StreamReader -Arg "c:\cmudict-0.7b"
    while ($line = $dictionary.ReadLine())
    {
        $newMatch = $line -split " "
        $doPhonemesMatch = Remove-StressIndicator($newMatch)
        $doPhonemesMatch = Get-PhonemesToMatch($doPhonemesMatch)
        if (("$doPhonemesMatch" -eq "$phonemesToMatch") -and ("$originalWord" -ne "$newMatch"))
        {
            $reversePhenomes = $newMatch
            [array]::Reverse($reversePhenomes)
            $matching = 1
            $index = 0
            foreach ($x in $reversePhenomes)
            {
                if ($x -eq $wordToMatch[($index--)])
                {
                    $matching++
                }
            }
            [array]::Reverse($newMatch)
            $rhymingWords += ($matching,$newMatch)
        }

    }
    $dictionary.Close()
    $wordToMatch -join ' '
    $rhymingWords 
}

function Remove-StressIndicator ([array]$wordToConvert)
{
    $newWordToMatch = @()
    foreach ($section in $wordToConvert)
    {
        if ($section[-1] -match "^[0-2]")
        {
            $newWordToMatch += $section -replace ".$"
        }
        else
        { 
            $newWordToMatch += $section
        }
    }
    $newWordToMatch
}

function Get-PhonemesToMatch ([array]$word)
{
    $phonemes = Import-Csv -Delimiter "`t" -Path "c:\cmudict-0.7b.phones"
    $phonemesHash = @{}
    foreach ($x in $phonemes)
    {
        $phonemesHash[$x.phoneme] = $x.type
    }
    [array]::Reverse($word)
    $phonemesToMatch = @()
    foreach ($section in $word)
    {
        $phonemesToMatch += $section
        if ($phonemesHash[$phonemesToMatch] -eq "vowel")
        {
            break
        }
    }
    $phonemesToMatch
 }