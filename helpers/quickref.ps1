function Get-VariableFiles {
    [CmdletBinding()]Param($variable, $files)
    <#
    .SYNOPSIS
        This is used to check all variables are implemented.
    #>
        $Payload = @()
        foreach($file in $files)
        {
             $Content = Get-Content $file.FullName
             $results = $Content | Select-String $variable
             if($results){
                $Payload += [PSCustomObject] @{
                    Result    =  "$($results | Select-Object -Unique)"
                    File      = "<nowiki>$($file.Name)</nowiki>";
                }
            }
        }
        return $Payload
    }

    function Get-Info {
    [CmdletBinding()]Param($line, $info)
    <#
    .SYNOPSIS
        Gets a clean variable.
    #>
        $line = $line -replace $info
        $line = $line -replace "{"
        $line = $line -replace "}"
        $line = $line -replace "="
        $line = $line -replace '"'
        $info = $line.Trim()
        return $info
    }

    function ConvertTo-MarkDownTable {
        [CmdletBinding()] param(
            [Parameter(Position = 0, ValueFromPipeLine = $True)] $InputObject
        )
        Begin { $Index = 0 }
        Process {
            if ( !$Index++ ) {
                '|' + ($_.PSObject.Properties.Name -Join '|') + '|'
                '|' + ($_.PSObject.Properties.ForEach({ '-' }) -Join '|') + '|'
            }
            '|' + ($_.PSObject.Properties.Value -Join '|') + '|'
        }
    }

    $module_variables = Get-ChildItem -Path $(get-location | split-path) -Filter *variables*.tf -Depth 1 -File
    $root = $(get-location | split-path).Split("\") | Select-Object -Last 1 
    $Payload = @()
    foreach($file in $module_variables)
    {
        $Content          = Get-Content -Path $file.PSPath
        $variables        = $Content | Select-String "variable"
        $current          = $($file.PSPath | split-path).Split("\") | Select-Object -Last 1
        if($root -ne $current) {$folder = $current+"\"} Else {$folder = $null}
        $module_terraform = Get-ChildItem -Path $($file.PSPath | split-path) -Filter *.tf -Recurse -Depth 1 -File | Where-Object {$_.Name -notmatch "variables"}
        $module_docs      = Get-ChildItem -Path "$(get-location | split-path)\user-guide" -Filter *.md -Recurse -Depth 0 -File | Where-Object {$_.Name -notmatch "quickref"}
        $count            = 0
        foreach($line in $variables)
        {
            $variable          = (Get-Info -line $line -info "variable")
            $implementations   = Get-VariableFiles -variable $variable -file $module_terraform
            $references        = Get-VariableFiles -variable $variable -file $module_docs
            try
            {
                if($content[$line.LineNumber+1] -and $content[$line.LineNumber+1].Contains("default")){
                    $default       = $content[$line.LineNumber+1]
                }
                Else {
                    $default = ""
                }
                if($content[$line.LineNumber] -and $content[$line.LineNumber].Contains("description"))
                {
                    $description = $content[$line.LineNumber]
                }
                Else {
                    $description = ""
                }
            }
            catch {
                Write-Error $_.Exception.message
            }        
            $Payload += [PSCustomObject] @{
                I             = if($folder) {1} Else {0};
                Origin        = "<nowiki>$folder$($file.Name)</nowiki>";
                Line          = if($line.LineNumber) {$line.LineNumber} Else {""};
                Variable      = $variable;
                Default       = if($default) {(Get-Info -line $default -info "default")} Else {""};
                Description   = if($description) {(Get-Info -line $description -info "description")} Else {""};
                Implemented   = if($implementations){[system.String]::Join(" ", $implementations.File)} Else {""};
                Documented    = if($references){[system.String]::Join(" ", $references.File)} Else {""};
            }
            $count++
        }
    }
$Payload | Sort-Object I,Origin,Variable | ConvertTo-MarkDownTable | Out-File "$(get-location | split-path)\user-guide\quickref.md" -Force
Write-Output "Completed quickref document update!"