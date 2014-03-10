# cf-jenkins::aws mounts the persistent disk that holds jenkins config, so it
# must happen first.
include_recipe 'cf-jenkins::aws'
include_recipe 'selfsigned_certificate'

# workaround for broken debian package of current/newest version of jenkins:
# https://issues.jenkins-ci.org/browse/JENKINS-20407?page=com.atlassian.streams.streams-jira-plugin:activity-stream-issue-tab
directory '/var/run/jenkins' do
  action :create
end

include_recipe 'jenkins::server'
include_recipe 'jenkins::proxy'

service 'jenkins' do
  action :restart
  notifies :create, 'ruby_block[block_until_operational]', :immediately
end
