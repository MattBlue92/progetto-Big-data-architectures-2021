# Modelli di anomaly detection sulla base del comportamento di container
Supponiamo di avere a disposizione su un server diverse macchine virtuali che
eseguono applicazioni all’interno di container Docker. Risulta fondamentale avere un
sistema di monitoraggio che rilevi la quantità di risorse (CPU, Memoria RAM, Disco,
Rete ed Errori) al fine di rilevare utilizzi eccessivi di risorse e possibili malfunzionamenti
delle applicazioni in esecuzione. L’architettura per la gestione, il monitoraggio e
la rilevazione di anomalie nel consumo di risorse da parte delle applicazioni da noi
studiata si compone di diverse componenti:
* Apache Mesos, gestore di risorse per cluster di VM;
* Apache Marathon, servizio di orchestrazione di container Mesos/Docker;
* Zabbix, servizio di monitoraggio;
* Kibana, strumento di visualizzazione dei dati per la creazione di dashboard accattivanti. 
Queste componenti sono interconnesse fra di loro e realizzano un flusso di dati
che consente di monitorare il consumo di risorse da parte delle diverse applicazioni
attraverso le dashboard di Kibana.
Abbiamo sviluppato questo progetto per il corso di Big Data Architectures e per la piattaforma Snap4city del DISIT-LAB 
dell'università degli studi di Firenze (la dashboard finale è solo su snap4city)


## Istruzioni per l'esecuzione
Da terminale nella cartella del progetto eseguire le seguenti istruzioni in questo ordine
```
docker-compose -f docker-compose-zabbix-kibana-logstash.yml up
docker-compose -f docker-compose-mesos.yml up
```

Per arrestare i servizi  e pulire l'environment eseguire queste istruzioni:
```
docker-compose -f docker-compose-zabbix-kibana-logstash.yml down
docker-compose -f docker-compose-mesos.yml down
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker volume prune
```

I servizi sono disponbili da browser ai seguenti indirizzi:
* Zabbix: http://172.16.121.1/ User: Admin Password: carryontech
* Kibana: http://0.0.0.0:5601/ 
* Marathon: http://0.0.0.0:8080/
* Mesos-master: http://0.0.0.0:5050
* Mesos-slave: http://0.0.0.0:5051
* Mysql: IP: 172.16.121.6, Porta: 3306, User: zabbix Password: carryontech


![dashboard](https://github.com/MattBlue92/progetto-Big-data-architectures-2021/tree/main/img/dashboard_snap4city.png)

`
