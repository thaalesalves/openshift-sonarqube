#!/bin/bash

sonar.sh start
echo -e "==========================================================="
echo -e "SonarQube $SONARQUBE_VERSION is starting!"
echo -e "You may log in to SonarQube once it starts booting up"
echo -e "Login: admin"
echo -e "Password: admin"
echo -e "==========================================================="
tail -f /opt/sonarqube/logs/sonar.log
