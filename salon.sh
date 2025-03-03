#!/bin/bash

# Connect to PostgreSQL database
PSQL="psql --username=postgres --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~"
echo -e "\nWelcome to My Salon, how can I help you?\n"

# Function to display services
DISPLAY_SERVICES() {
  SERVICES=$($PSQL "SELECT service_id, name FROM services;")
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME; do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
}

# Function to get service selection
GET_SERVICE() {
  DISPLAY_SERVICES
  read SERVICE_ID_SELECTED
  
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
  if [[ -z $SERVICE_NAME ]]; then
    echo -e "\nI could not find that service. What would you like today?"
    GET_SERVICE
  fi
}

# Prompt for service selection
GET_SERVICE

# Prompt for phone number
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

# Check if customer exists
CUSTOMER_INFO=$($PSQL "SELECT customer_id, name FROM customers WHERE phone = '$CUSTOMER_PHONE';")

if [[ -z $CUSTOMER_INFO ]]; then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
else
  CUSTOMER_ID=$(echo $CUSTOMER_INFO | awk '{print $1}')
  CUSTOMER_NAME=$(echo $CUSTOMER_INFO | awk '{print $2}')
fi

# Get appointment time
echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | xargs), $CUSTOMER_NAME?"
read SERVICE_TIME

# Insert appointment
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")

# Confirmation message
echo -e "\nI have put you down for a $(echo $SERVICE_NAME | xargs) at $SERVICE_TIME, $CUSTOMER_NAME."
