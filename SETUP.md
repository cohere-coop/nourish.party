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
 cd /path/to/nourish
 bin/setup
 ```

 If you get a Ruby version error, try installing the specified version of Ruby
 using your favorite Ruby version manager. For RVM, this will be
 `rvm install 2.4.2`. Then try running `bin/setup` again.

### Run the Application
```
cd /path/to/nourish
bin/serve
```
This starts several processes:

1. The actual application, running on http://localhost:3000
1. The asset builder and styleguide, which can be viewed at on http://localhost:3000/packs/styleguide
1. The ruby code documentation viewer, available at http://localhost:8808/
1. The installed gems code documentation viewer, available at http://localhost:8809/

### Get to know the Code

Once you are running the server, you can explore the style guide by pointing your browser to http://localhost:3000/packs/styleguide as well as explore the documented code by opening http://localhost:8808/
