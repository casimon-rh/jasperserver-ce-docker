sudo docker rmi -f jasper_server;
sudo docker build -t jasper_server . && (
  sudo docker rm -f jasper;
  sudo docker run -e "DATABASE_TYPE=postgres" -e "DATABASE_HOST=localhost" \
  -e "DATABASE_USER=postgres" -e "DATABASE_PASS=postgres" --network host \
  --add-host="csi-wunder:127.0.0.1" --name jasper --network=host -d jasper_server;
);