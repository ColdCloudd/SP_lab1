#!/bin/bash

# Function to set permissions
set_permissions() {
    # Ask for the path to the first file
    read -p "Enter the path to the first file: " file1 2> /dev/tty

    # Check if the specified file exists
    while [ ! -e "$file1" ]; do
        echo "Error: File '$file1' does not exist." >&2
        read -p "Please enter a valid path to the first file: " file1 2> /dev/tty
    done

    # Ask for the path to the second file
    read -p "Enter the path to the second file: " file2 2> /dev/tty

    # Check if the specified file exists
    while [ ! -e "$file2" ]; do
        echo "Error: File '$file2' does not exist." >&2
        read -p "Please enter a valid path to the second file: " file2 2> /dev/tty
    done

    
    # Get permissions from the first file
    permissions1=$(stat -c %a "$file1")
    permissions2=$(stat -c %a "$file2")
    echo "First file permissions: '$permissions1'"
    echo "Second file permissions: '$permissions2'"
    # Set permissions for the second file
    chmod "$permissions1" "$file2"

    echo "Permissions for the file '$file2' have been set based on the '$file1' file."
    permissions1=$(stat -c %a "$file1")
    permissions2=$(stat -c %a "$file2")
    echo "First file permissions: '$permissions1'"
    echo "Second file permissions: '$permissions2'"

    return 0
}

# Output information about the program
echo "Author: Kurkov Daniil"
echo "Program Name: Set File Permissions"
echo "Description: The script prompts for paths to two files and sets permissions for the second file based on the first."

# Infinite loop
while true; do
    set_permissions

    # Check the return code of the function
    if [ $? -eq 0 ]; then
        # Ask the user whether to perform the operation again or exit the loop
        read -p "Do you want to perform the operation again? (yes/no): " choice 2> /dev/tty

        case "$choice" in
            [Nn]*)
                echo "Exiting the program."
                exit 0
                ;;
            *)
                # Continue the loop
                continue
                ;;
        esac
    else
        # In case of an error, exit the loop with a return code
        exit 1
    fi
done
