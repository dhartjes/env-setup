# Prompt

These notes may be missing from my env-setup description of configured commerce. This is from a Configured Commerce Project Setup Guide file that was shared with Lowes in 2024-2025. It may be out of date as well. Also, the latest setup meeting with configured commerce team (described in the notes repo) has another set of instructions relating to windows features that involved more items toggled on than is described here.

• Go to Turn Windows features on or off from control panel:

From Lowes Setup Doc
Tum Windows features on or off

- [-] Internet Information Services
  ○ [ ] FTP Server
  ○ [-] Web Management Tools
  ○ [-] World Wide Web Services
   § [-] Application Development Features
    □ [ ] .NET Extensibility 3.5
    □ [x] .NET Extensibility 4.8
    □ [ ] Application Initialization
    □ [ ] ASP
    □ [ ] ASP .NET 3.5
    □ [ ] ASP.NET 4.8
    □ [ ] CGI
    □ [x] ISAPI Extensions
    □ [x] ISAPI Filters
    □ [ ] Server-Side Includes
    □ [ ] WebSocket Protocol
   § [-] Common HTTP Features
    □ [x] Default Document
    □ [x] Directory Browsing
    □ [x] HTTP Errors
    □ [ ] HTTP Redirection
    □ [x] Static Content
    □ [ ] WebDAV Publishing
   § [-] Health and Diagnostics
    □ [ ] Custom Logging
    □ [x] HTTP Logging
    □ [ ] Logging Tools
    □ [ ] Request Monitoring
    □ [ ] Tracing
   § [-] Performance Features
    □ [ ] Dynamic Content Compression
    □ [x] Static Content Compression
   § [-] Security
    □ [ ] Basic Authentication
    □ [ ] IP Security
    □ [x] Request Filtering
    □ [ ] URL Authorization
- [ ] Internet Information Services Hostable Web Core
- [ ] Legacy Components
- [x] Media Features

• Check localhost:9201 or localhost:9200 to verify elastic search port. If not in 9201 you have to change the   <add key="Elasticsearch5ServerUrl" value="http://localhost:9200" /> in application’s appsettings.config file.
• Open windows hosts file to add the website by opening notepad as administrator
• In notepad click File > Open then go to C:\Windows\System32\drivers\etc folder.
• From the bottom right select all files then open hosts file.
• Add a line in the bottom 127.0.0.1 lpscommerce.local.com then save
• Import the bacpac file in database server.
• Then expand tables in that database and Select dbo.Websites table and edit top 200 rows.
• Find out the row with name main. In that row in DmainName column add lpscommerce.local.com using a comma after whatever there is.
• Goto projects \src\InsiteCommerce.Web folder open cmd there and paste in npm install
• Once npm install is done paste in grunt build
• Open visual studio as administrator. Click open project or solution and open the solution.
• Set InsiteCommerce.Web as startup. Open file /config/connectionStrings.config and set the proper connectionString. Example:   <add name="InSite.Commerce" connectionString="Server=JUARAF020;User Id=sa;Password=Optimizely@13;Initial Catalog=fox_database-backup-bacpac-fox-mqsww;MultipleActiveResultSets=true;" providerName="System.Data.SqlClient" />
• If the project is classic themed one find out the project folder inside \src\InsiteCommerce.Web\Themes\ folder. Open any typescript file from inside scripts folder. Put a space inside the ts file and save. This will trigger the scripts files build. (Skip this if Spire)
• Rebuild InsiteCommerce.Web project.
• For spire project open folder /src/frontend using visual studio code.
• Paste in the commerce link in /config/settings-base.js > apiUrl.
• In the terminal of vs code run command npm install.
• Once installed run command npm run start [BluePrintName]
• Open the link in browser and login into console lpscommerce.local.com/admin (lpscommerce.local.com:3000/admin for spire) .
• Goto Marketing > Indexing and click rebuild index.
• Once the search index is built, we are ready for development.

OH, nothing to do with schema at all. Just the text that I pasted. That schema doc seems to be stuck in all of my new chat sessions.
