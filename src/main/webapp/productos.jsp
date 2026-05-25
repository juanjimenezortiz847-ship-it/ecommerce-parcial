<%@page import="java.util.List"%>
<%@page import="model.Producto"%>

<%
List<Producto> lista =
        (List<Producto>) request.getAttribute("lista");
%>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Productos - Skynet</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

    <link rel="stylesheet" href="css/producto.css">

</head>

<body>

<!-- AUDIO -->
<audio id="globalAudio" hidden></audio>

<!-- SIDEBAR -->
<aside class="sidebar">

    <div class="sidebar-dots">
        <span></span>
        <span></span>
        <span></span>
    </div>

    <a href="<%= request.getContextPath() %>/index.jsp"
       class="sidebar-logo">

        Skynet

    </a>

    <div class="nav-group">

        <div class="nav-group-label">
            Categorias
        </div>

            Todos

        </a>

        <a href="productos?categoria=tecnologia"
           class="nav-link-s">

            Tecnologia

        </a>

        <a href="productos?categoria=electrodomestico"
           class="nav-link-s">

            Electrodomesticos

        </a>

    </div>

    <div class="nav-group">

        <div class="nav-group-label">
            Subcategorias
        </div>

        <a href="<%= request.getContextPath() %>/productos?sub=celulares"
           class="nav-link-s">

            Celulares

        </a>

        <a href="<%= request.getContextPath() %>/productos?sub=computadores"
           class="nav-link-s">

            Computadores

        </a>

        <a href="<%= request.getContextPath() %>/productos?sub=tablets"
           class="nav-link-s">

            Tablets

        </a>

        <a href="<%= request.getContextPath() %>/productos?sub=accesorios"
           class="nav-link-s">

            Accesorios

        </a>

        <a href="<%= request.getContextPath() %>/productos?sub=refrigeradores"
           class="nav-link-s">

            Refrigeradores

        </a>

        <a href="<%= request.getContextPath() %>/productos?sub=licuadoras"
           class="nav-link-s">

            Licuadoras

        </a>

    </div>

    <div class="sidebar-bottom">

        <a href="music/cassette.jsp"
           class="skynet-fm-</style>btn">

            <i class="bi bi-music-note-beamed"></i>

            Skynet FM

        </a>
</style>
    </div>

</aside>

<!-- MAIN -->
<main class="main-content">

    <!-- TOPBAR -->
    <header class="topbar">

        <form class="search-form"
              action="<%= request.getContextPath() %>/productos"
              method="get">

            <input type="search"
                   name="buscar"
                   class="search-input"
                   placeholder="Buscar productos..."
                   value="${param.buscar}">

            <button type="submit"
                    class="search-btn">

                Buscar

            </button>

        </form>

        <div class="topbar-right">

            <a href="index.jsp"
               class="icon-btn">

                <i class="bi bi-house"></i>
                Inicio

            </a>

            <a href="<%= request.getContextPath() %>/CarritoServlet"
               class="icon-btn">

                <i class="bi bi-cart-fill"></i>
                Carrito

            </a>

            <a href="<%= request.getContextPath() %>/music/cassette.jsp"
               class="icon-btn">

                <i class="bi bi-music-note-beamed"></i>

            </a>

        </div>

    </header>

    <!-- PRODUCTOS -->
    <section class="productos-wrap">

        <div class="productos-header">

            <h1 class="productos-title">
                Explorar Productos
            </h1>

            <span class="productos-count">

                <%= (lista != null)
                    ? lista.size() + " productos"
                    : "0 productos" %>

            </span>

        </div>

        <div class="productos-grid">

            <%
            if (lista != null && !lista.isEmpty()) {

                for (Producto p : lista) {

                    double precioOriginal =
                            p.getPrecio();

                    double precioFinal =
                            precioOriginal -
                            (precioOriginal *
                            p.getDescuento() / 100);

                    boolean oferta =
                            p.getDescuento() > 0;
            %>

            <article class="product-card <%= oferta ? "oferta" : "" %>">

                <% if (oferta) { %>

                    <span class="badge-oferta">

                        -<%= (int)p.getDescuento() %>% OFF

                    </span>

                <% } %>

                <% if (p.getImagen() != null &&
                       !p.getImagen().trim().isEmpty()) { %>

                    <div class="product-img">

                        <img src="<%= p.getImagen() %>"
                             alt="<%= p.getNombre() %>"

                             onerror="
                             this.onerror=null;
                             this.parentElement.innerHTML=
                             '<div class=\'product-img-fallback\'><i class=\'bi bi-box\'></i></div>';
                             ">

                    </div>

                <% } else { %>

                    <div class="product-img-fallback">

                        <i class="bi bi-box"></i>

                    </div>

                <% } %>

                <div class="product-info">

                    <h2 class="product-name">

                        <%= p.getNombre() %>

                    </h2>

                    <% if (oferta) { %>

                        <div class="product-price-old">

                            $<%= String.format("%,.0f", precioOriginal) %>

                        </div>

                        <div class="product-price-oferta">

                            $<%= String.format("%,.0f", precioFinal) %>

                        </div>

                        <div class="product-oferta-label">

                            Oferta por tiempo limitado

                        </div>

                    <% } else { %>

                        <div class="product-price">

                            $<%= String.format("%,.0f", precioOriginal) %>

                        </div>

                    <% } %>

                    <span class="product-cat">

                        <%= p.getCategoria() %>

                    </span>

                    <span class="product-sub">

                        <%= p.getSubcategoria() %>

                    </span>

                    <a href="<%= request.getContextPath() %>/CarritoServlet?action=add&id=<%= p.getId() %>"
                       class="btn-agregar">

                        <i class="bi bi-cart-plus"></i>

                        Agregar al carrito

                    </a>

                </div>

            </article>

            <%
                }

            } else {
            %>

            <div class="empty-state">

                <i class="bi bi-search"></i>

                <p>No se encontraron productos</p>

            </div>

            <%
            }
            %>

        </div>

    </section>

