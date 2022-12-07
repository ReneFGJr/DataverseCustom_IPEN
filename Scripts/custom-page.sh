clear
DIR="/var/www/dataverse"
DIRB="/var/www/dataverse/branding"

echo "## UPDATE LAYTOUTS ##"
cp branding/* ${DIRB} -R
ls /var/www/dataverse/branding/ -ls
#read -p "Press enter to continue"