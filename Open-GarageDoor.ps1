function Open-GarageDoor ([array]$commands)
{
    $state = "Door: CLOSED"
    $state
    foreach ($command in $commands)
    {
        if ($command -eq "button_clicked")
        {
            if ($state -eq "Door: CLOSED" -or $state -eq "Door: STOPPED_WHILE_CLOSING") 
            {
                $state = "Door: OPENING"
            }
            elseif ($state -eq "Door: OPEN" -or $state -eq "Door: STOPPED_WHILE_OPENING") 
            {
                $state = "Door: CLOSING"
            }
            elseif ($state -eq "Door: CLOSING") 
            {
                $state = "Door: STOPPED_WHILE_CLOSING"
            }
            else
            {
                $state = "Door: STOPPED_WHILE_OPENING"
            }
        }
        else {
            if ($state -eq "Door: OPENING")
            {
                $state = "Door: OPEN"
            }
            else
            {
                $state = "Door: CLOSED"
            }
        }
        $command
        $state
    }
}