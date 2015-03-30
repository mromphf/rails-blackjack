var dealerScore = 0
var playerScore = 0

$(document).ready(function () {
    setTimeout(function () {playerHit()}, 500);
    setTimeout(function () {dealerHit()}, 1000);
    setTimeout(function () {playerHit()}, 1500);
    setTimeout(function () {dealerHit()}, 2000);
    setTimeout(function () {enableControls()}, 2500);
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

function dealerTriesToWin() {
    if (dealerScore <= playerScore && dealerScore < 21) {
        dealerHit();
        setTimeout(function () {dealerTriesToWin()}, 500);
    }
    else {
       evaluateResult(); 
    }
}

function playerCallback(data) {
    playerScore = data.score
    document.getElementById("playerScore").innerHTML = "Score: " + playerScore
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(data.text);
    node.appendChild(textnode);
    document.getElementById("playerCards").appendChild(node);
    if ( data.bust ) {
        disableControls();
        document.getElementById("playerScore").innerHTML = "BUST!";
        document.getElementById("foo").innerHTML = "Dealer wins..."
        document.getElementById("btnRefresh").disabled = false;
    } 
}

function dealerCallback(data) {
    dealerScore = data.score
    document.getElementById("dealerScore").innerHTML = "Score: " + dealerScore
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(data.text);
    node.appendChild(textnode);
    document.getElementById("dealerCards").appendChild(node);
    if (data.bust) {
        document.getElementById("foo").innerHTML = "<strong>You win!!</strong>"
        evaluateResult();
    }
}

function evaluateResult() {
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

function disableControls() {
    document.getElementById("btnHit").disabled = true;
    document.getElementById("btnStand").disabled = true;
}

function enableControls() {
    document.getElementById("btnHit").disabled = false;
    document.getElementById("btnStand").disabled = false;
}