</main>

<!-- MINI PLAYER -->
<div class="mini-player">

    <div class="mini-song-info">

        <div class="mini-thumb">

            <i class="bi bi-music-note-beamed"></i>

        </div>

        <div>

            <div class="mini-title">

                Hope Is The Thing

            </div>

            <div class="mini-artist">

                SKYNET FM

            </div>

        </div>

    </div>

    <div class="mini-controls">

        <button class="mini-play-btn"
                onclick="miniToggle()">

            <i id="miniPlayIcon"
               class="bi bi-play-fill"></i>

            <i id="miniPauseIcon"
               class="bi bi-pause-fill"
               style="display:none;"></i>

        </button>

    </div>

    <div class="mini-right">

        <a href="music/cassette.jsp"
           class="mini-go-btn">

            Abrir reproductor

        </a>

    </div>

</div>

<script>

/* =========================
   AUDIO
========================= */

const audioEl =
    document.getElementById("globalAudio");

/* =========================
   CANCION DEFAULT
========================= */

const defaultSong = {

    src: "audio/hope_is_the_thing.mp3",

    title: "Hope Is The Thing",

    artist: "SKYNET FM"
};

/* =========================
   CARGAR DATOS
========================= */

let savedSong =
    JSON.parse(
        localStorage.getItem("skynet-song")
    );

if (!savedSong) {

    savedSong = defaultSong;
}

audioEl.src =
    savedSong.src;

document.querySelector(".mini-title").textContent =
    savedSong.title;

document.querySelector(".mini-artist").textContent =
    savedSong.artist;

/* =========================
   RESTAURAR ESTADO
========================= */

const savedProgress =
    localStorage.getItem("skynet-progress");

audioEl.addEventListener("loadedmetadata", () => {

    if (savedProgress) {

        audioEl.currentTime =
            parseFloat(savedProgress);
    }

    if (
        localStorage.getItem("skynet-playing")
        === "true"
    ) {

        audioEl.play().catch(() => {});
    }
});

/* =========================
   PLAY / PAUSE
========================= */

function miniToggle() {

    if (audioEl.paused) {

        audioEl.play();

    } else {

        audioEl.pause();
    }
}

/* =========================
   ICONOS
========================= */

audioEl.addEventListener("play", () => {

    localStorage.setItem(
        "skynet-playing",
        "true"
    );

    document.getElementById("miniPlayIcon").style.display =
        "none";

    document.getElementById("miniPauseIcon").style.display =
        "inline-block";
});

audioEl.addEventListener("pause", () => {

    localStorage.setItem(
        "skynet-playing",
        "false"
    );

    document.getElementById("miniPlayIcon").style.display =
        "inline-block";

    document.getElementById("miniPauseIcon").style.display =
        "none";
});

/* =========================
   GUARDAR TIEMPO
========================= */

audioEl.addEventListener("timeupdate", () => {

    localStorage.setItem(
        "skynet-progress",
        audioEl.currentTime
    );
});

/* =========================
   TOAST CARRITO
========================= */

const params =
    new URLSearchParams(window.location.search);

if (params.get("agregado")) {

    const notif =
        document.createElement("div");

    notif.className =
        "toast-cart";

    notif.innerHTML = `
        <i class="bi bi-check-circle-fill"></i>
        Producto agregado al carrito
    `;

    document.body.appendChild(notif);

    setTimeout(() => {

        notif.remove();

    }, 2500);

    history.replaceState(
        {},
        '',
        'productos'
    );
}

</script>

</body>
</html>