var onHit = function() {
    $.ajax({
        url: "/hit",
        type: "get",
        datatype: "json",
        success: function(data) {
            document.getElementById("foo").innerHTML = data.text;
        },
        failure: function() {
            console.log("there was an ajax error trying to hit the games controller.");
        }
    });
}

var onStand = function() {
    $.ajax({
        url: "/stand",
        type: "get",
        datatype: "json",
        success: function(data) {
            document.getElementById("foo").innerHTML = data.text;
        },
        failure: function() {
            console.log("there was an ajax error trying to hit the games controller.");
        }
    });
}
