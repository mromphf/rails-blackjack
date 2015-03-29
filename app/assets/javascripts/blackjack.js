$(document).ready(function () {
    setTimeout(function () {onHit()}, 500);
    setTimeout(function () {dealerHit()}, 1000);
    setTimeout(function () {onHit()}, 1500);
    setTimeout(function () {dealerHit()}, 2000);
    setTimeout(function () {enableControls()}, 2500);
});

function onHit() {
    $.ajax({
        url: "/player_hit",
        type: "get",
        datatype: "json",
        success: onSuccess,
        failure: onFailure
    });
}

function dealerHit() {
    $.ajax({
        url: "/dealer_hit",
        type: "get",
        datatype: "json",
        success: onDealerSuccess,
        failure: onFailure
    });
}

function onStand () {
    document.getElementById("foo").innerHTML = "You stand...";
    disableControls();
}

function onSuccess(data) {
    document.getElementById("playerScore").innerHTML = "Score: " + data.score;
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(data.text);
    node.appendChild(textnode);
    document.getElementById("playerCards").appendChild(node);
    if (roundIsOver(data)) {
        disableControls();
    }
    if ( data.blackjack ) {
        document.getElementById("playerScore").innerHTML = "Blackjack!!";
    } else if ( data.bust ) {
        document.getElementById("playerScore").innerHTML = "BUST!";
    } 
}

function onDealerSuccess(data) {
    document.getElementById("dealerScore").innerHTML = "Score: " + data.score;
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(data.text);
    node.appendChild(textnode);
    document.getElementById("dealerCards").appendChild(node);
}

function onFailure() {
    console.log("there was an ajax error trying to hit the games controller.");
}

function disableControls() {
    document.getElementById("btnHit").disabled = true;
    document.getElementById("btnStand").disabled = true;
}

function enableControls() {
    document.getElementById("btnHit").disabled = false;
    document.getElementById("btnStand").disabled = false;
}

function roundIsOver(data) {
   return (data.blackjack) || (data.bust);
}
