
DIR="/var/www/dataverse"
DIRB = DIR + "/branding"

echo $1

echo "################ SCRIPT version 1.0.1 ################"
echo "Create Envirement"

if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Creating ${DIR}..."
fi

if [ -d "$DIRB" ]; then
  # Take action if $DIR exists. #
  echo "Creating ${DIRB}..."
fi

echo "## UPDATE LAYTOUTS ##"
cp branding/* /var/www/dataverse/branding/ -R
