var dealerScore = 0
var playerScore = 0

$(document).ready(function () {
    disableControls();
    setTimeout(function () {playerHit()}, 500);
    setTimeout(function () {dealerHit()}, 1000);
    setTimeout(function () {playerHit()}, 1500);
    setTimeout(function () {enableControls()}, 2000);
});

function playerHit() {
    $.ajax({
        url: "/player_hit",
        type: "get",
        datatype: "json",
        success: playerCallback 
    });
}

function dealerHit() {
    $.ajax({
        url: "/dealer_hit",
        type: "get",
        datatype: "json",
        success: dealerCallback
    });
}

function onRefresh() {
    location.reload();    
}

function onStand () {
    disableControls();
    document.getElementById("foo").innerHTML = "You stand...";
    dealerTriesToWin();
}

function playerCallback(data) {
    playerScore = data.score
    updatePlayerBox("playerCards", data.text, "playerScore", data.score);
    if ( data.bust ) {
        disableControls();
        enableRefresh();
        document.getElementById("playerScore").innerHTML = "BUST!";
        document.getElementById("foo").innerHTML = "Dealer wins..."
    } 
}

function dealerCallback(data) {
    dealerScore = data.score
    updatePlayerBox("dealerCards", data.text, "dealerScore", data.score);
    if (data.bust) {
        disableControls();
        enableRefresh();
        document.getElementById("dealerScore").innerHTML = "BUST!";
        document.getElementById("foo").innerHTML = "<strong>You win!!</strong>";
    }
}

function dealerTriesToWin() {
    if (dealerScore < playerScore && dealerScore < 21) {
        dealerHit();
        setTimeout(function () {dealerTriesToWin()}, 500);
    }
    else {
        disableControls();
        if ( dealerScore > playerScore && dealerScore <= 21 ) {
            document.getElementById("foo").innerHTML = "Dealer wins..."
        }
        else if ( playerScore > dealerScore && playerScore <= 21) {
            document.getElementById("foo").innerHTML = "<strong>You win!!</strong>"
        }
        else if ( playerScore == dealerScore ) {
            document.getElementById("foo").innerHTML = "Draw..."
        }
        document.getElementById("btnRefresh").disabled = false;
    }
}

function updatePlayerBox(cardsListId, card_string, scoreId, score) {
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(card_string);
    node.appendChild(textnode);
    document.getElementById(scoreId).innerHTML = "Score: " + score;
    document.getElementById(cardsListId).appendChild(node);
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
    document.getElementById("btnRefresh").disabled = false;
}
