# Contributing to lookup

We encourage the developer community to contribute to this repository.

## Editor Configurations

Configuring your editor to use our lint and code style rules will make the code review process delightful!

### Code formatting

[Prettier](https://prettier.io/) is a code formatter used to ensure consistent formatting across your code base. To use Prettier with Visual Studio Code, install [this extension](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) from the Visual Studio Code Marketplace. The [.prettierignore](/.prettierignore) and [.prettierrc](/.prettierrc.json) files are provided as part of this repository to control the behavior of the Prettier formatter.

### Code linting

[ESLint](https://eslint.org/) is a popular JavaScript linting tool used to identify stylistic errors and erroneous constructs. The [.eslintignore](/.eslintignore) file is provided as part of this repository to exclude specific files from the linting process.

### Git Workflow

The process of submitting a pull request is fairly straightforward and
generally follows the same pattern each time:

1. [Fork the lookup repo](#fork-the-lookup-repo)
1. [Create a feature branch](#create-a-feature-branch)
1. [Make your changes](#make-your-changes)
1. [Rebase](#rebase)
1. [Check your submission](#check-your-submission)
1. [Create a pull request](#create-a-pull-request)
1. [Update the pull request](#update-the-pull-request)

### Fork the lookup repo

[Fork][fork-a-repo] the [jdkgabri/lookup](https://github.com/jdkgabri/lookup) repo. Clone your fork in your local workspace and [configure][configuring-a-remote-for-a-fork] your remote repository settings.

```bash
git clone git@github.com:<YOUR-USERNAME>/lookup.git
cd lookup
git remote add upstream git@github.com:jdkgabri/lookup.git
```

### Create a feature branch

```bash
git checkout master
git pull origin master
git checkout -b feature/<name-of-the-feature>
```

### Make your changes

Modify the files, build, test, lint and eventually commit your code using the following command:

```bash
git add <path/to/file/to/commit>
git commit ...
git push origin feature/<name-of-the-feature>
```

Commit your changes using a descriptive commit message

The above commands will commit the files into your feature branch. You can keep
pushing new changes into the same branch until you are ready to create a pull
request.

### Rebase

Sometimes your feature branch will get stale with respect to the master branch,
and it will require a rebase. The following steps can help:

```bash
git checkout master
git pull upstream master
git checkout feature/<name-of-the-feature>
git rebase upstream/master
```

_note: If no conflicts arise, these commands will ensure that your changes are applied on top of the master branch. Any conflicts will have to be manually resolved._

### Check your submission

#### Run tests

Test your change by running the unit tests.

### Create a pull request

If you've never created a pull request before, follow [these
instructions][creating-a-pull-request].

### Update the pull request

```sh
git fetch origin
git rebase origin/${base_branch}

# If there were no merge conflicts in the rebase
git push origin ${feature_branch}

# If there was a merge conflict that was resolved
git push origin ${feature_branch} --force
```

_note: If more changes are needed as part of the pull request, just keep committing and pushing your feature branch as described above and the pull request will automatically update._

[fork-a-repo]: https://help.github.com/en/articles/fork-a-repo
[configuring-a-remote-for-a-fork]: https://help.github.com/en/articles/configuring-a-remote-for-a-fork
[creating-a-pull-request]: https://help.github.com/articles/creating-a-pull-request/