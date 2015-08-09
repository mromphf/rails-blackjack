var blackjack = (function() {
  var dealerScore = 0;
  var playerScore = 0;

  function onCancel() {
      window.history.back();
  }

  function onBet(bet) {
      $.ajax({
          url: "/bet",
          type: "post",
          dataType: 'json',
          data: { bet: bet },
          success: startGame 
      });
  };

  function startGame() {
      $.ajax({
          url: "/initialize_game",
          type: "post",
          dataType: 'json',
          success: initializeGame 
      });
  }

  function playerHit() {
      $.ajax({
          url: "/player_hit",
          type: "post",
          datatype: "json",
          success: playerCallback
      });
  }

  function dealerTriesToWin() {
      $.ajax ({
        url: "/dealer_tries_to_win",
        type: "post",
        datatype: "json",
        success: dealerResults
      });
  }

  function onBust() {
      $.ajax({
          url: "/bust",
          type: "post"
      });
  }

  function onStand () {
      disableControls();
      document.getElementById("prompt").innerHTML = "You stand...";
      dealerTriesToWin();
  }

  function dealerResults(data) {
      var dealerBusted = data.bust;
      var delay = 0;
      for ( var i = 0, n = data.number_of_cards; i < n; i++ ) {
          renderDealerCard(data.images[i], delay);
          delay += 500;
      }
      setTimeout(function() {
          document.getElementById("dealerScore").innerHTML = "Dealer: " + data.score;
          if ( dealerBusted ) {
              document.getElementById("dealerScore").innerHTML = "BUST!";
          }
      }, delay);
      setTimeout(function() {renderResults(data.result)}, delay);
  }

  function renderDealerCard(image, delay) {
      setTimeout(function() {
          updatePlayerBox("dealerCards", image, "dealerScore", "Drawing...");
      }, delay);
  }

  function initializeGame(data) {
      document.getElementById("betView").style.display = "none";
      document.getElementById("gameView").style.display = "inline";
      disableControls();

      setTimeout(function () {
          updatePlayerBox("playerCards", data.player_card_one, "playerScore", "Dealing...");
      }, 500);
      setTimeout(function () {
          updatePlayerBox("dealerCards", data.dealer_card, "dealerScore", "Dealer: " + data.dealer_score);
      }, 1000);
      setTimeout(function () {
          updatePlayerBox("playerCards", data.player_card_two, "playerScore", "You: " + data.player_score);
      }, 1500);

      dealerScore = data.dealer_score
      playerScore = data.player_score
      document.getElementById("prompt").innerHTML = "Bet: $" + data.bet;
      setTimeout(function () {enableControls()}, 2000);
  }

  function playerCallback(data) {
      playerScore = data.score;
      var playerBusted = data.bust;
      updatePlayerBox("playerCards", data.image, "playerScore", "You: " + data.score);
      if ( playerBusted ) {
          onBust();
          disableControls();
          enableRefresh();
          document.getElementById("playerScore").innerHTML = "BUST!";
          document.getElementById("prompt").innerHTML = "Dealer wins...";
      }
  }

  function renderResults(result) {
      document.getElementById("prompt").innerHTML = result;
      enableRefresh();
  }

  function updatePlayerBox(cardsListId, card_string, scoreId, score) {
      var node = document.createElement("LI");
      var img = document.createElement("img");
      img.setAttribute('src', card_string);
      img.setAttribute('class', 'card');
      node.appendChild(img);
      document.getElementById(scoreId).innerHTML = score;
      document.getElementById(cardsListId).appendChild(img);
  }

  function disableControls() {
      document.getElementById("btnHit").disabled = true;
      document.getElementById("btnStand").disabled = true;
      document.getElementById("btnRefresh").disabled = true;
  }

  function enableControls() {
      document.getElementById("btnHit").disabled = false;
      document.getElementById("btnStand").disabled = false;
  }

  function enableRefresh() {
      document.getElementById("btnHit").style.display = "none";
      document.getElementById("btnStand").style.display = "none";
      document.getElementById("btnRefresh").style.display = "block";
      document.getElementById("btnRefresh").disabled = false;
  }

  function reloadPage() {
    location.reload()
  }

  return {
    onBet: onBet,
    playerHit: playerHit,
    onStand: onStand,
    reloadPage: reloadPage
  };
}());
