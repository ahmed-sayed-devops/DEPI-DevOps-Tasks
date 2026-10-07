#!/bin/bash

EMPLOYEE_FILE="employees.txt"

# Create file

touch "$EMPLOYEE_FILE"

add_employee() {
    read -p "Enter employee name: " name



     ##############################
     #Check if name is empty
     #############################

    if [ -z "$name" ]; then
        echo "Employee name cannot be empty."
        return
    fi

    ###################################
    # Check if employee already exists
    # ################################

    if grep -Fxq "$name" "$EMPLOYEE_FILE"; then
        echo "Employee already exists."
    else
        echo "$name" >> "$EMPLOYEE_FILE"
        echo "Employee added successfully."
    fi
}

search_employee() {
    read -p "Enter employee name: " name



    ######################################
    # Check if name is empty
    # ###################################

    if [ -z "$name" ]; then
        echo "Employee name cannot be empty."
        return
    fi

    found=0


    while read -r employee; do
        if [ "$employee" = "$name" ]; then
            found=1
            break
        fi
    done < "$EMPLOYEE_FILE"

    if [ $found -eq 1 ]; then
        echo "Employee found."
    else
        echo "Employee not found."
    fi
}

list_employees() {
    if [ ! -s "$EMPLOYEE_FILE" ]; then
        echo "No employees found."
        return
    fi

    echo "Employees:"
    count=1

    while read -r employee; do
        echo "$count. $employee"
        ((count++))
    done < "$EMPLOYEE_FILE"
}

while true
do
    echo
    echo "===== Employee Management ====="
    echo "1. Add Employee"
    echo "2. Search Employee"
    echo "3. List Employees"
    echo "4. Exit"
    echo

    read -p "Choose an option: " choice

    case $choice in
        1)
            add_employee
            ;;
        2)
            search_employee
            ;;
        3)
            list_employees
            ;;
        4)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
