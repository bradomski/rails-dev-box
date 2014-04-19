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

This project assumes you have a rails project located in the same directory as the Vagrantfile


## Why not rails/rails-dev-box?

* rails-dev-box uses rvm. I prefer rbenv.
* I'd rather use maintained and supported plugins.
* rails-dev-box creates a postgres template with ASCII (not a sane default).

## License

MIT
