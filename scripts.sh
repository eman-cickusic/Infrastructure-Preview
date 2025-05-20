#!/bin/bash
# Jenkins Administration Script
# This script provides easy management of the Bitnami Jenkins installation

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Try using sudo."
    exit 1
fi

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Display header
echo -e "${YELLOW}====================================${NC}"
echo -e "${YELLOW}   Bitnami Jenkins Admin Script     ${NC}"
echo -e "${YELLOW}====================================${NC}"

# Function to display usage information
function display_usage {
    echo -e "\nUsage: $0 [option]"
    echo -e "\nOptions:"
    echo -e "  status      - Check status of all services"
    echo -e "  start       - Start all services"
    echo -e "  stop        - Stop all services"
    echo -e "  restart     - Restart all services"
    echo -e "  jenkins     - Manage only Jenkins service (requires a second parameter: status|start|stop|restart)"
    echo -e "  info        - Display server information"
    echo -e "  help        - Display this help message"
    echo -e "\nExamples:"
    echo -e "  $0 status"
    echo -e "  $0 jenkins restart"
}

# Function to manage services
function manage_services {
    case "$1" in
        status)
            echo -e "\n${YELLOW}Checking status of all services...${NC}"
            /opt/bitnami/ctlscript.sh status
            ;;
        start)
            echo -e "\n${YELLOW}Starting all services...${NC}"
            /opt/bitnami/ctlscript.sh start
            ;;
        stop)
            echo -e "\n${YELLOW}Stopping all services...${NC}"
            /opt/bitnami/ctlscript.sh stop
            ;;
        restart)
            echo -e "\n${YELLOW}Restarting all services...${NC}"
            /opt/bitnami/ctlscript.sh restart
            ;;
        jenkins)
            if [ -z "$2" ]; then
                echo -e "${RED}Error: Missing parameter for jenkins command.${NC}"
                display_usage
                exit 1
            fi
            
            case "$2" in
                status)
                    echo -e "\n${YELLOW}Checking status of Jenkins service...${NC}"
                    /opt/bitnami/ctlscript.sh status jenkins
                    ;;
                start)
                    echo -e "\n${YELLOW}Starting Jenkins service...${NC}"
                    /opt/bitnami/ctlscript.sh start jenkins
                    ;;
                stop)
                    echo -e "\n${YELLOW}Stopping Jenkins service...${NC}"
                    /opt/bitnami/ctlscript.sh stop jenkins
                    ;;
                restart)
                    echo -e "\n${YELLOW}Restarting Jenkins service...${NC}"
                    /opt/bitnami/ctlscript.sh restart jenkins
                    ;;
                *)
                    echo -e "${RED}Error: Invalid parameter for jenkins command.${NC}"
                    display_usage
                    exit 1
                    ;;
            esac
            ;;
        info)
            echo -e "\n${YELLOW}Server Information:${NC}"
            echo -e "\n${GREEN}System:${NC}"
            uname -a
            echo -e "\n${GREEN}Memory Usage:${NC}"
            free -h
            echo -e "\n${GREEN}Disk Usage:${NC}"
            df -h
            echo -e "\n${GREEN}Jenkins Process:${NC}"
            ps aux | grep jenkins
            echo -e "\n${GREEN}Jenkins Version:${NC}"
            if [ -f "/opt/bitnami/jenkins/jenkins-war/WEB-INF/lib/jenkins-core.jar" ]; then
                java -jar /opt/bitnami/jenkins/jenkins-war/WEB-INF/lib/jenkins-core.jar --version
            else
                echo "Could not determine Jenkins version"
            fi
            ;;
        help)
            display_usage
            ;;
        *)
            echo -e "${RED}Error: Invalid option.${NC}"
            display_usage
            exit 1
            ;;
    esac
}

# Check if at least one argument was provided
if [ $# -lt 1 ]; then
    echo -e "${RED}Error: Missing parameter.${NC}"
    display_usage
    exit 1
fi

# Process command
manage_services "$1" "$2"

echo -e "\n${GREEN}Operation completed.${NC}"
