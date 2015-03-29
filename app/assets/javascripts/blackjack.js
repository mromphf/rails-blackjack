var onHit = function() {
  ajaxCall("/hit")
}

var onStand = function() {
  ajaxCall("/stand")
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
    //document.getElementById("foo").innerHTML = data.text;
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(data.text);
    node.appendChild(textnode);
    document.getElementById("cards").appendChild(node);
}

function onFailure() {
    console.log("there was an ajax error trying to hit the games controller.");
}

