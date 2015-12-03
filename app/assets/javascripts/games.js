$(function(){

  $('.drop-chip').click(function(e){
    var el = $(e.target);
    var col = el.data("col");
    var url = $('#board').data("play-url");
    $.post(url, { "column": col } , function( data ) {
      if (data.status == 'ok') {
        var lastRow = data.last_move[0];
        var lastCol = data.last_move[1];
        $("[data-col=" + lastCol + "][data-row=" + lastRow + "] div").addClass(data.player);
        console.log('lastRow: ' + lastRow + ' lastCol: ' + lastCol);
      } else {
        alert(data.message);
      }
    });
  });

});