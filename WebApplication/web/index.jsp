<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
      rel="stylesheet"
    />
    <link rel="icon" type="image/x-icon" href="./public/assets/favicon.ico" />
    <link rel="stylesheet" href="./public/css/styles.css" />
    <title>Eletronics Store</title>
  </head>

  <body id="register">
    <div class="conteiner">
      <header class="header-main">
        <div class="header-item-container">
          <div>
            <a href="#"
              ><img
                src="./public/assets/logo.svg"
                alt="Logo AgendaTennis"
                class="logo"
            /></a>
          </div>
          <div class="address-delivery-info">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="lucide lucide-map-pin"
            >
              <path
                d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"
              />
              <circle cx="12" cy="10" r="3" />
            </svg>
            <div class="address-details texto-normal">
              <span>Enviar para <c:out value="${sessionScope.currentSessionUser.name}" /></span>
              <c:out value="${sessionScope.currentSessionUser.address}" />  <c:out value="${sessionScope.currentSessionUser.zipcode}" />
            </div>
          </div>
        </div>

        <div class="header-item-container search-products">
          <form action="" method="get">
            <input
              class="input-padrao"
              type="search"
              name="q"
              id="q"
              placeholder="Buscar produtos"
            />
            <button type="submit" class="botao">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="lucide lucide-search"
              >
                <circle cx="11" cy="11" r="8" />
                <path d="m21 21-4.3-4.3" />
              </svg>
            </button>
          </form>
        </div>
        <div class="header-item-container">
          <div class="account">
            <a href="./listar-aulas.html">
              <span>Olá, <c:out value="${sessionScope.currentSessionUser.name}" /></span>Acesse sua conta
            </a>
          </div>
          <div class="cart texto-normal">
            <a href="">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="lucide lucide-shopping-cart"
              >
                <circle cx="8" cy="21" r="1" />
                <circle cx="19" cy="21" r="1" />
                <path
                  d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"
                /></svg
              >Carrinho
            </a>
          </div>
        </div>
      </header>
      <main></main>
    </div>
  </body>
</html>
