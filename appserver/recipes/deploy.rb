#
# Cookbook:: appserver
# Recipe:: deploy
#
# Copyright:: 2017, The Authors, All Rights Reserved.

search(:aws_opsworks_app).each do |app|
  deploy_dir = "/srv/www/#{app['shortname']}/releases/#{Time.now.to_i}"
  root_dir = app['attributes']['document_root'] || "/srv/www/#{app['shortname']}/current"

  directory deploy_dir do
    owner node['deployer']['user'] || 'root'
    group node['deployer']['group']
    mode "0775"
    action :create
    recursive true
  end

  application deploy_dir do
    git deploy_dir do
      repository app['app_source']['url']
      revision app['app_source']['revision']
      environment({ GIT_SSH: app['app_source']['ssh_key'] })
    end

    link root_dir do
      to deploy_dir
      link_type :symbolic
    end
  end
end
