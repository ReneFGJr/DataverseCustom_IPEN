echo "ACESSANDO A PASTA DE CONFIGURACOES"
if [ -d "/home/dataverse/dataverse-api" ]; then
    echo "Pasta de configuracoes encontrada"
else
    echo "Criando pasta de configuracoes"
    mkdir /home/dataverse/dataverse-api/
fi
cd /home/dataverse/dataverse-api/

echo "Checando /home/dataverse/dataverse-api/update-fields.sh"
echo "ENVIANDO METADADOS PARA O SISTEMA"
rm *.tsv -r
wget https://lattesdata.cnpq.br/config/index.php/home/dataverse/pa/export/7
mv 7 ipen.tsv

echo "CARREGANDO A ATUALIZACAO DO SCHEMA"
curl http://localhost:8080/api/admin/datasetfield/load -X POST --data-binary @ipen.tsv -H "Content-type: text/tab-separated-values"


echo "CARREGANDO SCHEMA"
rm schema.xml -r
curl "http://localhost:8080/api/admin/index/solr/schema" > schema.xml


echo "ATUALIZANDO O SCHEMA"
cat schema.xml | ./update-fields.sh /usr/local/solr/solr-8.11.1/server/solr/collection1/conf/schema.xml
cd ../.tmp/schema/
echo "Atualizando o SOLR"
curl "http://localhost:8983/solr/admin/cores?action=RELOAD&core=collection1"
echo "End"

cd /data/LattesData