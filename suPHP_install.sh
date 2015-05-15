yum install httpd httpd-devel php wget -y
yum groupinstall 'Development Tools' -y
cd /tmp
wget http://www.suphp.org/download/suphp-0.7.2.tar.gz
tar -zxvf suphp-0.7.2.tar.gz
cd suphp-0.7.2
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
./configure --prefix=/usr --sysconfdir=/etc --with-apr=/usr/bin/apr-1-config --with-apxs=/usr/sbin/apxs --with-apache-user=apache --with-setid-mode=paranoid --with-logfile=/var/log/httpd/suphp_log
make && make install
touch /var/log/httpd/suphp_log

#turn off php5 module
sed -i 's/LoadModule php5_module modules\/libphp5.so/#LoadModule php5_module modules\/libphp5.so/g'  /etc/httpd/conf.d/php.conf

#create suphp.conf
touch /etc/httpd/conf.d/suphp.conf

echo "LoadModule suphp_module modules/mod_suphp.so" >> /etc/httpd/conf.d/suphp.conf
echo "AddHandler x-httpd-php .php .php3 .php4 .php5 .phtml" >> /etc/httpd/conf.d/suphp.conf
echo "suPHP_AddHandler x-httpd-php" >> /etc/httpd/conf.d/suphp.conf
echo "suPHP_Engine on" >> /etc/httpd/conf.d/suphp.conf
echo "suPHP_ConfigPath /etc/" >> /etc/httpd/conf.d/suphp.conf

#Create /etc/suphp.conf
touch /etc/suphp.conf

echo "[global]" >> /etc/suphp.conf
echo ";Path to logfile" >> /etc/suphp.conf
echo "logfile=/var/log/httpd/suphp_log" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";Loglevel" >> /etc/suphp.conf
echo "loglevel=info" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";User Apache is running as" >> /etc/suphp.conf
echo "webserver_user=apache" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";Path all scripts have to be in" >> /etc/suphp.conf
echo "docroot=/var/www" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";Path to chroot() to before executing script" >> /etc/suphp.conf
echo ";chroot=/mychroot" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo "; Security options" >> /etc/suphp.conf
echo "allow_file_group_writeable=false" >> /etc/suphp.conf
echo "allow_file_others_writeable=false" >> /etc/suphp.conf
echo "allow_directory_group_writeable=false" >> /etc/suphp.conf
echo "allow_directory_others_writeable=false" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";Check wheter script is within DOCUMENT_ROOT" >> /etc/suphp.conf
echo "check_vhost_docroot=true" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";Send minor error messages to browser" >> /etc/suphp.conf
echo "errors_to_browser=true" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";PATH environment variable" >> /etc/suphp.conf
echo "env_path=/bin:/usr/bin" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";Umask to set, specify in octal notation" >> /etc/suphp.conf
echo "umask=0073" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo "; Minimum UID" >> /etc/suphp.conf
echo "min_uid=200" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo "; Minimum GID" >> /etc/suphp.conf
echo "min_gid=200" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo "[handlers]" >> /etc/suphp.conf
echo ";Handler for php-scripts" >> /etc/suphp.conf
echo "x-httpd-php=\"php:/usr/bin/php-cgi\"" >> /etc/suphp.conf
echo "" >> /etc/suphp.conf
echo ";Handler for CGI-scripts" >> /etc/suphp.conf
echo "x-suphp-cgi=\"execute:\!self\"" >> /etc/suphp.conf

service httpd restart
