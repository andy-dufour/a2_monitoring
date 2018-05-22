remote_file '/tmp/elasticsearch_exporter-1.0.2.linux-amd64.tar.gz' do
  source 'https://github.com/justwatchcom/elasticsearch_exporter/releases/download/v1.0.2/elasticsearch_exporter-1.0.2.linux-amd64.tar.gz'
end

execute 'tar xvf /tmp/elasticsearch_exporter-1.0.2.linux-amd64.tar.gz' do
  cwd '/opt/'
end

link '/opt/elasticsearch_exporter' do
  to '/opt/elasticsearch_exporter-1.0.2.linux-amd64'
end

file '/etc/systemd/system/es_exporter.service' do
  content <<EOF
[Unit]
Description=ES Exporter

[Service]
User=root
ExecStart=/opt/elasticsearch_exporter/elasticsearch_exporter -es.uri=http://127.0.0.1:10141

[Install]
WantedBy=multi-user.target
EOF
end

service 'es_exporter' do
  action [:enable, :start]
end
