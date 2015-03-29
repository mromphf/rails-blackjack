var onHit = function() {
    ajaxCall("/hit");
}

var onStand = function() {
    //ajaxCall("/stand")
    document.getElementById("foo").innerHTML = "You stand...";
    disableControls();
}

function ajaxCall(url) {
    $.ajax({
        url: url,
        type: "get",
        datatype: "json",
        success: onSuccess,
        failure: onFailure
    });
}

function onSuccess(data) {
    document.getElementById("score").innerHTML = "Score: " + data.score;
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(data.text);
    node.appendChild(textnode);
    document.getElementById("cards").appendChild(node);
    if (roundIsOver(data)) {
        disableControls();
    }
    if ( data.blackjack ) {
        document.getElementById("score").innerHTML = "Blackjack!!";
    } else if ( data.bust ) {
        document.getElementById("score").innerHTML = "BUST!";
    } 
}

function onFailure() {
    console.log("there was an ajax error trying to hit the games controller.");
}

function disableControls() {
    document.getElementById("btnHit").disabled = true;
    document.getElementById("btnStand").disabled = true;
}

function roundIsOver(data) {
   return (data.blackjack) || (data.bust);
}
