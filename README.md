# - CQ LAB -
Organize and manage efficiently your inventory items.

### Prerequisites

- [Ruby 3.0.2](https://www.ruby-lang.org/en/downloads/)
- gem rails (v 6.1.4.1)
- gem bundler
- Postgresql (v 14.1) 

### Set up

Start in your folder with dev projects

- `gh repo clone OoKiaoO/Sugoi_Labs`
- `cd Sugoi_Labs`
- `bundle install`
- `yarn install`
- `rails db:create db:migrate db:seed`

### Running

Start in the project folder

- `rails s`

### Development process

Start in the project folder

- make sure you are on master branch and the working directory is clean (`git st` returns empty)
    - If it lists red files with a letter run `git stash`. If it lists red files with question marks remove the files `rm path/to/file`
- `git pull origin master`
- check the changes in files (Changed file -> run command):
    - Bundler -> `bundle install`
    - package-lock.json -> `yarn install`
    - db/schema.rb (and new files in db/migrate/) -> `rails db:migrate`
    - db/seeds.rb -> `rails db:seed`
- checkout to new branch `git checkout branch_name`
- work on the code
- implement tests covering your code
- add changes `git add path/to/file`
- commit changes `git commit -m "message describing the change"`
- check each item on the PRE-PUSH CHECKLIST below
- push `git push origin branch_name` or `git push origin HEAD`
- go to GitHub, open a PR, and add a short description of what the PR is about
- tag [OoKiaoO](https://github.com/OoKiaoO) for the PR review
