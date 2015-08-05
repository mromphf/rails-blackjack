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

  function dealerHit() {
      $.ajax({
          url: "/dealer_hit",
          type: "post",
          datatype: "json",
          success: dealerCallback
      });
  }

  function onRoundOver() {
      $.ajax({
          url: "/decide_results",
          type: "post",
          success: renderResults
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

  function dealerCallback(data) {
      dealerScore = data.score;
      var dealerBusted = data.bust;
      updatePlayerBox("dealerCards", data.image, "dealerScore", "Dealer: " + data.score);
      if ( dealerBusted ) {
          document.getElementById("dealerScore").innerHTML = "BUST!";
      }
  }

  function dealerTriesToWin() {
      if (dealerScore < playerScore && dealerScore < 17) {
          dealerHit();
          setTimeout(function () {dealerTriesToWin()}, 500);
      }
      else {
          onRoundOver();
      }
  }

  function renderResults(data) {
      document.getElementById("prompt").innerHTML = data.text;
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
