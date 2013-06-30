
var order;
var card_counter = 0;
var user_id;


function beginRound() {
  $.ajax({
      url: "/rounds/card_order",
      method: "GET"
    }).done(function(response){
      order = $.parseJSON(response); //set order to shuffled array of indices [5, 1, 3, ...]
    }).done(
      questionRequest
    );
};

function questionRequest(){
  if (card_counter == order.length) {
    window.location.href = '/decks'
  }
  else {
    $.ajax({
        url: "/rounds/get_question",
        method: "GET",
        data: "card_id=" + order[card_counter]
      }).done(function(response){
        $('.question').html(response).fadeIn();
      });
    }
  }

$(document).ready(function() {

  $('.question').on('submit','form',function(e){
    e.preventDefault();
    $('.question').fadeOut();
    $.ajax({
      url: "/rounds/submit_guess",
      method: "POST",
      data: $(this).serialize()
    }).done(function(response){
      $('.question').html(response).fadeIn();
      card_counter++;
      setTimeout(function () {
        $('.question').toggle();
        questionRequest();
      }, 1500);

    });
  });
});



