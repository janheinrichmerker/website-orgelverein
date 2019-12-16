const content = document.querySelector("body > main > article");
const links = content.getElementsByTagName("a");

for (let i = 0, linksLength = links.length; i < linksLength; i++) {
    if (links[i].hostname !== window.location.hostname) {
        links[i].target = "_blank";
    }
    else if (links[i].href.split(".").pop().toLowerCase() === "pdf") {
        links[i].target = "_blank";
    }
}
