# FortiNAC
FortiNAC is a zero-trust access solution that oversees and protects all digital assets connected to the enterprise network, covering devices ranging from IT, IoT, OT/ICS, to IoMT. With network access control that enhances the Fortinet Security Fabric, FortiNAC delivers visibility, control, and automated response for everything that connects to the network. FortiNAC provides protection against IoT threats, extends control to third-party network devices, and orchestrates automatic response to a wide range of network events.

## Self-Registration via Captive Portal
Automated provisioning for users, guests, and devices

- Click the Link for **xpertsztna-nac**
- Log into the FortiNAC with your student AD credential
**(student\<POD_ID\>)/F0rtinet**  
<br>

- Go to **"Network / Inventory / SPOKE-1.corp.fabriclab.ca / PODS-1"**
- Sort by **Label** and see the status of your PODs', the POD number are identified in the column, "Notes"
- A Computer with an ? mean this is a "Rogues Host"
- Notice when you select a port you have detailed host information at the bottom

 ![NAC Inventory and Ports view](./images/nac_inventory_pod6.png){ width=70% }

- From the story click on the RDP icon of your assigned POD.
- Once log in your Windows POD. Open **Edge** and select the **"Fortinet"** bookmark.
- You should get intercepted by FortiNAC's Captive Portal

![NAC Captive Portal](./images/captive_portal.png){ width=70% }

- Open a **Command Prompt** and type `ipconfig`

> Validate the third octet of the IP address on the Ethernet Adapter containing the **"reg.corp.fabriclab.ca"** DNS suffix
> This subnet is mapped to the device registration vlan (VLAN 201) and there is limited access until you log into the captive portal
> reg is the short for "registration", so you are in the VLAN that forces you to register.

![NAC Registration IP](./images/vlan_registration_ipconfig.png){ width=70% }

- Select the **"Guest Self Registration"** option
- Type the information required to register
- For Sponsor type in: **sponsor@fortinet.com** and see if this will work when you submit the request for access

![NAC Guest Info](./images/nac_guest_registration_info.png){ width=70% }

- You will get the following error:

![NAC Wrong Sponsor](./images/nac_wrong_sponsor.png){ width=70% }

> This is to ensure that only approved sponsors can receive requests!

- Type in the valid sponsor: **student\<POD_ID\>@corp.fabriclab.ca** (e.g.: student07) and submit your request
- An email was sent to the Sponsor for approval, and your status should be pending.

![NAC Guest Registration Pending](./images/nac_guest_pending.png){ width=70% }

- Because your student username is a FortiNAC administrator, you can approve the request yourself with or without a greeting message.
- Open **Edge** and click on the bookmark **FortiMail - Webmail** under the folder **Servers**.
- If you get a certificate error just accept it

![NAC FortiMail Login](./images/nac_fortimail_login.png){ width=70% }

> If the FortiMail page is not loading, select the FortiMail bookmark again!

- Login with your student credentials (e.g.: **student01** and password **F0rtinet!**)
- Open the received email titled **"Guest Account Request from: Student \<POD_ID\>"**

![FortiMail Sponsor Email](./images/fortimail_sponsor_email.png){ width=70% }

- Follow the **"Login"** link to approve

![FortiMail Sponsor Approval Email](./images/fortimail_sponsor_email_detail.png){ width=70% }

- Enter password **F0rtinet!** and click **Login**

![NAC Guest Approval](./images/nac_guest_approval.png){ width=70% }

- Once approved, go back to your account registration screen and click **"Login"**

> Password and username are filled in and the greeting message if you entered one

![NAC Guest Approved Portal](./images/nac_guest_approved_portal.png){ width=70% }

> In case you see the error below, click **"OK"**
>
> ![NAC Failed to Detect a Change in Your Network Settings](./images/nac_failed_to_detect_change.png){ width=70% }

- Wait for registration to complete and for the redirection to the Fortinet web site
- Open a **Command Prompt** and validate the IP address of the Ethernet 2 adapter

> The DNS suffix is now "corp.fabriclab.ca" instead of "reg.corp.fabriclab.ca"

![Win Guest IP CMD](./images/windows_cmd_guest_ip.png){ width=70% }

- Go back to **FortiNAC-CA** and click the refresh icon if you are still in the inventory page. If not go to **"Network / Inventory / SPOKE1 / SPOKE-1.corp.fabriclab.ca / PODS-1"**
- Click on the port and examine the detailed host info, IP address should be the same as in the `ipconfig` output
- Now you should be in VLAN 103, this is the Guest VLAN

![NAC Inventory POD-2](./images/nac_inventory_pod2.png){ width=70% }

