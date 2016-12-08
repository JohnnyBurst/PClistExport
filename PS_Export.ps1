#Replace "L-" with your naming convention to identify which group of machines you are trying to export
#Will query each machine it can connect to for obtaining WMI sourced data which identifies the last reboot
#Feel free to rename variable $booted to one more relevant to you
#Replace username in c:\users\username to your profile name or specify another location there.

Get-ADComputer -Filter "Name -like 'L-*'" -Properties lastlogondate, description | select-object Name, DistinguishedName, LastLogonDate, Description,
    @{n='LastBootUpTime';e={
        $booted = Get-WMIObject Win32_OperatingSystem -computername $_.name
        $booted.ConvertToDateTime($booted.LastBootUpTime)
    }} | Export-Csv -nti -encoding UTF8 -path C:\users\username\Desktop\laptops.csv
