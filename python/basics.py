name = "Willie"        
years_of_experience = 4             
cpu_usage = 23.5      
is_healthy = True      

print(f"Name              : {name}")
print(f"Years Experience  : {years_of_experience}")
print(f"CPU Usage         : {cpu_usage}")
print(f"Is Healthy        : {is_healthy}")

# if/else statement (conditional)
if cpu_usage > 80:
    print(f"STATUS : High CPU usage")
else:
    print(f"STATUS : CPU Usage Normal")

# loop statment
servers = ["web-server-01", "web-server-02", "web-server-03"]

print(servers[0])
print(servers[2])

# Combination of conditional and loop statement
cpu_usages = [75.5, 95.0, 47.2]

for cpu in cpu_usages:
    if cpu > 80:
        print(f" High CPU: {cpu}%")
    else:
        print(f" Normal CPU: {cpu}%")

# Functions
def check_cpu(cpu):
    if cpu > 80:
        print(f"High CPU: {cpu}%")
    else:
        print(f"Normal CPU: {cpu}%")

check_cpu(75.5)
check_cpu(95.0)
check_cpu(47.2)

#Combination of loop and conditional fucntions
cpu_usages = [79.5, 97.0, 49.2]

def check_cpu(cpu):
    if cpu > 80:
        print(f"High CPU: {cpu}%")
    else:
        print(f"Normal CPU: {cpu}%")

for cpu in cpu_usages:
    check_cpu(cpu)

# File
error_count = 0
with open("./linux/sample.log", "r") as file:
    for line in file:
        if "ERROR" in line:
            error_count += 1

print(f"Total errors: {error_count}")
