import re
import webbrowser  # Added for opening URLs

# Initialize lists to store NVD and RedPacket URLs
nvd_urls = []
redpacket_urls = []

print("Enter report lines (type 'gee' for gucci):")

while True:
    # Prompt the user to enter a report line
    report_line = input()

    # Check if the user wants to stop entering lines
    if report_line.lower() == 'gee':
        break

    # Define a regular expression pattern to match CVE strings
    cve_pattern = r'\b[cC][vV][eE]-\d+-\d+\b'

    # Use re.findall to find all matching CVE strings in the report line
    cve_matches = re.findall(cve_pattern, report_line)

    # Add the CVE strings found in this line to the corresponding lists
    for cve in cve_matches:
        nvd_urls.append(f"https://nvd.nist.gov/vuln/detail/{cve}")
        redpacket_urls.append(f"https://www.redpacketsecurity.com/?s={cve}")

# Print all the extracted unique CVE strings
if nvd_urls:
    print("CVE strings found in the report:")
    for i, cve in enumerate(nvd_urls, 1):
        print(f"{i}. CVE: {cve}")

    open_option = input("Do you want to open all NVD links? (yes/no): ").strip().lower()
    if open_option == 'yes':
        for url in nvd_urls:
            webbrowser.open(url)

if redpacket_urls:
    print("CVE strings found in the report:")
    for i, cve in enumerate(redpacket_urls, 1):
        print(f"{i}. CVE: {cve}")

    open_option = input("Do you want to open all RedPacket links? (yes/no): ").strip().lower()
    if open_option == 'yes':
        for url in redpacket_urls:
            webbrowser.open(url)
else:
    print("No CVE strings found in the report.")
