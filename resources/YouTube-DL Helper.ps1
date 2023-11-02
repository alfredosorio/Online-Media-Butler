Write-Host 'Online Media Butler'
Write-Host 'By Alfred Osorio 2019'

Write-Host

# Set default download location
# The download location is also set in the video_config and audio_config files.
$dl_loc = "$home\Downloads"
Write-Host "Files will be saved to: $($dl_loc)"

# Set yt-dlp config locations
$audio_config = "$((Get-Item -Path '.\').FullName)\youtube-dl_audio.conf"
$video_config = "$((Get-Item -Path '.\').FullName)\youtube-dl_video.conf"
$subtitle_config = "$((Get-Item -Path '.\').FullName)\youtube-dl_video_with_subtitles.conf"

# Prompt format
$choice_prompt = 'Select format:'
$options = [System.Management.Automation.Host.ChoiceDescription[]] @(
    "&Video and Audio",
    "Include &Subtitles",
    "&Audio Only",
    "&List",
    "&Update",
    "&Quit"
)

[int]$defaultChoice = 0
$opt = $host.UI.PromptForChoice($choice_prompt, $Info, $options, $defaultChoice)
switch($opt)

{
    # Video and Audio
    0 {
        $url = Read-Host -Prompt "`nEnter URL"
        yt-dlp --config-location "$video_config" "$url"
      }

    # Include Subtitles
    1 {
        $url = Read-Host -Prompt "`nEnter URL"
        yt-dlp --config-location "$subtitle_config" "$url"
      }

    # Audio Only
    2 { 
        $url = Read-Host -Prompt "`nEnter URL"
        yt-dlp --config-location "$audio_config" "$url" 
      }

    # List
    3 { Add-Type -AssemblyName System.Windows.Forms
        $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
          Multiselect = $false # Allow only single file selection.
	        Filter = 'Text Files (*.txt)|*.txt' # Specified file types
        }
        [void]$FileBrowser.ShowDialog()
        $file = $FileBrowser.FileName;
        
        If($FileBrowser.FileNames -like "*\*") {
            # Perform List action
	        $url_list = $FileBrowser.FileName
            yt-dlp -ci --batch-file=$url_list --config-location "$video_config"
        } else {
            Write-Host "Cancelled by user. . ."
        }
      }

    # Update
    4 { 
        Write-Host "`n"

        function pause {
            $null = Read-Host 'Press Enter to close. . .'
        }
        pip install --upgrade yt-dlp
      }
}

# Restart application
Start-Process -FilePath "$((Get-Item -Path '.\').FullName)\Online Media Butler.lnk"

# Open containing folder
# Invoke-Item $dl_loc