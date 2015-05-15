yum install httpd httpd-devel php wget -y
yum groupinstall 'Development Tools' -y

service httpd start

#Copy conf files
cp suphp.conf /etc
cp suphp.conf.1 /etc/httpd/conf.d/suphp.conf

cp index.php /var/www/html
chown apache:apache index.php
chmod 755 index.php

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

service httpd restart
