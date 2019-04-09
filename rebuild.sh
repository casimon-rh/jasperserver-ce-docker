sudo docker build -t jasperserver . && (
  sudo docker rm -f jasper;
  sudo docker run --name jasper -e "DATABASE_TYPE=postgres" -e "KEEP_DATA=1" \
    -e "DATABASE_HOST=192.168.1.1" -e "DATABASE_USER=postgres" -e "DATABASE_PASS=postgres" \
    --network casanova -d jasperserver;
);
