Improvement

-	Add loader to TorrentsPage
-	Remove number of torrents, replace with disk free space
-	Try to separate Authentication from TorrentsPage
-	Use tag in polling rate picker to avoid using strings

TODO

-	Show ServerPage from SettingsPage
-	Implement server add
-	Remove ObservedObject from torrentsPageViewModel
-	In SettingsPage avoid retrieving servers from file, get the current from user defaults instead
-	Crypt password before saving it in userDefaults
-	Settings with multiple servers
	-	Server name
	-	protocol (http/https)
	-	IP
	-	port
	-	Authentication (not mandatory)
-	Parametric baseURL
-	Parametric polling rate

FIX
