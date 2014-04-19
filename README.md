# rails-postgres-dev-box

## Dependencies

* Vagrant
* A provider for vagrant (e.g. VirtualBox)

## Usage

    $ vagrant up
    $ vagrant ssh

After vagrant ssh

    $ init_server
    $ run_server

This project assumes you have a rails project located in vagrant base directory.

Optionally, a file called 'config.sh' located in the vagrant base directroy will be
used by the provisioner to set certain variables. The following variables are
currently available for configuration:

* PROJECT default: 'rails'; used for the rails project folder and database user
* RUBY\_VERSION default: '2.1.1'; a valid rbenv ruby-build ruby version to install

## Why not rails/rails-dev-box?

* rails-dev-box uses rvm. I prefer rbenv.
* I'd rather use maintained and supported plugins.
* rails-dev-box creates a postgres template with ASCII (not a sane default).

## License

MIT
