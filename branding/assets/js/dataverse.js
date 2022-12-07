
/************************************************************* Total - Script */
url_metrics = '/api/info/metrics/';
function getvals(url, div, expr, param) {
    fetch(url)
        .then((response) => { return response.json(); })
        .then((myJson) => {
            switch (expr) {
                case 'Total':
                    document.getElementById(div).innerHTML = myJson.data.count;
                    break;
            }
        });
}

// Para chamar as metricas coloque esses comandos na custom-homepage.html
/* Script para chamar as metricas */
/*
<script>
getvals(url_metrics + 'dataverses', 'ID_dataverse', 'Total');
getvals(url_metrics + 'datasets', 'ID_grupos', 'Total');
getvals(url_metrics + 'files', 'div3', 'Total');
getvals(url_metrics + 'downloads', 'div4', 'Total');
</script>
*/


function querySubjectDataset(elm) {
  var dvArray = [];
  var fullArray = [];
  // $.get(url_metrics + "dataverses/bySubject", function (jData) {
  //     jData.data.forEach(function (item) {
  //         if (item.subject !== "N/A" && item.subject !== "Other") {
  //             dvArray.push([item.subject, item.count]);
  //         }
  //     });

  // });

  $.get(
    url_metrics + "datasets/bySubject?dataLocation=all",
    function (jData) {
      var resultHtml = "";
      jData.data.forEach(function (item) {
        if (item.subject !== "N/A" && item.subject !== "Other") {
          var dvCount = 0;
          for (var dvi = 0; dvi < dvArray.length; dvi++) {
            if (item.subject === dvArray[dvi][0]) {
              dvCount = dvArray[dvi][1];
              break;
            }
          }
          fullArray.push([
            item.subject,
            (item.count + dvCount).toLocaleString("en"),
          ]); //subtract 1 to remove root dv from counts
        }
      });
      fullArray.sort();
      fullArray.forEach(function (subject) {
        // NOTE: The alias of the root dataverse will need to be configured in this URL
        // resultHtml += "<p class=\"browse-subjects\"><a href=\"/dataverse/ur?q=&fq0=subject_ss%3A%22" + subject[0] + "%22&types=dataverses%3Adatasets&sort=dateSort&order=desc\">" + subject[0] + "</a> <span class=\"text-muted\">" + subject[1] + "</span></p>";
        resultHtml +=
          '<a class="browse-subjects" href="/dataverse/ur?q=&fq0=subject_ss%3A%22' +
          subject[0] +
          '%22&types=datasets&sort=dateSort&order=desc"><span>' +
          subject[0] +
          " " +
          subject[1] +
          "</span></a>";
        // console.log(subject[0]+" - "+subject[1]);
      });
      document.getElementById(elm).innerHTML = resultHtml;
    }
  );
}
