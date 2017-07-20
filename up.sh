#!/usr/bin/env bash

# Manual start test ->
# In two separate terminals run it:
#       $ java -jar selenium-server-standalone.jar start -Dwebdriver.chrome.driver=./chromedriver
#       $ vendor/bin/codecept run --steps

SELENIUM="selenium-server-standalone.jar"
PORT=4444
PROCESS="selenium-server-standalone"

if [ "$(uname)" == "Darwin" ]; then
    OS_TYPE="MAC_OS"
    DRIVER_FILE="./chromedriver"
    CODECEPT="vendor/bin/codecept"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    OS_TYPE="LINUX"
    DRIVER_FILE="./chromedriver"
    CODECEPT="vendor/bin/codecept"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    OS_TYPE="WINDOWS"
    DRIVER_FILE="./chromedriver.exe"
    CODECEPT="vendor/bin/codecept.bat"
    PROCESS="/java"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    OS_TYPE="WINDOWS"
    DRIVER_FILE="./chromedriver.exe"
    CODECEPT="vendor/bin/codecept.bat"
    PROCESS="/java"
fi

check_selenium_start () {
    while ! nc -z localhost ${PORT}; do
        sleep 0.5
    done
}

java -jar ${SELENIUM} start -Dwebdriver.chrome.driver=${DRIVER_FILE} > /dev/null & \
    (check_selenium_start && ${CODECEPT} run --steps)

pid=$(ps -ax | grep ${PROCESS} | grep -v ' grep ' | awk '{print $1}')
if [ ! -z "$pid" ]; then
    kill -9 ${pid}
fi
