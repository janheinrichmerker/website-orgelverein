const lightBoxClass = "light-box";
const lightBoxElements = Array.from(
    document.querySelectorAll("body > main > article > section a > img")
);
lightBoxElements.forEach(img => {
    const a = img.parentElement;
    if (a.className.split(" ").indexOf(lightBoxClass) === -1) {
        a.className += " " + lightBoxClass;
    }
    // Only copy description, if not already set.
    if (a.hasAttribute("data-description") !== true) {
        const description = img.alt;
        a.setAttribute("data-description", description);
    }
});
GLightbox({
    selector: "light-box"
});