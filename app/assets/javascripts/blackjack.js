var onHit = function() {
    $.ajax({
        url: "/hit",
        type: "get",
        datatype: "json",
        success: onSuccess,
        failure: onFailure
    });
}

var onStand = function() {
    $.ajax({
        url: "/stand",
        type: "get",
        datatype: "json",
        success: onSuccess,
        failure: onFailure
    });
}

function onSuccess(data) {
    document.getElementById("foo").innerHTML = data.text;
}

function onFailure() {
    console.log("there was an ajax error trying to hit the games controller.");
}
