# Devops Automation ToolKit #

A bash script that automates common devops tasks including system health monitoring,tool installation, repository management,log analysis, and report generation.

------

# What This Script Does :

## Part1- System Health Check 
- Check CPU usage , Memory usage , and Disk space.
- Save the results into a 'health_report.txt' file with a timestamp .

## Part2- Tool Installation 
- Check if essential Devops tools are installed : 'git','python3','curl','wget' .
- If there is any tools that is not installed , automatically it's going to install it .
- Verifies installation after each tool that if it installed successfully or not .

## Part3- Pulling-Cloning A Github Repository 
- Asks the user to enter a Github repository url .
- Clones the repository if it doesn't exists .
- Pull the latest changes if the repository already exists .
- Creates a compressed '.tar.gz' backuo immediately .

## Part4- Log Analyzer
- Creates a sample application log file .
- Extracts all errors lines inot 'errors.txt' .
- Prints dates using the command 'awk' . 
- Replace ERRORS with CRITICAL and saves as 'updates.log' .

## Part5- Final Report
- Generates a 'final_report.txt' containing :
- Date and time the script ran . 
- Backup location .
- Number of errors found .
- Status of each tool .


------


## Rquirments 
- Bash shell .
- Linux or MACos .
- 'sudo' privileges for tool installation .
- Internet connecton for cloning repositories .

------

## How To Run 
**1. clone this repository:**
'''bash
git clone https://github.com/Mujababdelmawla/devops-bash-toolkit-project
cd devops-bash-toolkit-project
'''
**2. Give the script execute permission:**
'''bash
chmod +x devops_toolkit.sh
'''
**3. Run the script:**
'''bash 
./devps_toolkit.sh
'''
**4. when executed, enter a Github repository URL:**
'''
Enter The Repository URL:
https://github.com/Mujababdelmawla/shopcart

'''

------

## Files Generated
| File | Description | 

|---|---| 

| 'health_report.txt' | system health check results |
| 'errors.txt' | extracted ERROR lines from log |
| 'updated.log' | log file with ERROR replaced by CRITICAL |
| 'final_report.txt' | complete summary report |
| 'projects/' | folder containing cloned repositories |
| 'project_backups/' | folder containing compressed backup |

------

## Concepts Used 
- Variables and arrays .
- Functions with local variables .
- Loops and conditionals .
- Command substitution .
- File handling .
- grep , awk , sed .
- tar for compressoin .
- git for repository management .

------

## Author 

MUJAB YOUSEF ADAM ELHAG : Devops Enginer In Training .