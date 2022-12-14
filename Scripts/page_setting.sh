echo "****** Settings **********"
echo "v0.22.12.14"
echo " "
echo "Modulo $1"
echo "Action $2"

if [ "$1" = "homepage" ]; then
    if [ "$2" = "delete" ]; then
        echo "Removendo Homepage Custimzada"
        curl -X DELETE http://localhost:8080/api/admin/settings/:HomePageCustomizationFile
    else
        echo "Definindo Custom Page"
        curl -X PUT -d '/var/www/dataverse/branding/custom-homepage.html' http://localhost:8080/api/admin/settings/:HomePageCustomizationFile
    fi
else
    echo "Modulo não encontrado"
    echo "use: page_setting homepage delete"
    echo "use: page_setting homepage install"
fi
