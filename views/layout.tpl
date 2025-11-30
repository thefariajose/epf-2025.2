<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Bottle - {{title or 'Sistema'}}</title>

    <!-- CSS -->
    <link rel="stylesheet" href="/static/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* -----------------------------------------
           LAYOUT GERAL
        ----------------------------------------- */
        body {
            margin: 0;
            padding: 0;
            background: #f5f6fa;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #333;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 30px auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 3px 7px rgba(0, 0, 0, 0.1);
        }

        footer {
            text-align: center;
            margin: 40px 0;
            color: #888;
            font-size: 0.9rem;
        }

        /* -----------------------------------------
           MENU SUPERIOR
        ----------------------------------------- */
        nav {
            background-color: #3498db;
            padding: 1rem;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 0;
            padding: 0;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 8px 14px;
            border-radius: 6px;
            transition: 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        nav a:hover {
            background-color: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
        }

        nav a i {
            font-size: 1.1rem;
        }
        
        /* Estilo específico para o botão de logout */
        .btn-logout {
            background-color: #c0392b; /* Vermelho para indicar saída */
        }
        .btn-logout:hover {
            background-color: #e74c3c !important;
        }
    </style>

</head>
<body>

    <nav>
        <ul>
            <li>
                <a href="/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Sair
                </a>
            </li>
        </ul>
    </nav>

    <div class="container">
        {{!base}}
    </div>

    <footer>
        <p>&copy; 2025, Meu Projeto. Todos os direitos reservados.</p>
    </footer>

    <script src="/static/js/main.js"></script>
</body>
</html>
