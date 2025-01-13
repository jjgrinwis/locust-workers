#cloud-config
package_update: true
package_upgrade: false
packages:
  - python3-virtualenv
  - unzip
write_files:
  - path: /etc/systemd/system/locust.service
    content: |
      [Unit]
      Description=Locust Load Testing Service
      After=network.target

      [Service]
      ExecStart=/locust/venv/bin/locust -f - --worker --master-host ${master}
      WorkingDirectory=/locust
      User=root
      Group=root
      Restart=always
      RestartSec=5
      Environment="PATH=/locust/venv/bin:/usr/bin:/bin"

      [Install]
      WantedBy=multi-user.target
    owner: root:root
    permissions: '0644'
runcmd:
  - mkdir -p /locust
  - cd /locust
  - virtualenv venv
  - bash -c "source ./venv/bin/activate && pip install locust locust_plugins"
  - systemctl daemon-reload
  - systemctl enable locust
  - systemctl start locust
final_message: "The locust worker system is up, after $UPTIME seconds"