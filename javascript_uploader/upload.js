function urlParam(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results==null){
       return null;
    }
    else{
       return results[1] || 0;
    }
}

//$('#upload_button').click(function() {
function upload() {
    alert('button clicked');
    var params = [urlParam('transaction_id'), urlParam('party'), $('#document_type').val()];
    var serverUrl = 'https://api.parse.com/1/files/' + params.join('_') + '.pdf';

    $.ajax({
        type: "POST",
        beforeSend: function(request) {
            request.setRequestHeader("X-Parse-Application-Id", 'h8IkXf9ZVxSb1XYhFeaMbFsNbbSsQKRYnHSDAx98');
            request.setRequestHeader("X-Parse-REST-API-Key", '23dDwtnn6xxxh0gHpCFImNcYTjoshPoTKGEvqIV4');
            request.setRequestHeader("Content-Type", 'application/pdf'); //Guess from file name?
            alert('beforeSend');
        },
        url: serverUrl,
        data: document.getElementById('document_file').files[0],
        processData: false,
        contentType: false,
        success: function(data) {
            alert("File available at: " + data.url);
        },
        error: function(data) {
            alert('Upload failed');
        }
    });
//});
}
