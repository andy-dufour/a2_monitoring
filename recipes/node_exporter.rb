remote_file '/tmp/node_exporter-0.16.0.linux-amd64.tar.gz' do
  source 'https://github.com/prometheus/node_exporter/releases/download/v0.16.0/node_exporter-0.16.0.linux-amd64.tar.gz'
end

execute 'tar xvf /tmp/node_exporter-0.16.0.linux-amd64.tar.gz' do
  cwd '/opt/'
end

link '/opt/node_exporter' do
  to '/opt/node_exporter-0.16.0.linux-amd64'
end

file '/etc/systemd/system/node_exporter.service' do
  content <<EOF
[Unit]
Description=Node Exporter

[Service]
User=root
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=multi-user.target
EOF
end

service 'node_exporter' do
  action [:enable, :start]
end
