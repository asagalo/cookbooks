#
# Cookbook:: appserver
# Recipe:: configure
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

search(:aws_opsworks_app).each do |app|
  root_dir = app['attributes']['document_root'] || "/srv/www/#{app['shortname']}/current"

  template "#{node['nginx']['dir']}/sites-available/#{app['shortname']}" do
    source 'site.erb'
    owner "root"
    group "root"
    mode 0644
    variables(:application => app, :root_dir => root_dir)
  end

  nginx_site 'enable site' do
    name app['shortname']
    action :enable
  end

end

service 'nginx' do
  action :restart
end
