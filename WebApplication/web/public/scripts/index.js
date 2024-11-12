const switcherThemeInput = document.querySelector("#switch-theme");
const htmlContainer = document.querySelector("html");

document.addEventListener("DOMContentLoaded", () => {
    let switchTheme = localStorage.getItem("switch-theme");
    htmlContainer.dataset.theme = switchTheme;
    switcherThemeInput.checked = switchTheme === "dark" ? true : false;
});

switcherThemeInput.addEventListener("change", (e) => {
    e.target.checked ? htmlContainer.dataset.theme = "dark" : htmlContainer.dataset.theme = "light";
    localStorage.setItem("switch-theme", htmlContainer.dataset.theme);
});


const removeUserInput = document.querySelectorAll(".remove-user");
const removeUserModel = document.getElementById("remove-user-modal");
const buttonModalClose = document.querySelector(".modal-actions .close");

removeUserInput.forEach((el) => {
    el.addEventListener("click", (e) => {
        removeUserModel.querySelector(".modal-user-email").innerText = e.target.dataset.email;
        removeUserModel.querySelector(".submit-delete").href = "/api/admin/users/remove?id=" + e.target.dataset.id;


        removeUserModel.classList.add("modal-open");
    });
});

buttonModalClose.addEventListener("click", (e) => {
    removeUserModel.classList.remove("modal-open");
});