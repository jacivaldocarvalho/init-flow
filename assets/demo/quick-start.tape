Output assets/demo/quick-start.gif

Set Shell "bash"
Set Theme "Dracula"
Set FontSize 18
Set Width 1200
Set Height 600
Set TypingSpeed 25ms
Set Framerate 20

Hide
Type "export PS1='$ '; demo_dir=$(mktemp -d); export INITFLOW_PROJECTS_DIR=$demo_dir/projects; clear"
Enter
Show
Type "./scripts/initflow create demo-project --local --readme --no-editor"
Enter
Sleep 2s
Type "ls $INITFLOW_PROJECTS_DIR/demo-project"
Enter
Sleep 1s
Hide
Type "rm -rf -- $demo_dir"
Enter
