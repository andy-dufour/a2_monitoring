remote_file '/tmp/prometheus-2.2.1.linux-amd64.tar.gz' do
  source 'https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-amd64.tar.gz'
end

execute 'tar xvf /tmp/prometheus-2.2.1.linux-amd64.tar.gz' do
  cwd '/opt/'
end

link '/opt/prometheus' do
  to '/opt/prometheus-2.2.1.linux-amd64'
end

file '/opt/prometheus/prometheus.yml' do
  content <<EOF
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 15s

    static_configs:
      - targets: ['localhost:9100']
EOF
end

file '/etc/systemd/system/prometheus.service' do
  content <<EOF
[Unit]
Description=Prometheus

[Service]
User=root
ExecStart=/opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml

[Install]
WantedBy=multi-user.target
EOF
end

service 'prometheus' do
  action [:enable, :start]
end
