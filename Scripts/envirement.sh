
DIR="/var/www/dataverse"

echo $1

echo "################ SCRIPT version 1.0.1 ################"
echo "Create Envirement"

if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Creating ${DIR}..."
fi
