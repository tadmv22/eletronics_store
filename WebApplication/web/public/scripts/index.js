const switcherThemeInput = document.querySelector("#switch-theme");
const htmlContainer = document.querySelector("html");

document.addEventListener("DOMContentLoaded", () => {
  let switchTheme = localStorage.getItem("switch-theme");
  htmlContainer.dataset.theme = switchTheme;
  switcherThemeInput.checked = switchTheme === "dark" ? true : false;
});

switcherThemeInput.addEventListener("change", (e) => {
  e.target.checked
    ? (htmlContainer.dataset.theme = "dark")
    : (htmlContainer.dataset.theme = "light");
  localStorage.setItem("switch-theme", htmlContainer.dataset.theme);
});