- Go to **"Users & Host / Guest & Contractor"** you should see all approved guests

![NAC Guest User List](./images/nac_user_guest_list.png){ width=70% }

- Go to **"Users & Host / Account Requests"** to list the history of all requests made on the system

![NAC Guest Requests](./images/nac_guest_requests.png){ width=70% }

- Go to **"Users & Host / Hosts"** and find you registered host by searching your POD in the search bar (e.g.: POD-2, POD-* or POD*)

![NAC Hosts Search](./images/nac_hosts_search.png){ width=70% }

- Right-click your host and explore the different options
- Choose **"Policy Detail"** to see the Network Access Policy assigned to you

![NAC Hosts Policy Details](./images/nac_hosts_policydetails_pod2.png){ width=70% }

- Go back to your **Windows POD**
- Try to connect to **Web Server** under the **Servers** bookmark folder

> Any idea why it fails yet? Don't panic you will understand soon!

![Windows Web Server Blocked](./images/windows_webserver_guest_block.png){ width=70% }

- Try to connect to the **FTP server** by selecting the **"FTP Server"** shortcut on your POD's desktop
- Enter credentials **xperts/F0rtinet!**
- Type `get guest-tag.txt`
- Confirm file has been saved to **Downloads**
- Type `bye` to end session

![Windows FTP Guest Tag](./images/windows_ftp_guest-tag.png){ width=70% }

> Congratulations, you have completed this section and got a new ZTNA tag!

___

## BYOD-AD

- On your desktop, start the **"MAC-Changer"** batch script
- Choose the **"p" (PC from Intel)** option and press enter.
You will see the generated MAC address for your Ethernet card
![](images/20_MAC_Change.png)

> The script has changed your MAC address to simulate a new PC so now in FortiNAC you should become a rogue device again!
> You will be moved back to the "Registration VLAN"
> You will not be able to browse anymore and you will be captured by the Captive Portal again
> Be patient as this could take 1 to 5 minutes

- Open **Edge**
- On the Portal choose **"FabricLab AD Account"**
- Register as BYOD with your Active Directory account (student\<POD_ID\>) and wait for the registration to complete

![NAC BYOD Portal](./images/nac_byod_portal.png){ width=70% }

- If for some reason, registration failed, refresh the web page again.  It may take a few seconds to complete.

![NAC Failed Registration](./images/nac_failed_to_detect_change.png){ width=70% }

- After successful registration, you should be redirected to Fortinet's web page
- Open a command prompt and validate `ipconfig` information

![NAC BYOD CMD IP](./images/nac_byod_cmd_ip.png){ width=70% }

- Go back to the **FortiNAC-CA**
- Go to **"Users & Hosts / Hosts"**, find your host and and right click the host to validate policy details. The current VLAN for BYOD should be VLAN 101.

![NAC BYOD Policy Details](./images/nac_hosts_byod_policydetails_pod2.png){ width=70% }    

  - Go to **"Network / Inventory / SPOKE1 / SPOKE-1.corp.fabriclab.ca / PODS-1"**
  - Filter by **"Label"** and find your port
  - Check the status icon and VLAN information.  You also have all the details at the bottom.

![NAC Inventory BYOD](./images/nac_inventory_byod_pod2.png){ width=70% }

- From the XPERTSZTNA story Landing page click on FortiGate **xpertsztna-fgt** link to connect to the FortiGate

- Go to **"Policy & Objects / Addresses"** and review Dynamic Addresses FortiNAC Tags
  - Find what Dynamic tag your POD has, use the search at the top of the screen to enter your IP if you only want to see TAGS and information related to you.

![FortiGate Dynamic Addresses](./images/fgt_address.png){ width=70% }

- Go to **"Policy & Objects / Firewall Policy"** and review FW Rules based on tag
- Review the rule named **"Web Server - Allow BYOD"**

![FortiGate Dynamic Addresses](./images/fgt_fwrules.png){ width=70% }

- From your browser, try again to reach **"Web Server"** from the **Servers** bookmark folder
- Because you now have the proper BYOD-101 tag you can reach the Web Server

![FortiGate Dynamic Addresses](./images/byod_tag.png){ width=70% }

> Don't forget to save the tag file to your Downloads folder!
> Congratulations, you have completed this section and have a new ZTNA tag!

___
## Register to EMS
When a rogue host is detected on the network, FortiNAC communicates with the MDM server to
retrieve the host data. FortiNAC registers the host found on the MDM server. FortiNAC polls the
MDM server periodically in order to update records for those hosts already registered in FortiNAC.

- In preparation for the next lab retrieve the EMS invitation code from the previously downloaded file **"byod-tag.txt"** in your **Downloads** folder
- Open FortiClient and paste the invitation code to register your EMS client then click **Connect**

