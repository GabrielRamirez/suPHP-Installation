# suPHP-Installation
This script will install suPHP on a CentOS 6 system.
##Instructions
1. Install GIT `yum install -y git`
2. Change to temp directory `cd /tmp`
3. Clone this GIT repository `git clone https://github.com/GabrielRamirez/suPHP-Installation.git`
4. Run shell script `cd suPHP-Installation && sh ./suPHP_install.sh`
5. Use nano to edit httpd.conf `nano /etc/httpd/conf/httpd.conf`
6. Search `ctr w` for the text in httpd.conf `<Directory "/var/www/html">`
7. Add `suPHP_UserGroup apache apache` just below
8. Save httpd.conf `ctr x` then type `y` and hit enter
8. Restart the server `service httpd restart`

Installation of suPHP is complete. Open a browser window and navigate to [http://localhost/](http://localhost/) or which ever address you use to access the server.

