This cookbook includes support for running tests via Test Kitchen. This has some requirements.

1. You must be using the Git repository, rather than the downloaded cookbook from the Chef Community Site.
2. You must have Vagrant 1.1 (or later) installed.
3. You must have a "sane" Ruby 1.9.3 environment.

Once the above requirements are met, use bundler to install the additional requirements:

    gem install bundler
    bundle install

Once bundler has installed the requirements, you should be able to run Test Kitchen:

    bundle exec kitchen list
    bundle exec kitchen test


