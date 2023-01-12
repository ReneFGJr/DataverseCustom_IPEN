clear
echo "ACESSANDO A PASTA DE CONFIGURACOES"
if [ -d "/usr/local/solr/solr-8.11.1/server/solr/collection1/conf" ]; then
    echo "Pasta de configuracoes SOLR encontrada"
else
    echo "ERRO - Pasta de configuracoes SOLR nao encontrada"
    exit
fi

echo "ACESSANDO A PASTA DE CONFIGURACOES"
if [ -d "/home/dataverse/dataverse-api" ]; then
    echo "Pasta de configuracoes encontrada"
else
    echo "Criando pasta de configuracoes"
    mkdir /home/dataverse/dataverse-api/
fi
cp ipen.tsv /home/dataverse/dataverse-api/
cp ../Scripts/update-fields.sh /home/dataverse/dataverse-api/.
cd /home/dataverse/dataverse-api/

echo "Checando /home/dataverse/dataverse-api/update-fields.sh"
echo "ENVIANDO METADADOS PARA O SISTEMA"

echo "CARREGANDO A ATUALIZACAO DO SCHEMA"
curl http://localhost:8080/api/admin/datasetfield/load -X POST --data-binary @ipen.tsv -H "Content-type: text/tab-separated-values"

echo "CARREGANDO SCHEMA"
rm schema.xml -r
curl "http://localhost:8080/api/admin/index/solr/schema" > schema.xml

echo "ATUALIZANDO O SCHEMA"
cat schema.xml | ../Scripts/update-fields.sh /usr/local/solr/solr-8.11.1/server/solr/collection1/conf/schema.xml

cd ../.tmp/schema/
echo "Atualizando o SOLR"
curl "http://localhost:8983/solr/admin/cores?action=RELOAD&core=collection1"
echo "End"
