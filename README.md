# codeboxx_review
Tool for reviewing Codeboxx' students code

## Quickstart

Please set the repositories of the student in the variable 'STUDENTS' at the beginning of 'prepare_workspace_review_ruby.sh', 'prepare_workspace_review_api.sh', 'launch_ruby.sh' and 'launch_api.sh'.

Use the format STUDENT_GITHUB_USERNAME+STUDENT_REPO_NAME.

For 'ruby' scripts, use the github repository for the Ruby app, for 'api' scripts, use the github repository for the C# API.

### Ruby

For building the ruby app with dedicated databases on Docker

```bash
./prepare_workspace_review_ruby.sh
```

For running the ruby app, with reset of the database

```bash
./launch_ruby.sh
```

The Ruby app will stay as a foreground process, kill the current app of the current student using Ctrl+C, it will try to launch the app from the next student of the list

### C sharp

For building the C# API

```bash
./prepare_workspace_review_api.sh
```

For running the C# API

```bash
./launch_api.sh
```

The C# API app will stay as a foreground process, kill the current app of the current student using Ctrl+C, it will try to launch the app from the next student of the list.

### Combination

You can run 'launch_api.sh' and 'launch_ruby.sh' in two different consoles in order to have the two processes running at the same time.