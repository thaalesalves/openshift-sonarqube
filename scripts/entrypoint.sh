#!/bin/bash

echo "sonar.jdbc.username=$SONAR_JDBC_USERNAME" >> /opt/sonarqube/conf/sonar.properties
echo "sonar.jdbc.password=$SONAR_JDBC_PASSWORD" >> /opt/sonarqube/conf/sonar.properties
echo "sonar.jdbc.url=$SONAR_JDBC_URL" >> /opt/sonarqube/conf/sonar.properties
echo "sonar.path.data=$SONAR_ELASTISEARCH_DIR" >> /opt/sonarqube/conf/sonar.properties
echo "sonar.path.temp=$SONAR_TEMP_DIR" >> /opt/sonarqube/conf/sonar.properties

sonar.sh start
echo -e "==========================================================="
echo -e "SonarQube $SONARQUBE_VERSION is starting!"
echo -e "You may log in to SonarQube once it starts booting up"
echo -e "Login: admin"
echo -e "Password: admin"
echo -e "==========================================================="

tail -f /opt/sonarqube/logs/sonar*