# For Testcontainers Connects to Docker Inside WSL

Without installing Docker on Windows.

Reference: <https://gist.github.com/sz763/3b0a5909a03bf2c9c5a057d032bd98b7>

1. Create the file for overriding the Docker daemon service:
   
   ```shell
   sudo mkdir -p /etc/systemd/system/docker.service.d
   sudo vim /etc/systemd/system/docker.service.d/override.conf
   ```

2. Add the following content to `override.conf`:

   ```
   [Service]
   ExecStart=
   ExecStart=/usr/bin/dockerd --host=tcp://0.0.0.0:2375 --host=unix:///var/run/docker.sock
   ```

3. Reload and restart the Docker daemon:

   ```shell
   sudo systemctl daemon-reload
   sudo systemctl restart docker
   ```

4. The port `2375` should be listened by the service (`ss -tnl 'sport = :2375'`) and accessible through the Windows host (`netstat -ano`).

5. Set the following environment variables:

   ```env
   DOCKER_HOST=tcp://localhost:2375
   DOCKER_TLS_VERIFY=0
   DOCKER_CERT_PATH=\\wsl$\home\$USER_NAME\.docker
   ```

   Note that for `DOCKER_HOST`, it could be the case of `tcp://[::1]:2375` if IPv6 is enabled (check `netstat`).

6. Restart the IDE for applying the variable change, and now it should work.
