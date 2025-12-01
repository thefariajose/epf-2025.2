<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CarRENT - {{title or 'Sistema'}}</title>

    <link rel="stylesheet" href="/static/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* -----------------------------------------
           DEFINIÇÃO GLOBAL DA MARCA
        ----------------------------------------- */
        :root {
            --primary-color: #163b65; /* Azul Marinho (Car) */
            --secondary-color: #2c5282;
            --accent-color: #e67e22;  /* Laranja (RENT) */
            --bg-color: #f4f6f9;      /* Fundo cinza claro */
            --text-color: #333;
        }

        /* -----------------------------------------
           ESTRUTURA DA PÁGINA (Sticky Footer)
        ----------------------------------------- */
        body {
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            font-family: "Segoe UI", "Roboto", Helvetica, Arial, sans-serif;
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* O Main Content agora ocupa o espaço restante, empurrando o footer para baixo */
        .main-wrapper {
            flex: 1; 
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* -----------------------------------------
           NAVBAR / MENU SUPERIOR
        ----------------------------------------- */
        .navbar {
            background-color: var(--primary-color);
            padding: 0 20px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        /* Logo na Navbar */
        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
        }
        
        .navbar-brand img {
            height: 40px;
            width: auto;
        }

        /* Links do Menu */
        .nav-links {
            display: flex;
            gap: 20px;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-link {
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            padding: 8px 12px;
            border-radius: 4px;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link:hover {
            color: white;
            background-color: rgba(255,255,255,0.1);
        }

        .nav-link.active {
            background-color: var(--accent-color);
            color: white;
        }

        /* Botão Sair */
        .btn-logout {
            background-color: rgba(0,0,0,0.2);
            padding: 8px 15px;
            border-radius: 6px;
            color: #fff !important;
            font-size: 0.9rem;
        }
        .btn-logout:hover {
            background-color: #c0392b; /* Vermelho */
        }

        /* -----------------------------------------
           FOOTER
        ----------------------------------------- */
        footer {
            background-color: #fff;
            text-align: center;
            padding: 20px;
            color: #888;
            font-size: 0.9rem;
            border-top: 1px solid #e1e4e8;
            margin-top: auto; /* Garante que fique no fim da página */
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="/" class="navbar-brand">
            <span>Car<span style="color: var(--accent-color);">RENT</span></span>
        </a>


        <ul class="nav-links">
            <li>
                <a href="/logout" class="nav-link btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Sair
                </a>
            </li>
        </ul>
    </nav>

    <div class="main-wrapper">
        {{!base}}
    </div>

    <footer>
        <p>&copy; 2025 <strong>CarRENT</strong>. Drive Your Adventure.</p>
    </footer>

    <script src="/static/js/main.js"></script>
    
    <script>
        // Script para destacar o link ativo
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            // Verifica se o href do link é a rota atual
            if(link.getAttribute('href') === currentPath) {
                link.classList.add('active');
            }
        });
    </script>
</body>
</html>