![EMS Registration](./images/ems_invitation_registration.png){ width=70% }

- Enter your pod credentials (e.g.: student06) in the authentication prompt that will appear

![FortiClient AD Auth](./images/fct_ad_reg.png){ width=70% }

- Upon EMS registration your host is now managed by an MDM solution.

\

::: {.fail}
- **IMPORTANT: YOU MUST DISABLE AND RE-ENABLE YOUR ETHERNET CARD TO TRIGGER A NEW IP! USE THE "BOUNCE NIC CARD" SCRIPT ON THE DESKTOP**
:::

> **Why "Bounce" the NIC card after EMS registration?**.....This is for the POD to get a new IP address on the "Production" VLAN. NAC moved the POD VLAN via RADIUS/COA,  from BYOD to PRODUCTION VLAN when it detected the EMS/MDM Managed. Since the POD didn't see the port go down it doesn't renew its IP. This is why the "Bounce" is necessary, otherwise the POD would have to wait for DHCP lease to renew.

- FortiNAC supports many MDM integration (Intune, EMS, Nozomi, etc.)
- On the **FortiNAC**, go to **"Network / Service Connectors"**

![Services Connectors](./images/nac_sc.png){ width=70% }

- Review the Fortinet EMS information

![NAC Network Services EMS](./images/nac_network_ems.png){ width=70% }

 - Click **Create New** in the previous screen to see others supported MDMs

<br>

- On the **FortiNAC**:
- Under **"Users & Hosts"** find your host and see that it now has a green checkmark in the column **"Managed by MDM"** It is OK if you don't have green checkmark in the "MDM Compliant" column.
-- If you don't see the MDM managed column follow steps 1 and 2 below:

![NAC Managed by MDM](./images/nac_mdm_managed.png)

- FortiNAC should now have moved your host into the Production VLAN (VLAN 100).
- Go to **"Network / Inventory / SPOKE1 / SPOKE-1.corp.fabriclab.ca / PODS-1"** and filter by Label.

> What VLAN are you on now? It should be 100 for "Current VLAN"

- Review the Policy Details of your host to confirm network access policy

![NAC Inventory Port Details](./images/nac_inventory_corp_pod2.png){ width=70% }

> If your host has not yet moved you can accelerate this process with a script on your desktop.
> Click the **"Bounce NIC Card"** desktop shortcut to trigger a change of state.

