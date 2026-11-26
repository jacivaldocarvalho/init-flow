Output assets/demo/customization.gif

Set Shell "bash"
Set Theme "Dracula"
Set FontSize 18
Set Width 1200
Set Height 600
Set TypingSpeed 25ms
Set Framerate 20

Hide
Type "export PS1='$ '; demo_dir=$(mktemp -d); clear"
Enter
Show
Type "./scripts/initflow create custom-app --dry-run --private --readme --description 'Tools & automation' --path $demo_dir/custom-projects --no-editor"
Enter
Sleep 2s
Hide
Type "rm -rf -- $demo_dir"
Enter
