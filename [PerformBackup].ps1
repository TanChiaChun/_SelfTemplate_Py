# Read input
$dest_dir = Read-Host "Input destination folder"

# Check if file exist, rename if yes
if (Test-Path "requirements\requirements.txt") {
    $cur_date = Get-Date -Format "yyyy-MM-ddTHHmm"
    Rename-Item -Path "requirements\requirements.txt" -NewName "requirements_$cur_date.txt"
}

# Check if folder exist, create if no
if (-not (Test-Path -Path "requirements") ) {
    New-Item -Name "requirements" -ItemType "directory"
}

# Run Python pip for requirements.txt
venv\Scripts\python -m pip freeze > requirements\requirements.txt

# Check if destination folder exist, delete if yes
if (Test-Path -Path "$dest_dir\.git") {
    Remove-Item "$dest_dir\.git" -Recurse -Force
}
# Check if destination folder exist, create if no
if (-not (Test-Path -Path "$dest_dir\requirements") ) {
    New-Item -Path $dest_dir -Name "requirements" -ItemType "directory"
}

# Copy file
Copy-Item "*.py" -Destination $dest_dir
Copy-Item "requirements\requirements*.txt" -Destination "$dest_dir\requirements"
Copy-Item ".gitignore" -Destination $dest_dir
Copy-Item "*.ps1" -Destination $dest_dir

# Copy folder
Copy-Item -Path ".git" -Destination $dest_dir -Recurse

# Change folder attribute to hidden
$temp_folder = Get-Item $dest_dir\.git
$temp_folder.Attributes = "Hidden"

Read-Host "Completed! Press any key to continue..."