window.addEventListener('message', function (event) {
    if (event.data.action === "openDialog") {
        document.getElementById("dialog").style.display = "block";
    }
    if (event.data.action === "closeDialog") {
        document.getElementById("dialog").style.display = "none";
    }
});

function selectOption(option) {
    fetch(`https://${GetParentResourceName()}/selectOption`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ option: option })
    });
    document.getElementById("dialog").style.display = "none";
}

function closeUI() {
    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: "POST",
        headers: { "Content-Type": "application/json" }
    });
    document.getElementById("dialog").style.display = "none";
}
