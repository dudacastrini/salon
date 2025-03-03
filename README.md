**README - Salon Appointment Scheduler**

**Project Overview**
This project is a simple **Salon Appointment Scheduler** built using **PostgreSQL** and **Bash scripting**. It allows customers to book appointments for various salon services, automatically managing customer records and scheduling appointments.

---

**Features**
- Customers can book appointments for different salon services.
- The system checks if a customer exists by phone number:
  - If the customer is new, it asks for their name and saves it.
  - If the customer exists, it retrieves their name automatically.
- Appointments are stored in a PostgreSQL database.
- The script ensures valid service selection before proceeding.
- Confirmation messages are displayed after successful booking.

---

**Database Schema**
The project consists of three tables:

1. **`customers`** - Stores customer information.
   - `customer_id` (Primary Key, Auto-incremented)
   - `name` (VARCHAR, required)
   - `phone` (VARCHAR, unique & required)

2. **`services`** - Stores available salon services.
   - `service_id` (Primary Key, Auto-incremented)
   - `name` (VARCHAR, required)

3. **`appointments`** - Stores booked appointments.
   - `appointment_id` (Primary Key, Auto-incremented)
   - `customer_id` (Foreign Key, references `customers.customer_id`)
   - `service_id` (Foreign Key, references `services.service_id`)
   - `time` (VARCHAR, required)

---

**Setup Instructions**
**1. Install PostgreSQL (if not already installed)**
Ensure you have PostgreSQL installed and running.

**2. Run the SQL script to set up the database**
Execute the following command to create the database and tables:
```sh
psql -U postgres -f salon.sql
```

**3. Give execution permission to the script**
```sh
chmod +x salon.sh
```

**4. Run the appointment scheduler**
```sh
./salon.sh
```

---

**How to Use**
1. The script will display a list of services.
2. Enter the **service number** to book an appointment.
3. Enter your **phone number**:
   - If new, enter your **name**.
   - If existing, your name will be retrieved automatically.
4. Enter the **appointment time**.
5. Receive confirmation of your booking.

---

**Example Usage**
**New Customer Booking**
```
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?

1) cut
2) color
3) perm
4) style
5) trim
1

What's your phone number?
555-555-5555

I don't have a record for that phone number, what's your name?
Fabio

What time would you like your cut, Fabio?
10:30

I have put you down for a cut at 10:30, Fabio.
```

**Existing Customer Booking**
```
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?

1) cut
2) color
3) perm
4) style
5) trim
2

What's your phone number?
555-555-5555

What time would you like your color, Fabio?
11am

I have put you down for a color at 11am, Fabio.
```

---

**Notes**
- If an invalid service number is entered, the list will be displayed again.
- The system ensures that phone numbers are unique for customers.
- The script automatically stops running after completing a booking.

---

**Author**
This project was created as part of a Relational Database FreeCodeCamp course.
