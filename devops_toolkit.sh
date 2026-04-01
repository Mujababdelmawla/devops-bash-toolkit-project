#!/bin/bash

# ============================================
# Define the variables and the array 
# ============================================

file_name="./health_report.txt"
timestamp=$(date)

tools=("git" "python3" "curl" "wget")
saved_in="./projects"
backup_location="./project_packups"

log_file="./app.log"





# ============================================
# functions defined here
# ============================================

# Part 1
check_health() {
    touch $file_name 
    cpu_usage=$(top -bn1 | grep "Cpu") # batch mode (-b) n1 means run only one time

mem_usage=$(free -h | grep "Mem" | awk '{print$3}')

disk_space=$(df -h | grep "/dev")

echo "the report generated at : $timestamp" >> $file_name
echo "the cpu usage is : $cpu_usage" >> $file_name

echo "the memory usage is : $mem_usage" >> $file_name

echo "the disk space is : $disk_space" >> $file_name

echo "the health report generated successfuly."

 }

# Part 2
install_tool() {
    local tool=$1

        echo "$tool is not installed ...installing $tool"
        # using conditionals to check the os 
        if [[ "$(uname)" == "Darwin" ]];
        then
              # install the $tool in the macos
                brew install $tool

        elif [[ "$(uname)" == "Linux" ]];
        then
                sudo apt update
                sudo apt install -y $tool

        else
                echo "the os is not supported please check your os "
        fi

        if command -v $tool &> /dev/null;
        then
                echo "$tool has been successfully installed"
        else
                echo "failed to install $tool."
        fi
 }

# Part 3
pull_clone() {
        repo_url=$1
        saved_in=$2


        # extracting the name from .git
        repo_name=$(basename $repo_url .git)

        # check if the repository exsts or not

        if [ -d "$saved_in/$repo_name" ];
        then
                echo "the $repo_name is already exists"
                cd "$saved_in/$repo_name" && git pull
        else

                echo "$repo_name doesn't exists... cloning "
                mkdir -p $saved_in
                git clone "$repo_url" "$saved_in/$repo_name"

                 

        fi
 }
create_backup() {
    repo_path=$1
backup_location=$2
timestamp=$(date +%Y%m%d%H%M%S)
backup_name=$(basename $repo_path)
mkdir -p $backup_location
tar -czf "$backup_location/$backup_name-$timestamp.tar.gz" -C "$(dirname $repo_path)" "$(basename $repo_path)"
 
echo "backup created successfully"
 }

# Part 4
analyze_logs() {

     touch $log_file
    cat > $log_file << EOF
2024-01-01 08:00:00 INFO application started successfully
2024-01-01 08:05:00 ERROR database connection failed
2024-01-01 08:10:00 WARNING memory usage is high
2024-01-01 08:15:00 INFO backup process started
2024-01-01 08:20:00 ERROR disk space running low
2024-01-01 08:25:00 WARNING cpu usage is above 80%
2024-01-01 08:30:00 INFO health check passed
2024-01-01 08:35:00 ERROR memory usage critical
2024-01-01 08:40:00 WARNING disk space below 20%
2024-01-01 08:45:00 INFO application shutdown successfully
EOF

grep "ERROR" $log_file >> errors.txt

awk '{print $1, $2, $3}' $log_file

sed 's/ERROR/CRITICAL/g' $log_file >> updated.log1
 }

# Part 5
generate_report() {
    local  report_file="./final_report.txt"
        touch $report_file

        echo "=============================================" >> $report_file
        echo "report generated at : $(date +%Y%m%d%H%M%S)" >> $report_file
        echo "Backup Location : ./project_backups" >> $report_file
        echo "==============================================" >> $report_file

        error_count=$(wc -l < ./errors.txt)
        echo "Number Of Errors Found : $error_count" >> $report_file
        echo "Tools Status :" >> $report_file


        for tool in ${tools[@]}
        do
                if command -v $tool &> /dev/null;
                then
                        echo "$tool is already installed" >> $report_file
                else
                        echo "$tool is not installed" >> $report_file
                fi
        done
}

# ============================================
# Main program 
# ============================================

# calling the function to execute part1

check_health

# using loop to itrate thorugh the tools 

for tool in ${tools[@]}
do
    if command -v $tool &> /dev/null;
    then
        echo "$tool is already installed."
    else
        install_tool $tool
    fi
done

echo "Enter the repository url : "
read repo_url
pull_clone "$repo_url" "$saved_in"
create_backup "$saved_in/$(basename $repo_url .git)" "$backup_location"
echo "backup process completed..."

analyze_logs
generate_report

echo "DevOps Toolkit Completed Successfully!"