> Congratulations! You have completed this section.
>
> Please [click here](https://xperts.fabriclab.ca/xperts/tags/gsfg988/) to download your new tag!
>
> <font color="red"><b>IMPORTANT!!!:</b></font> If you're following this guide from your personal laptop make sure to copy the link and open it from your pod instead for your tag to count!

___
## Corp Device
Your Windows workstation is now a corporate device since you are managed by an MDM solution

- On **FortiNAC** Go to **"Policy & Objects / Network Access"** to review the policy
- Review how each device type is given access to the network

![FortiNAC Network Access Policy](./images/nac_nw_policy.png){ width=70% }

### Security incident & Automated Response
Security Incidents enable FortiNAC to execute an action based upon notifications received from a
security device.

- In your POD's browser select the **"Eicar Testfile"** bookmark
- You get redirected to the FortiGate's block page

![Windows Chrome EICAR_TEST_FILE Block](./images/windows_eicar_block.png){ width=70% }

- On  **FortiNAC**
- Go to **"Logs / Security Incidents"**
- Review the **Events**, **Alarms**, **Rules**, **Triggers** and open the details of one event to see the attached log from the FortiGate
- You can apply "Filter" if you want to focus on an IP, MAC, etc.

![](./images/nac_filter.png){ width=60% }

![FortiNAC Security Event](./images/nac_secevent.png){ width=70% }

- Explore the **Rules**, **Trigger** and **Action** tabs to see how this was created and which actions were taken

> In this lab, we simply decided to send an email alert but it would possible to trigger many other actions such as:
   - Move the host to isolation
   - Send alert (Email, SMS)
   - Give a grace period to the user
   - And more.

![NAC Incident Actions](./images/nac_incident_actions.png){ width=70% }

- Review the alarm

![NAC Incident Alarms](./images/nac_incident_alarm.png){ width=70% }

- This was done via a security event parser, you can use this for all types of events from any security appliance on your network

![NAC Event Parser](./images/nac_eventparser.png){ width=70% }

- Go back to your **POD** and open **FortiMail**.
- To check if this event created an alert, login with your credential.
    - **Username:**    Your student account
    - **Password:**    F0rtinet!
- Check for an email like below:

![FortiMail Virus Alert](./images/fortimail_virus_alert.png){ width=70% }

- Review the email and note that it has been triggered by the FortiGate AntiVirus engine.
- Get the link for your TAG

![](images/20_virustag.png){ width=70% }

- Download the TAG

![](images/20_virustaglink.png){ width=70% }

Congratulations, you have completed this section!

___


## Compliance & Response

When FortiNAC is first deployed, after the initial discovery of infrastructure devices and endpoint devices, all endpoint devices are initially classified as rogue devices. It is important to identify corporate owned and managed devices and distinguish them from rogue devices.

The preferred method is to deploy the FortiNAC Persistent Agent on endpoint devices. Once the agent is installed, it will communicate with the FortiNAC server when it is connected to the network.

\
In the previous exercise, we have registered the Host to EMS using FortiClient. In this exercise, we will see that FortiNAC agent can be used for registration and compliance in complement of or when there is no MDM solutions, like EMS are being used.

### FortiNAC Persistent Agent

The Persistent Agent is an application that works on Windows,macOS, or Linux hosts to identify them to FortiNAC and scan them for compliance with an endpoint compliance policy. This Agent is downloaded and installed on the host permanently.

What it Does

The Persistent Agent resides on the host machine and works in conjunction with the FortiNAC Agent Server to complete tasks such as registration, authentication and scanning,
as well as provide additional information to FortiNAC about the host (adapters,
applications, etc.).

Since you are now a "Corporate" device with access to sensitive part of the network, it is critical for the organization to scan your host for compliance to corporate standard.

### FortiNAC Persistent Agent installation

You will now install The persistent agent on your POD, this agent will allow us to do compliance scan.  

- On your desktop click on the **"FortiNAC Persistent agent"** icon to install the agent.
![](images/20_agent.png){ width=30% }
- Follow the wizard and once competed click "Finish"
- On FortiNAC go to **"Users & Hosts / Hosts"** and find your POD-XX and verify that you have a checkmark in the "Persistent Agent" column like the one for POD-10 below:

![FortiNAC Host view](./images/nac_pa.png){ width=100% }

- You can right-click on your host and send a message to the agent on your POD.
- Explore different options
![](images/20_hostoptions.png){ width=70% }
- Right-click again on your host and notice you can initiate a manual **"Scan Host"**. There is no need to do another one since it was automatically done by FortiNAC when the host connected.

- Now right-click on your host again and see the inventory of all the installed applications

![FortiNAC Host applications](./images/nac_applications.png){ width=70% }


- You can see the Scan Report for all the host under Logs/Scan Result, make sure to select the time range a click "Update":

![FortiNAC Scan Result](./images/nac_scanresult.png){ width=70% }

___
## Remediation
FortiNAC reacts to network events in real-time to contain threats before they spread, utilizing a
broad and customizable set of automation policies. Leveraging AI, these policies can instantly
trigger configuration changes and remediation actions when targeted behavior or anomalies
are observed, aligning with the Zero Trust model’s dynamic and proactive approach.


- On your POD(Windows) Click on the "Windows Security" icon that is pinned to your task bar
- Disable "Real-time protection"

![Windows Defender](./images/win_defender.png){ width=50% }


- On your browser click on the "Video" bookmark and listen to the video

![](images/20_Video.png){ width=60% }
- After a moment you should see a pop-up from the FortiNAC agent that you are being moved to "Remediation"

![](images/20_agentmove.png){ width=30% }
- The Captive Portal will "Hijack" your session and explain why you are in "Remediation"

![FortiNAC Scan Failed Captive Portal](./images/nac_scanfailed.png){ width=50% }

### What happened?

FortiNAC agent is verifying every 60 seconds that you have proper protection when your turned Defender off the next scan made you non-compliant!

- On FortiNAC go to Host and check your Host and notice you have a red cross, this means you have been "MARK-AT-RISK"

![](images/20_atrisk.png){ width=50% }

- Go back to your captive portal and **click on the blue link**, " Check Defender real-time protection

![](images/20_failscan.png){ width=50% }

- Follow the directive to get out of remediation(Put back on your Real-time protection in Windows Security). Within one minutes you should see your network access revert to "Production" and you can restart the video by refreshing or opening a new tab and finish listening to this great video on ZTNA, it will be a great overview before you start the next lab.

> Congratulations! You have completed this section.
>
> Please [click here](https://xperts.fabriclab.ca/xperts/tags/enwce2s) to download your new tag!
>
> <font color="red"><b>IMPORTANT!!!:</b></font> If you're following this guide from your personal laptop make sure to copy the link and open it from your pod instead for your tag to count!

