# jasperserver-ce-docker
JasperServer docker 6.4.2

## Compilacion de Docker
```bash
# docker build -t jasperserver_ce .
```

## Ejecucion de contenedor
```bash
#  docker run -p 8084:8081 --add-host="${host}:127.0.0.1" -e "DATABASE_TYPE=${postgres|mysql}" \              
-e "DATABASE_HOST=${localhost}" -e "DATABASE_USER=${postgres}" \
-e "DATABASE_PASS=${postgres}" --network host --name jasper -d jasperserver:latest
```
