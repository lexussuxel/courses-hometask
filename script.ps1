param(
  [string]$repo,
  [string]$dir
)

if (-not $repo -or -not $dir) {
    Write-Error "You should add -repo and -dir"
    exit
}

git clone $repo $dir

Set-Location ./$dir

$desc = git describe --tags

if($desc.Contains("-")){
  Write-Host "Commits after tag"
  $major = [int]$desc[0]
  $minor = [int]$desc[2]
  $patch = [int]$desc[4] + 1

  $newTag = "$major.$minor.$patch" 

  git tag -a $newTag -m "Updating version to $newTag"
  git push origin $newTag

  Set-Location ..

  Remove-Item -Recurse -Force "./$dir"
} else {
 Write-Host "No changes"
   Set-Location ..

  Remove-Item -Recurse -Force "./$dir"
}