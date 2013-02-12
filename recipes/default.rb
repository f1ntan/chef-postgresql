#
# Cookbook Name:: postgresql-cookbook
# Recipe:: default
#
# Copyright 2013, Project10lab.com
#
# All rights reserved - Do Not Redistribute
#
  apt_repository "pitti-postgresql" do
    uri "http://ppa.launchpad.net/pitti/postgresql/ubuntu"
    distribution node["lsb"]["codename"]
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "8683D8A2"
    action :add
    notifies :run, "execute[apt-get update]", :immediately
  end
  
  ENV['LANG'] = "en_US.UTF-8"
  ENV['LANGUAGE'] = "en_US.UTF-8"
  ENV['LC_CTYPE'] = "en_US.UTF-8"
  ENV['LC_NUMERIC'] = "en_US.UTF-8"
  ENV['LC_TIME'] = "en_US.UTF-8"
  ENV['LC_COLLATE'] = "en_US.UTF-8"
  ENV['LC_MONETARY'] = "en_US.UTF-8"
  ENV['LC_MESSAGES'] = "en_US.UTF-8"
  ENV['LC_PAPER'] = "en_US.UTF-8"
  ENV['LC_NAME'] = "en_US.UTF-8"
  ENV['LC_ADDRESS'] = "en_US.UTF-8"
  ENV['LC_TELEPHONE'] = "en_US.UTF-8"
  ENV['LC_MEASUREMENT'] = "en_US.UTF-8"
  ENV['LC_IDENTIFICATION'] = "en_US.UTF-8"
  ENV['LC_ALL'] = "en_US.UTF-8"
  
  package "libpq5" do
    action [:install]
  end
  package "libpq-dev" do
    action [:install]
  end
  package "postgresql-common" do
    action [:install]
  end
  package "postgresql-client-9.1" do
    action [:install]
  end
  package "postgresql-9.1" do
    action [:install]
  end
  
  execute "drop vagrant user" do
    user "postgres"
    command "psql -c \"DROP ROLE IF EXISTS vagrant\""
  end
  
  execute "create user vagrant" do
    user "postgres"
    command "psql -c \"CREATE ROLE vagrant WITH SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'vagrant'\""
  end
  

  service "postgresql" do
    supports :restart => true
    action [:enable, :start]
  end
