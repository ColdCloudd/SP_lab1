#!/bin/bash

set_permissions() {
    read -p "Enter the path to the first file: " file1 2> /dev/tty

    while [ ! -e "$file1" ]; do
        echo "Error: File '$file1' does not exist." >&2
        read -p "Please enter a valid path to the first file: " file1 2> /dev/tty
    done

    read -p "Enter the path to the second file: " file2 2> /dev/tty

    while [ ! -e "$file2" ]; do
        echo "Error: File '$file2' does not exist." >&2
        read -p "Please enter a valid path to the second file: " file2 2> /dev/tty
    done

    permissions1=$(stat -c %a "$file1")
    permissions2=$(stat -c %a "$file2")
    echo "First file permissions: '$permissions1'"
    echo "Second file permissions: '$permissions2'"
   
    chmod "$permissions1" "$file2"

    echo "Permissions for the file '$file2' have been set based on the '$file1' file."
    permissions1=$(stat -c %a "$file1")
    permissions2=$(stat -c %a "$file2")
    echo "First file permissions: '$permissions1'"
    echo "Second file permissions: '$permissions2'"

    return 0
}

echo "Author: Kurkov Daniil"
echo "Program Name: Set File Permissions"
echo "Description: The script prompts for paths to two files and sets permissions for the second file based on the first."

while true; do
    set_permissions

    if [ $? -eq 0 ]; then
        read -p "Do you want to perform the operation again? (yes/no): " choice 2> /dev/tty

        case "$choice" in
            [Nn]*)
                echo "Exiting the program."
                exit 0
                ;;
            *)
 
                continue
                ;;
        esac
    else
        
        exit 1
    fi
done
