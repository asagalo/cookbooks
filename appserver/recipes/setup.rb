#
# Cookbook:: appserver
# Recipe:: setup
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'deployer::default'
include_recipe 'chef_nginx::package'

python_runtime '3'


