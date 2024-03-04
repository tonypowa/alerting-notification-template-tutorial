# Run Grafana, Loki, and generate logs

1. Run the container

``` docker compose up -d ```

2. Run the script

``` send-logs.sh ```

3. In your browser, goo to localhost:3000/
4. Open the side bar and navitate to Explore
5. Select Loki as data source
6. Explore the metrics `status_codes`
7. CLick Run query

8. ![image](https://github.com/tonypowa/alerting-notification-template-tutorial/assets/45235678/6d5c60a4-450b-499e-9fb2-d05eba6cf9ff)
