const tableActionRemoveList = document.querySelectorAll(".table-action-remove");
const modalContainer = document.getElementById("modal-container");
const btnModalClose = document.querySelector(".modal-actions .close");

tableActionRemoveList.forEach((el) => {
  el.addEventListener("click", (e) => {
    modalContainer.querySelector(".modal-details").innerText =
      e.target.dataset.detail;
    modalContainer.querySelector(".submit-delete").href =
      "/api/users/remove?id=" + e.target.dataset.id;

    modalContainer.classList.add("modal-open");
  });
});

btnModalClose.addEventListener("click", (e) => {
  modalContainer.classList.remove("modal-open");
});
