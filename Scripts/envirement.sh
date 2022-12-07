
DIR="/var/www/dataverse"

echo $1

echo off
echo "Create Envirement"

if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Creating ${DIR}..."
fi
