$(function(){

  $('.drop-chip').click(function(e){
    var el = $(e.currentTarget);
    var col = el.data("col");
    var url = $('#board').data("play-url");
    console.log('column: ' + col);
    $.post(url, { "column": col } , function( data ) {
      if (data.status == 'ok') {
        if (data.game.winner_id) {
          alert('you are the winner! :)');
        } else {
          var lastRow = data.last_move[0];
          var lastCol = data.last_move[1];
          $("[data-col=" + lastCol + "][data-row=" + lastRow + "] div").addClass(data.player);
          console.log('lastRow: ' + lastRow + ' lastCol: ' + lastCol);
        }
      } else {
        alert(data.message);
      }
    });
  });

});