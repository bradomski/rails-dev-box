PROJECT='rails'
RUBY_VERSION='2.1.1'
HOME=/home/vagrant

install_postgres () {
  echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > \
    /etc/apt/sources.list.d/pgdg.list
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    sudo apt-key add -
  apt-get update --fix-missing

  apt-get -y install postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3

  pg_dropcluster --stop 9.3 main
  pg_createcluster --start --locale en_US.UTF-8 9.3 main

  cat << EOF > /etc/postgresql/9.3/main/pg_hba.conf
  local   all   postgres                ident
  host    all   postgres  127.0.0.1/32  ident
  host    all   postgres  0.0.0.0/0     reject
  local   all   $PROJECT                trust
EOF

  sudo su - postgres -c 'createuser $PROJECT --createdb'
  service postgresql restart
}

install_ruby () {
  cat << EOF | xargs apt-get -y install
  build-essential
  libc6-dev
  bison
  openssl
  libreadline6
  libreadline6-dev
  zlib1g
  libssl-dev
  libyaml-dev
  libxml2-dev
  libxslt1-dev
  autoconf
  git
  curl
EOF
  git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
  echo export PATH="$HOME/.rbenv/bin:$PATH" >> $HOME/.bashrc
  echo 'eval "$(rbenv init -)"' >> $HOME/.bashrc
  git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  eval "$($HOME/.rbenv/bin/rbenv init -)"
  $HOME/.rbenv/bin/rbenv rehash
  $HOME/.rbenv/bin/rbenv install $RUBY_VERSION
  $HOME/.rbenv/bin/rbenv global $RUBY_VERSION
  $HOME/.rbenv/bin/rbenv rehash

  echo 'gem: --no-ri --no-rdoc' > $HOME/.gemrc
  chown vagrant:vagrant $HOME/.gemrc
  chown -R vagrant:vagrant $HOME/.rbenv
}

cat << EOF >> .bashrc
init_server () {
  gem install bundler
  rbenv rehash
  cd /vagrant/$PROJECT
  bundle
  bin/rake db:create
  cd -
}

run_server () {
  cd /vagrant/$PROJECT
  bundle
  bin/rake db:migrate
  bin/rails server
}
EOF

rm $HOME/postinstall.sh
install_postgres
install_ruby
