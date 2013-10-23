#
# Cookbook Name:: database
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

databases = %w(activerecord_unittest activerecord_unittest2)

# postgresql

template "#{node[:postgresql][:dir]}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  notifies :restart, "service[postgresql]", :immediately
end

postgresql_connection_info = {
  :host     => "localhost",
  :password => node['postgresql']['password']['postgres']
}

databases.each do |database|
  postgresql_database database do
    connection postgresql_connection_info
    encoding "UTF8"
    template "template0"
    collation "en_US.UTF-8"
    action :create
  end
end

postgresql_database_user 'vagrant' do
  connection postgresql_connection_info
  privileges [:Superuser]
  password ""
  action :create
end

databases.each do |database|
  postgresql_database_user 'vagrant' do
    connection postgresql_connection_info
    database_name database
    privileges [:all]
    action :grant
  end
end
