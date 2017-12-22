# Setup

## Run Nourish for realsies, out on the internet

<< coming soon >>

## Run Nourish on your laptop, as a developer

### Get the code

1. Use GitHub to fork the project.

1. Clone your fork to your own computer.

 ```
 cd /where/you/keep/your/code
 git clone git@github.com:yourusername/nourish.party.git
 ```

### Install dependencies

#### On a Mac

1. Install [Homebrew](https://brew.sh).

1. Install PostgreSQL using Homebrew, and start it.

```
brew install postgresql
brew services start postgresql
```

1. Install Ruby using a Ruby version manager of your choice. If you're new to
 Ruby and don't have opinions about version managers yet, we suggest
 [RVM](https://rvm.io) -- it's stable and well-documented.

1. Install Yarn, either via https://yarnpkg.com/en/docs/install or using your package manager of choice. On OS X with Homebrew, use `brew install yarn`
1. Run the setup script:

 ```
 cd /path/to/nourish.party
 bin/setup
 ```

 If you get a Ruby version error, try installing the specified version of Ruby
 using your favorite Ruby version manager. For RVM, this will be
 `rvm install 2.4.2`. Then try running `bin/setup` again.
