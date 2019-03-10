Write-Host 'Online Media Butler'
Write-Host 'By Alfred Osorio 2019'

Write-Host 

# Set default download location
$dl_loc = "$home\Downloads"
Write-Host "Files will be saved to: $($dl_loc)"

# Prompt URL
$url = Read-Host -Prompt "`nEnter URL"

# Set youtube-dl config locations
$audio_config = "$((Get-Item -Path '.\').FullName)\youtube-dl_audio.conf"
$video_config = "$((Get-Item -Path '.\').FullName)\youtube-dl_video.conf"

# Prompt format
$choice_prompt = 'Select format:'
$options = [System.Management.Automation.Host.ChoiceDescription[]] @("&Video and Audio", "&Audio Only", "&Quit")
[int]$defaultChoice = 0
$opt = $host.UI.PromptForChoice($choice_prompt, $Info, $options, $defaultChoice)
switch($opt)

# Perform actions
{
    0 { youtube-dl --config-location "$video_config" "$url" }
    1 { youtube-dl --config-location "$audio_config" "$url" }
}

# Open containing folder
Invoke-Item $dl_loc